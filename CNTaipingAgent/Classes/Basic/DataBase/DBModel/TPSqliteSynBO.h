//
//  TPSqliteSynBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-13.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

@interface TPSqliteSynBO : LKModelBase
@property(nonatomic, assign)int        table_id;
@property(nonatomic, strong)NSString*  table_name;
@property(nonatomic, strong)NSString*  chs_name;
@property(nonatomic, strong)NSString*  refresh_time;
@property(nonatomic, strong)NSString*  flag;
@end
