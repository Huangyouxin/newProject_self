//
//  TPReportBO.h
//  CNTaipingAgent
//
//  Created by song on 14-10-22.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

@interface TPReportBO : LKModelBase

@property(nonatomic, assign)int  row;
// 标题顺序
@property(nonatomic, assign)int orderby;
@property(nonatomic, assign)NSString  *type;
@property(nonatomic, strong)NSString*  title;
@property(nonatomic, strong)NSString*  orgid;
@property(nonatomic, strong)NSString*  value;
@property(nonatomic, strong)NSString*  parentTitle;
@property(nonatomic, strong)NSString*  key;
@end
