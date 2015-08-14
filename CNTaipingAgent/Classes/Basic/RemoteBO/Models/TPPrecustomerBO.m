//
//  TPPrecustomerBO.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPPrecustomerBO.h"

@implementation TPPrecustomerBO

@synthesize precustId;
@synthesize namePY;
@synthesize policyCustomerIds;
@synthesize intendPary;
@synthesize intendCust;
@synthesize customerRank;
@synthesize chineseName;
@synthesize englishName;
@synthesize socialSecurityNum;
@synthesize healthyCondition;
@synthesize marriageCondition;
@synthesize nationality;
@synthesize nativeplaceProvince;
@synthesize nativeplaceCity;
@synthesize nativeProvince;
@synthesize nativeCity;
@synthesize birthProvince;
@synthesize birthCity;
@synthesize nation;
@synthesize creditStep;
@synthesize gender;
@synthesize birthday;
@synthesize annuIncome;
@synthesize incomeSource;
@synthesize companyName;
@synthesize smokeStatus;
@synthesize customerSource;
@synthesize visitDegree;
@synthesize visitCount;
@synthesize specialPreference;
@synthesize userId;
@synthesize societyRelationCount;
@synthesize familyRelationCount;
@synthesize certiType;
@synthesize certiCode;
@synthesize marketSegmentation;
@synthesize underwritingCustomerNo;
@synthesize occupation;
@synthesize educationId;
@synthesize bloodType;
@synthesize contactBOList;
@synthesize remark;
@synthesize activityFlag;
@synthesize shoppingCart;
@synthesize activityCount;
@synthesize relaAgentStatus;
@synthesize compareFlag;
@synthesize autoInsuranceBOList;
//@synthesize attachmentBO;
@synthesize fileId;
@synthesize sourceFlag;

//打扮
@synthesize dressUp;
//谈吐
@synthesize speakSkills;
//性格
@synthesize disposition;
//金钱观
@synthesize moneyConcept;
//销售态度
@synthesize salesAttitude;
//车列表
@synthesize cars;
//房屋列表
@synthesize houses;
//客户总评分
@synthesize scoreTotal;
//健康升级状态[1-可升级,2-待升级,3-由他人升级,4-已升级,5-他人已升级,6-升级锁定
@synthesize upgradeStatus;
@synthesize taskEndDate;
@synthesize taskEndDay;
@synthesize membership;
@synthesize policyCustomerType;
@synthesize partyNo;
@synthesize referralsFlag;

//推荐客户ID(尊贵客户)新增转介绍时必录
@synthesize recommendPrecustId;
//被推荐客户ID(尊贵客户转介绍客户ID)
@synthesize beRecommendPrecustId;
//尊贵客户标识[0-普通客户,1-尊贵客户]
@synthesize prestigeCustFlag;
//规保积分
@synthesize gbIntegral;

@end
