//
//  TPIPISUser.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-13.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPLoginUserErrorBO.h"

@interface TPIPISUser : TPLoginUserErrorBO

//用户ID
@property(nonatomic, strong)NSNumber *userId;//NSNumber
//用户名
@property(nonatomic, strong)NSString *userName;
//密码
@property(nonatomic, strong)NSString *password;
//证件号码
@property(nonatomic, strong)NSString *certiCode;
//用户类型
@property(nonatomic, strong)NSString *userCate;//渠道
//专业公司ID
@property(nonatomic, strong)NSString *headId;
//机构ID
@property(nonatomic, strong)NSString *organId;//机构
//网点代码
@property(nonatomic, strong)NSString *deptCode;
//原系统人员ID
@property(nonatomic, strong)NSString *rawStaffId;
//是否禁用
@property(nonatomic, strong)NSString *disabled;
//是否首次登陆
@property(nonatomic, strong)NSString *isFirstLogin;
//是否被锁
@property(nonatomic, strong)NSString *isLocked;
//错误次数
@property(nonatomic, strong)NSString *failTime;
//是否加密
@property(nonatomic, strong)NSString *encryption;
//锁定次数
@property(nonatomic, strong)NSString *lockedTime;
//密码修改日期
@property(nonatomic, strong)NSString *pwdChange;
//最近登录时间
@property(nonatomic, strong)NSString *latestLoginTime;
//可操作模块集合
@property(nonatomic, strong)NSArray *moduleList;
//可操作模块URL集合
@property(nonatomic, strong)NSSet *moduleUrlSet;


@end
