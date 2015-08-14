//
//  TPParticipantBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPRemoteBO.h"

@interface TPParticipantBO : TPRemoteBO
// 机构ID
@property (nonatomic, strong) NSString *orgid;
// 部门
@property (nonatomic, strong) NSString *deptcode;
// 职务
@property (nonatomic, strong) NSString *degreecode;
// 人员姓名
@property (nonatomic, strong) NSString *name;
// 手机
@property (nonatomic, strong) NSString *phone;
// 座机
@property (nonatomic, strong) NSString *htel;
// 头像ID
@property (nonatomic, strong) NSString *fileId;
@end
