//
//  TPMeetingSearchInfoBO.h
//  CNTaipingAgent
//
//  Created by Fan on 14-9-16.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

/*
 * 本地使用数据模型
 */

#import <HessianKit/HessianKit.h>

@interface TPMeetingSearchInfoBO : CWValueObject
//会议开始时间
@property(nonatomic, strong) NSDate *startDate;
//会议结束时间
@property(nonatomic, strong) NSDate *endDate;
//会议类型
@property(nonatomic, strong) NSString *meetingType;
//申请部门
@property(nonatomic, strong) NSString *applyDepartment;
//举办层面
@property(nonatomic, strong) NSString *hostLay;
//会议名称
@property(nonatomic, strong) NSString *meetingName;
//会议属性
@property(nonatomic, strong) NSString *meetingAttribute;
//参与人
@property(nonatomic, strong) NSString *participant;
//参与人角色
@property(nonatomic, strong) NSString *participantRole;
//会议来源
@property(nonatomic, strong) NSString *meetingResource;
//回执状态
@property(nonatomic, strong) NSString *receiptStats;
@end
