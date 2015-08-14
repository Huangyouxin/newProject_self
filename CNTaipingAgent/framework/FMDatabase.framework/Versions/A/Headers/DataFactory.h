//
//  DataFactory.h
//
//
//  Created by mac  on 12-12-7.
//  Copyright (c) 2012年 sky. All rights reserved.

#import <Foundation/Foundation.h>
#import "SandboxFile.h"


#define DB    [DataFactory shardFactory]

/**
*	@brief	数据库操作类场
*/
@interface  DataFactory : NSObject

+(void)setDatabasePath:(NSString*)path;
+(DataFactory *)shardFactory;
//设置加密密码
/*调用方法
 多数情况下客户端应用只有一个数据库，但有时可能会有多个，为了个不同的数据库做不同的密码配置本处
 用数据字典形式设置。调用形式如下：
 [DataFactory setCrypKey:@{@"dataCaches/cache.sqlite":@"12345678",
                           @"dataCaches/data.sqlite":@"132333"}];
 其中：dataCaches/cache.sqlite是在DBConfig.plist里面配置的
 */
+(void)setCrypKey:(NSDictionary*)keys;

//添加数据到数据库，如果数据库已有相关数据，则只做数据更新
-(void)addDataToDB:(id)data;


//添加数据（增）
-(void)insertToDB:(id)model;
//修改数据（改），primaryKey必须配置，修改是根据primaryKey的值来定位要修改的条
-(void)updateToDB:(id)model;
//删除单条数据（删）,primaryKey必须配置，删除是根据primaryKey的值来定位要删除的条
-(void)deleteToDB:(id)model;
//删除表的数据（删）
-(void)clearTableData:(Class)modelClass;
//根据条件删除数据（删）
-(void)deleteWhereData:(NSDictionary *)where Class:(Class)modelClass;
//查找数据（查）
-(void)searchWhere:(NSDictionary *)where
           orderBy:(NSString *)columeName
            offset:(int)offset
             count:(int)count
             Class:(Class)modelClass
          callback:(void(^)(NSArray* results))block;
-(void)searchClass:(Class)modelClass
          callback:(void(^)(NSArray* results))block;

//查找数据（查）,可进行联合查询
-(void)searchSQL:(NSString *)sql
             Class:(Class)modelClass
          callback:(void(^)(NSArray* results))block;

//处理事务
-(BOOL)transactionToDB:(NSArray*)models;
@end
