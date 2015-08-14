//
//  TPIPISUser.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPIPISUser.h"

@interface TPIPISUserExt : TPIPISUser
@property (strong, nonatomic)NSString *deviceType;
@property (strong, nonatomic)NSString *deviceCode;
@property (strong, nonatomic)NSString *authToken;
@property (strong, nonatomic)NSString *latestIp;
@property (strong, nonatomic)NSString *isActive;
@end
