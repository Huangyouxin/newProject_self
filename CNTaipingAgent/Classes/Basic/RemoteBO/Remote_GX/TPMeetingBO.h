//
//  TPMettingBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPMeetingBO : TPRemoteBO
// 会议ID
@property (nonatomic, strong) NSNumber *Id;
// 申请部门
@property (nonatomic, copy) NSString *appDeptCode;
// 申请部门名称
@property (nonatomic, copy) NSString *appDeptName;
// 所属机构名称
@property (nonatomic, copy) NSString *orgName;
// 所属机构
@property (nonatomic, copy) NSString *orgCode;
// 会议名称
@property (nonatomic, copy) NSString *meetSubject;
// 开始时间
@property (nonatomic, strong) NSDate *startDt;
// 结束时间
@property (nonatomic, strong) NSDate *endDt;
// 组织人代码
@property (nonatomic, copy) NSString *orgManCode;
// 组织人名称
@property (nonatomic, copy) NSString *orgManName;
// 主持人代码
@property (nonatomic, copy) NSString *emceeCode;
// 主持人名称
@property (nonatomic, copy) NSString *emceeName;
// 会议属性
@property (nonatomic, copy) NSString *meetAttr;
// 会议类型
@property (nonatomic, copy) NSString *meetType;
// 申请人代码
@property (nonatomic, copy) NSString *appUserCode;
// 申请人名称
@property (nonatomic, copy) NSString *appUserName;
// 创建日期
@property (nonatomic, strong) NSDate *appDt;
// 会议议程
@property (nonatomic, strong) NSArray *meetAgendas;
// 会议主讲人
@property (nonatomic, copy) NSString *spearkName;
// 会议参与人
@property (nonatomic, copy) NSArray *meetPersons;
// 内／外勤
@property (nonatomic, copy) NSString *meetingSupport;
// 会务
@property (nonatomic, strong) NSArray *meetAffairs;
// 会议完结状态：Y已完结   N或者空 未完结
@property (nonatomic, copy) NSString *meetend;
@end








