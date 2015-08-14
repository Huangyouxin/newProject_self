//
//  TPNavigationController.h
//  CNTaipingAgent
//
//  Created by Stone on 15/1/21.
//  Copyright (c) 2015年 Taiping. All rights reserved.
//

#import <libkitEx/libkitEx.h>

@interface TPNavigationController : CYGNavigationController
- (id)initWithRootViewController:(UIViewController *)rootViewController dragPopStyle:(UINavigationControllerDragPopStyle)style;
@end
