//
//  TPIPISUserBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPIPISUserBO.h"

@interface TPIPISUserBO : TPErrors

@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *headPicName;
@property (nonatomic, strong)NSString *headPicPath;
@property (nonatomic, strong)NSString *motto;
@property (nonatomic, strong)NSString *orgName;
@property (nonatomic, strong)NSString *cellerTel;

//@property (nonatomic, strong)GXContactBO *primaryContact;

@end
