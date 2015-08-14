//
//  TPISAgentAgnetBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPISAgentAgnetBO.h"

@interface TPISAgentAgnetBO : CWValueObject

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *rawStaffId;
@property (nonatomic,strong) NSString *headId;//专业公司
@property (nonatomic,strong) NSString *organId;//分支机构
@property (nonatomic,strong) NSString *deptId;//部门代码
@property (nonatomic,strong) NSString *agentId;//业务员
@property (nonatomic,strong) NSString *agentCode;
@property (nonatomic,assign) int managerFlag; // 1-是区部主管，0-不是 6-内情

@end
