//
//  TPLoginUserErrorBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <HessianKit/HessianKit.h>

@interface TPLoginUserErrorBO : CWValueObject

//错误量
@property(nonatomic, assign)int count;
//错误代码
@property(nonatomic, assign)int err_code;
//错误提示
@property(nonatomic, strong)NSString *err_desc;
//信息提示
@property(nonatomic, strong)NSString *message;

@end
