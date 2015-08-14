//
//  TPOrgInfoBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-10.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPRemoteBO.h"

@interface TPOrgInfoBO : TPRemoteBO

// 机构ID
@property (nonatomic, strong) NSString *orgid;
// 机构Code
@property (nonatomic, strong) NSString *orgcode;
// 父机构Id
@property (nonatomic, strong) NSString *parentid;
// 机构名称
@property (nonatomic, strong) NSString *orgname;
// 机构层级
@property (nonatomic, strong) NSString *orglevel;
@end
