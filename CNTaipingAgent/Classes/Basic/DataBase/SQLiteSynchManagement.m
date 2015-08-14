//
//  SQLiteSynchManagement.m
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-9-2.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "SQLiteSynchManagement.h"
#import "TPSqliteSynBO.h"

#import "sqlite3.h"

@interface SQLiteSynchManagement ()<TPRemoteDelegate> {
    NSDictionary* dic;
    NSArray* totleTable;
//    //如果同步失败，尝试重新同步次数。
//    int   retryTimes;
    NSTimer* synchTimer;
}
@property(nonatomic, assign)BOOL  hasSynched;
@end

static SQLiteSynchManagement* g_SQLiteSynchInstance = nil;
@implementation SQLiteSynchManagement
@synthesize hasSynched;


+ (SQLiteSynchManagement *)instance {
	@synchronized(self) {
		if (nil == g_SQLiteSynchInstance) {
			g_SQLiteSynchInstance = [[SQLiteSynchManagement alloc] init];
		}
	}
	return g_SQLiteSynchInstance;
}

+ (BOOL)hasSynched {
    return [self instance].hasSynched;
}

- (id) init {
    if (self = [super init]) {
        //拷贝初始化数据库
        NSString* path = ConfigPath(@"db.sqlite");
        RemoveFile(path);
        if (!ExistAtPath(path)) {
            NSString* contentFile = ResourcePath(@"db.sqlite");
            NSData *data = [NSData dataWithContentsOfFile:contentFile];
            SaveFile(path, data);
        }
        path = ConfigPath(@"message.sqlite");
        if (!ExistAtPath(path)) {
            NSString* contentFile = ResourcePath(@"message.sqlite");
            NSData *data = [NSData dataWithContentsOfFile:contentFile];
            SaveFile(path, data);
        }
        
        NSString *dbPath = [[SandboxFile GetDocumentPath] stringByAppendingString:@"/"];
        
        [DataFactory setDatabasePath:dbPath];
        
        synchTimer = [NSTimer scheduledTimerWithTimeInterval:30
                                                      target:self
                                                    selector:@selector(onSynchSQLite:)
                                                    userInfo:nil
                                                    repeats:YES];
    }
    return self;
}
- (void) startSynch {

}

- (void) onSynchSQLite:(NSTimer*)timer {
    if (!self.hasSynched) {
        [self startSynch];
    } else {
        [synchTimer invalidate];
        synchTimer = nil;
    }
}

- (NSDictionary*) configItem:(NSString*)tableName {
    if (nil == tableName) {
        return nil;
    }
    if (nil == dic) {
        dic = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"DBConfig.plist")];
    }
    for (NSDictionary* item in dic[@"dataCaches/db.sqlite"]) {
        if ([item[@"tableName"] isEqualToString:tableName] ||
            [item[@"tableName"] isEqualToString:[tableName lowercaseString]]) {
            return item;
        }
    }
    return nil;
}

- (void) remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData {
    if (0 == actionTag) {
        NSMutableString* tableName = [[NSMutableString alloc] init];
        NSMutableString* refreshTime = [[NSMutableString alloc] init];
        totleTable = responsData[@"tableDate"];
        for (NSDictionary* table in totleTable) {
            NSString* tbName = table[@"table_name"];
            [tableName appendFormat:@"%@%@", tableName.length>0?@"#":@"", tbName];
            
            NSDictionary* item = [self configItem:tbName];
            if (nil != item) {
                [refreshTime appendFormat:@"%@%@", refreshTime.length>0?@"#":@"",
                 [self appendString:tbName]];
            }
        }
        if (tableName.length > 0 && refreshTime.length > 0) {
            NSString *param = [@{@"sAction":@"loadBatchTableData",
                                 @"tableNames":tableName,
                                 @"refreshTimes":refreshTime}
                               JSONEncoder];
            [TPRemote doAction:100 type:@"码表总表同步"
                  interfaceType:RemoteInterfaceTypeBase
                     requestUrl:URL_sqliteSynch
                       delegate:self
                      parameter:param, nil];
        } else {
            self.hasSynched = YES;
        }
    } else if (100 == actionTag) {
        self.hasSynched = YES;
        [self updateTablesData:responsData];
    }
}
- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message {

}

- (id) appendString:(NSString*)tableName {
    __block TPSqliteSynBO* bo = nil;
    [DB searchWhere:@{@"table_name":tableName} orderBy:nil offset:0 count:1
              Class:[TPSqliteSynBO class] callback:^(NSArray * records) {
                  if (records.count > 0) {
                      bo = records[0];
                  }
    }];

    if (nil == bo) {
        return @"0";
    } else {
        return bo.refresh_time;
    }
}

- (void) updateTablesData:(id)datas {
    __block NSMutableArray* tbDatas = [NSMutableArray array];
    [DB searchWhere:nil orderBy:nil offset:0 count:1000 Class:[TPSqliteSynBO class] callback:^(NSArray * records) {
        [tbDatas addObjectsFromArray:records];
    }];
    for (NSDictionary* item in datas[@"tableDatas"]) {
        NSDictionary* record = [self configItem:item[@"tableName"]];
        BOOL result = [self updateTableData:item[@"tableData"]
                                    boClass:NSClassFromString(record[@"modelName"])
                                   withFlag:[item[@"flag"] intValue]];
        if (!result) {//子表相应处理事务失败，不更新时间
            continue;
        }
        TPSqliteSynBO* bo = [self getSqliteSynBO:item[@"tableName"] boList:tbDatas];
        if (nil == bo) {
            bo = [[TPSqliteSynBO alloc] initWithDictionary:item];
            bo.transStyle = TransactionStyleInsert;
            [tbDatas addObject:bo];
        } else {
            bo.refresh_time = [self getRefreshTime:item[@"tableName"]];
            bo.transStyle = TransactionStyleUpdate;
        }
        [DB transactionToDB:@[bo]];
    }
}

- (BOOL) updateTableData:(NSArray*)datas boClass:(Class)class withFlag:(int)flag {
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:datas.count];
    if (1 == flag) {//全量插入，也就是说要把原来的全部删除后重新插入
        NSObject *bo = [[class alloc] initWithDictionary:nil];
        ((LKModelBase*)bo).transStyle = TransactionStyleClear;
        [array addObject:bo];
    }
    
    for (NSDictionary* item in datas) {
        NSObject *bo1 = [[class alloc] initWithDictionary:item];
        ((LKModelBase*)bo1).transStyle = TransactionStyleDelete;
        [array addObject:bo1];
        NSObject *bo2 = [[class alloc] initWithDictionary:item];
        ((LKModelBase*)bo2).transStyle = TransactionStyleInsert;
        [array addObject:bo2];
    }
    //1:全量 2:增量（
    if (array.count > 0) {
        return [DB transactionToDB:array];
    } else {
        return NO;
    }
}

- (NSString*) getRefreshTime:(NSString*)tableName {
    for (NSDictionary* item in totleTable) {
        if ([item[@"table_name"] isEqualToString:tableName]) {
            return item[@"refresh_time"];
        }
    }
    return @"1";
}

- (TPSqliteSynBO*) getSqliteSynBO:(NSString*)tableName boList:(NSArray*)lists {
    for (TPSqliteSynBO* item in lists) {
        if ([item.table_name isEqualToString:tableName]) {
            return item;
        }
    }
    return nil;
}

- (void) startWaitCursor:(int)actionTag{}
- (void) stopWaitCursor:(int)actionTag{}


@end
