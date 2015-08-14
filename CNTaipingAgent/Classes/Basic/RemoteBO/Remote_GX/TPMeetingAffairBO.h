//
//  TPMeetingAffairBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14/12/2.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPRemote.h"

@interface TPMeetingAffairBO : CWValueObject

// 人员ID
@property (nonatomic, strong) NSNumber *Id;
// 机构ID
@property (nonatomic, copy) NSString *orgid;
// 部门
@property (nonatomic, copy) NSString *deptCode;
// 部门名称
@property (nonatomic, copy) NSString *deptName;
// 职务
@property (nonatomic, copy) NSString *degreecode;
// 职务名称
@property (nonatomic, copy) NSString *degreeName;
// 人员姓名
@property (nonatomic, copy) NSString *name;
// 手机
@property (nonatomic, copy) NSString *phone;
// 座机
@property (nonatomic, copy) NSString *htel;
// 性别
@property (nonatomic, copy) NSString *gender;
// 用户名
@property (nonatomic, copy) NSString *userName;
// 邮箱
@property (nonatomic, copy) NSString *email;
@end














