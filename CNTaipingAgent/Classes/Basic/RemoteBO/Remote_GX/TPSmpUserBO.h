//
//  TPSmpUserBO.h
//  CNTaipingAgent
//
//  Created by song on 14-10-21.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <HessianKit/HessianKit.h>

@interface TPSmpUserBO : CWValueObject

@property (nonatomic,strong) NSString  *userName;
@property (nonatomic,strong) NSString  *name;
@property (nonatomic,strong) NSString  *divCode;
@property (nonatomic,strong) NSString  *securityDivCode;
@property (nonatomic,assign) BOOL  isAdmin;
@end
