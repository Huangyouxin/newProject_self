//
//  TPPersonBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

/*
 * 主持人（组织人）
 */

#import "TPRemoteBO.h"

@interface TPPersonBO : TPRemoteBO

// 支持人（组织人）ID
@property (nonatomic, strong) NSNumber *Id;
// 机构
@property (nonatomic, copy) NSString *divcode;
// 机构名称
@property (nonatomic, copy) NSString *divname;
// 部门
@property (nonatomic, copy) NSString *deptno;
// 部门名称
@property (nonatomic, copy) NSString *deptname;
// 职务
@property (nonatomic, copy) NSString *jobcode;
// 职务名称
@property (nonatomic, copy) NSString *jobname;
// 姓名
@property (nonatomic, copy) NSString *name;
// 性别
@property (nonatomic, copy) NSString *gender;
// 座机
@property (nonatomic, copy) NSString *htel;
// 手机
@property (nonatomic, copy) NSString *phone;
// 邮箱
@property (nonatomic, copy) NSString *pemail;
@end
