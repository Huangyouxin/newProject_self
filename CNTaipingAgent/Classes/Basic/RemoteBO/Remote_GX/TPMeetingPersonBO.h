//
//  TPMeetingPersonBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

/*
 * 参会人员
 */

#import <UIKit/UIKit.h>

@interface TPMeetingPersonBO : TPRemoteBO
// 参会人员ID
@property (nonatomic, strong) NSNumber *Id;
// 机构ID
@property (nonatomic, copy) NSString *orgid;
// 部门
@property (nonatomic, copy) NSString *deptCode;
// 部门名称
@property (nonatomic, copy) NSString *deptName;
// 职务名称
@property (nonatomic, copy) NSString *degreeName;
// 职务
@property (nonatomic, copy) NSString *degreecode;
// 人员姓名
@property (nonatomic, copy) NSString *name;
// 手机
@property (nonatomic, copy) NSString *phone;
// 座机
@property (nonatomic, copy) NSString *htel;
// 头像ID
@property (nonatomic, copy) NSString *fileId;
// 性别
@property (nonatomic, copy) NSString *gender;
// 报名（回执）状态
@property (nonatomic, copy) NSString *status;
// 参会（签到）状态
@property (nonatomic, copy) NSString *pstatus;
// 参会人员
@property (nonatomic, copy) NSString *userName;
// 人员类型
@property (nonatomic, copy) NSString *personType;
// 签到情况 Y-签到,N-未签到
@property (nonatomic, copy) NSString *signin;
@end
