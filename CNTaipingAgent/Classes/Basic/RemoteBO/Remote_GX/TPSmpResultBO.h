//
//  TPSmpResultBO.h
//  CNTaipingAgent
//
//  Created by song on 14-10-21.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <HessianKit/HessianKit.h>
#import "TPSmpUserBO.h"
@interface TPSmpResultBO : CWValueObject

@property (nonatomic,assign) BOOL isSucess;
@property (nonatomic,strong) NSString  *message;
@property (nonatomic,strong) TPSmpUserBO *smpUser;

@end
