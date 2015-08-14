//
//  TPPrecustomerBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <HessianKit/HessianKit.h>

@interface TPPrecustomerBO : CWValueObject

//准客户ID
@property (nonatomic, strong) NSString *precustId;

//承保客户Id
//@property (nonatomic, strong) NSString *policyCustomerId;
@property (nonatomic, strong) NSArray *policyCustomerIds;

//拼音
@property (nonatomic, strong) NSString *namePY;

//合作伙伴标识{0-是,1-否}
@property (nonatomic, strong) NSString *intendPary;
//relaAgentStatus; //关联业务员状态(对应的业务员状态[(默认0)岗前培训、1-上岗在职、2-离职])
@property (nonatomic, strong) NSNumber *relaAgentStatus;


//潜在客户标识{0-是,1-否}
@property (nonatomic, strong) NSString *intendCust;

//客户等级{A-1,B-2,3-C,4-D}
@property (nonatomic, strong) NSString *customerRank;

//客户姓名(中文)
@property (nonatomic, strong) NSString *chineseName;

//客户姓名(英文)
@property (nonatomic, strong) NSString *englishName;

//社会保险号
@property (nonatomic, strong) NSString *socialSecurityNum;

//健康状况
@property (nonatomic, strong) NSString *healthyCondition;

//婚姻状况
@property (nonatomic, strong) NSString *marriageCondition;

//国籍
@property (nonatomic, strong) NSString *nationality;

//籍贯所在省
@property (nonatomic, strong) NSString *nativeplaceProvince;

//籍贯所在市
@property (nonatomic, strong) NSString *nativeplaceCity;

//户口所在省
@property (nonatomic, strong) NSString *nativeProvince;

//户口所在市
@property (nonatomic, strong) NSString *nativeCity;

//出生所在省
@property (nonatomic, strong) NSString *birthProvince;

//出生所在市
@property (nonatomic, strong) NSString *birthCity;

//民族
@property (nonatomic, strong) NSString *nation;

//信用级别
@property (nonatomic, strong) NSString *creditStep;

//性别（M:男，F：女，N：不确定
@property (nonatomic, strong) NSString *gender;

//出生日期(yyyy-MM-dd)
@property (nonatomic, strong) NSDate *birthday;

//收入
@property (nonatomic, strong) NSNumber *annuIncome;

//收入来源
@property (nonatomic, strong) NSString *incomeSource;

//工作单位
@property (nonatomic, strong) NSString *companyName;

//吸烟状态  YES  1    NO  2
@property (nonatomic, strong) NSString *smokeStatus;

//客户来源（1-缘故开拓、2-陌生拜访、3-目标市场、4-转介绍）
@property (nonatomic, strong) NSNumber *customerSource;

//拜访程度
@property (nonatomic, strong) NSString *visitDegree;

//初始拜访次数
@property (nonatomic, strong) NSNumber *visitCount;

//特长偏好
@property (nonatomic, strong) NSString *specialPreference;

//所属业务员ID
@property (nonatomic, strong) NSString *userId;

//社会关系数
@property (nonatomic, strong) NSNumber *societyRelationCount;

//家庭关系数
@property (nonatomic, strong) NSNumber *familyRelationCount;

//证件类型
@property (nonatomic, strong) NSString *certiType;

//证件号码
@property (nonatomic, strong) NSString *certiCode;

//市场划分[]
@property (nonatomic, strong) NSString *marketSegmentation;

//承保客户编号
@property (nonatomic, strong) NSString *underwritingCustomerNo;

//职业
@property (nonatomic, strong) NSString *occupation;

//学历	Integer
@property (nonatomic, strong) NSNumber *educationId;

//血型	Integer
@property (nonatomic, strong) NSNumber *bloodType;

//是否存在待匹配的客户 0:无 1:有
@property (nonatomic, strong) NSNumber *compareFlag;

//联系方式(将具体的联系方式添加到联系表里面)
@property (nonatomic, strong) NSArray *contactBOList;

//备注
@property (nonatomic, strong) NSString *remark;

//活动
@property (nonatomic, strong) NSNumber *activityFlag;
// 购物车[0-无,1-有]
@property (nonatomic, strong) NSNumber *shoppingCart;
// 客户总活动数
@property (nonatomic, strong) NSNumber *activityCount;

// 客户头像附件
//@property (nonatomic, strong) GXAttachmentBO *attachmentBO;
// 客户头像附件Id
@property (nonatomic, strong) NSNumber *fileId;
// 客户标示来源 ［3-个险活动,4-中石化］
@property (nonatomic, strong) NSNumber *sourceFlag;
//车险列表
@property (nonatomic, strong) NSArray *autoInsuranceBOList;

//打扮
@property (nonatomic, strong) NSNumber *dressUp;
//谈吐
@property (nonatomic, strong) NSNumber *speakSkills;
//性格
@property (nonatomic, strong) NSNumber *disposition;
//金钱观
@property (nonatomic, strong) NSNumber *moneyConcept;
//销售态度
@property (nonatomic, strong) NSNumber *salesAttitude;
//车列表
@property (nonatomic, strong) NSArray *cars;
//房屋列表
@property (nonatomic, strong) NSArray *houses;
//客户总评分
@property (nonatomic, strong) NSNumber *scoreTotal;
//健康升级状态[1-可升级,2-待升级,3-由他人升级,4-已升级,5-他人已升级,6-升级锁定
@property (nonatomic, strong) NSNumber *upgradeStatus;
//待升级任务截止时间
@property(nonatomic, strong) NSDate *taskEndDate;
//待升级任务剩余天数
@property (nonatomic, strong) NSNumber *taskEndDay;

////隶属  1:健康升级，
@property (nonatomic, strong) NSNumber *membership;

//保单客户类型[1-销售保单,2-投保单,3-服务保单,4-孤儿单服务分配]
@property (nonatomic, strong) NSNumber *policyCustomerType;
//CIF号
@property (nonatomic,readonly) NSString *partyNo;
//已转介绍客户标识[0-否,1-是]
@property (nonatomic, strong) NSNumber *referralsFlag;


//推荐客户ID(尊贵客户)新增转介绍时必录
@property (nonatomic,strong) NSString *recommendPrecustId;
//被推荐客户ID(尊贵客户转介绍客户ID)
@property (nonatomic,strong) NSString *beRecommendPrecustId;
//尊贵客户标识[0-普通客户,1-尊贵客户]
@property (nonatomic,strong) NSNumber *prestigeCustFlag;
//规保积分
@property (nonatomic,strong) NSNumber *gbIntegral;

@end
