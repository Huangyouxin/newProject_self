//
//  TPDBUUID.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-13.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

@interface TPDBUUID : LKModelBase
@property(nonatomic, strong) NSString *UUID;
@property(nonatomic, strong) NSString *CODE;
@end
