//
//  TPDBDictionaryInfo.h
//  CNTaipingAgent
//
//  Created by Stone on 14/10/29.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

@interface TPDBDictionaryInfo : LKModelBase

// 字典类型
@property (nonatomic, copy) NSString *type;
// 字典名称
@property (nonatomic, copy) NSString *name;
// 字典Code
@property (nonatomic, copy) NSString *code;
@end
