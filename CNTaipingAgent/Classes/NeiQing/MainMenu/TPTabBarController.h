//
//  TPLTabBarController.h
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-8-15.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import <UIKit/UIKit.h>






@interface TPTabBarController : UIViewController
@property(nonatomic, readonly)CYGToolBar*   tabBar;

+ (TPTabBarController *)controller;
@end
