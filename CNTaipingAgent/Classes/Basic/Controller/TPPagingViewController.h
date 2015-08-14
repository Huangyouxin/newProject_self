//
//  TPLPagingViewController.h
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-11-17.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "TPViewController.h"

@interface TPPagingViewController : TPHttpViewController
@property(nonatomic, strong, readonly) CYGPagingView *pagingView;
@property(nonatomic, assign)BOOL noSearchCheck;

//@{子类中实现
//只需要各子类的viewController类名，这样可实现切换时再加载
//子类的viewDidLoad中对viewControllers属性赋值
@property(nonatomic, strong)NSArray *viewControllers;
//- (void) onSubViewControllerMsg:(NSNotification *)notification;
//@}
@end
