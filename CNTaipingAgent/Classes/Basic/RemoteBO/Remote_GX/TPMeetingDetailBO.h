//
//  TPMeetingDetailBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

/*
 * 会议详情
 */

#import "TPRemoteBO.h"

@interface TPMeetingDetailBO : TPRemoteBO

// 会议ID
@property (nonatomic, strong) NSNumber *Id;
// 会议编码
@property (nonatomic, strong) NSString *meetNumber;
// 创建时间
@property (nonatomic, strong) NSDate *appDt;
// 申请部门
@property (nonatomic, strong) NSString *appDeptName;
// 申请人
@property (nonatomic, strong) NSString *appUserName;
// 联系电话
@property (nonatomic, strong) NSString *appUserPhone;
// 内／外勤
@property (nonatomic, strong) NSString *meetingSupport;
// 会议类型
@property (nonatomic, strong) NSString *meetType;
// 会议属性
@property (nonatomic, strong) NSString *meetAttr;
// 预算费用（元）
@property (nonatomic, strong) NSNumber *expense;
// 会议名称
@property (nonatomic, strong) NSString *meetSubject;
// 组织人代码
@property (nonatomic, copy) NSString *orgManCode;
// 组织人
@property (nonatomic, strong) NSString *orgManName;
// 主持人代码
@property (nonatomic, copy) NSString *emceeCode;
// 主持人
@property (nonatomic, strong) NSString *emceeName;
// 举办层面
@property (nonatomic, strong) NSString *holeLay;
// 会议地址
@property (nonatomic, strong) NSString *meetAddr;
// 会议开始时间
@property (nonatomic, strong) NSDate *startDt;
// 会议结束时间
@property (nonatomic, strong) NSDate *endDt;
// 会议议程
@property (nonatomic, strong) NSArray *meetAgendas;
// 参会人员
@property (nonatomic, strong) NSArray *meetPersons;
// 会议说明
@property (nonatomic, strong) NSString *meetDetail;
// 会务人员
@property (nonatomic, strong) NSArray *meetAffairs;
// 当前人的角色
@property (nonatomic, copy) NSString *personrole;
// 会议完结状态
@property (nonatomic, copy) NSString *meetEnd;
@end





















