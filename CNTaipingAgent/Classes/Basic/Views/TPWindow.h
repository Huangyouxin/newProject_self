//
//  TPWindow.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@brief	工程视窗，处理屏幕事件监控，长时间无操作将弹出登录框
 */
@interface TPWindow : UIWindow
@property(nonatomic, strong)NSDate* lastTouchTime;
@end
