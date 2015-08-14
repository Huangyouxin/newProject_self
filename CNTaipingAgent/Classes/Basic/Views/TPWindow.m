//
//  TPWindow.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPWindow.h"
#import "TPLoginViewController.h"

@interface TPWindow () {
    NSMutableDictionary* msgDic;
}
@property(nonatomic, strong)NSTimer*  eventMonitorTimer;
@property(nonatomic, strong)NSDictionary* versionInfo;
@property(nonatomic, strong)UIAlertView *alertView;
@end

@implementation TPWindow
@synthesize eventMonitorTimer;
@synthesize versionInfo;
@synthesize lastTouchTime;
@synthesize alertView;

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        msgDic = [NSMutableDictionary dictionary];
        [self addTouchMonitorTimer];
        // 注册监听者，监听弹出登录提示页面登录成功消息
        NotificationAddObserver(self, NotificationMsg_POPUP_LOGIN_SUCCEED, @selector(responderDidLoginSucceed:));
        // 监听是否有新版本
        NotificationAddObserver(self, NotificationMsg_HAS_NEW_VERSION, @selector(responderHasNewVersion:));
        // 监听弹出登录页面
        NotificationAddObserver(self, NotificationMsg_POPUP_LOGIN, @selector(responderPopupLogin:));
        // 监听弹出修改密码页面
        NotificationAddObserver(self, NotificationMsg_POPUP_MODIFY_PASSWORD, @selector(responderModifyPassword:));
    }
    return self;
}

- (UIViewController *) viewController {
    return ((UIWindow*)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    [self addTouchMonitorTimer];
    self.lastTouchTime = [NSDate date];
    
    //    NSLog(@"=====----------%@", self.lastTouchTime);
    return [super hitTest:point withEvent:event];
}

- (void) addTouchMonitorTimer {
    [self.eventMonitorTimer invalidate];
    self.eventMonitorTimer = nil;
    self.eventMonitorTimer = [NSTimer scheduledTimerWithTimeInterval:TouchEventMonitorTime
                                                              target:self
                                                            selector:@selector(onEventMonitorTimeout:)
                                                            userInfo:nil
                                                             repeats:YES];
}

- (void) dealloc {
    //取消消息监听
    NotificationRemoveObserver(self, NotificationMsg_POPUP_LOGIN_SUCCEED);
    //取消消息监听
    NotificationRemoveObserver(self, NotificationMsg_HAS_NEW_VERSION);
    //取消消息监听
    NotificationRemoveObserver(self, NotificationMsg_POPUP_LOGIN);
    //取消消息监听
    NotificationRemoveObserver(self, NotificationMsg_POPUP_MODIFY_PASSWORD);
    //停止屏幕触摸监听
    [self.eventMonitorTimer invalidate];
    
}

- (void) onEventMonitorTimeout:(NSTimer*)timer {
    [self responderPopupLogin:nil];
}

- (void)responderPopupLogin:(NSNotification *)notification {
    
    if ([self.rootViewController isKindOfClass:[TPLoginViewController class]]) {
        ShowMessage(notification.object, nil);
        [self addTouchMonitorTimer];
        return ;
    }
    
    [self.eventMonitorTimer invalidate];
    self.eventMonitorTimer = nil;
    if (notification.object) {
        if (!self.alertView || (self.alertView && ![self.alertView.message isEqualToString:notification.object])) {
            self.alertView = [[UIAlertView alloc] initWithTitle:@"消息提示"
                                                        message:notification.object
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
            [alertView showWithCompletion:^(NSInteger buttonIndex) {
                self.alertView = nil;
                self.rootViewController = [[TPLoginViewController alloc] init];
            }];
        }
    } else {
        if (!self.alertView || (self.alertView && ![self.alertView.message isEqualToString:@"由于您长时间未操作，为了您帐户安全，您必须重新登录"])) {
            self.alertView = [[UIAlertView alloc] initWithTitle:@"消息提示"
                                                        message:@"由于您长时间未操作，为了您帐户安全，您必须重新登录"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
            [alertView showWithCompletion:^(NSInteger buttonIndex) {
                self.alertView = nil;
                self.rootViewController = [[TPLoginViewController alloc] init];
            }];
        } else {
            [alertView showWithCompletion:^(NSInteger buttonIndex) {
                self.alertView = nil;
                self.rootViewController = [[TPLoginViewController alloc] init];
            }];
        }
    }
}

- (void)responderDidLoginSucceed:(NSNotification *)notification {
    [self addTouchMonitorTimer];
}

- (void)responderHasNewVersion:(NSNotification*)notification {
    
    [self.eventMonitorTimer invalidate];
    self.eventMonitorTimer = nil;
    
    self.versionInfo = (NSDictionary *)[notification userInfo];
    
    NSString *tipInfo = nil;
    if (![[self.versionInfo objectForKey:@"versionstatus"] boolValue]) {
        tipInfo = [NSString stringWithFormat:@"有新版本%@可以更新了，不更新将不能继续使用。开始更新？",
                   [self.versionInfo objectForKey:@"versioncode"]];
    } else {
        tipInfo = [NSString stringWithFormat:@"有新版本%@可以更新了,开始更新？",
                   [self.versionInfo objectForKey:@"versioncode"]];
    }
    
    if (!self.alertView || (self.alertView && ![self.alertView.message isEqualToString:tipInfo])) {
        self.alertView = [[UIAlertView alloc] initWithTitle:@"操作提示"
                                                    message:tipInfo
                                                   delegate:nil
                                          cancelButtonTitle:@"否"
                                          otherButtonTitles:@"是",nil];
        [alertView showWithCompletion:^(NSInteger buttonIndex) {
            if (buttonIndex == alertView.cancelButtonIndex) {
                if ([[self.versionInfo objectForKey:@"versionstatus"] boolValue]) {
                    self.alertView = nil;
                    exit(0);
                } else {
                    self.alertView = nil;
                    [TPUserDefaults instance].newVersionCancel = YES;
                }
            } else {
                self.alertView = nil;
                
                NotificationPost(NotificationMsg_UPDATE_VERSION, nil, nil);
            }
        }];
    } else {
        [alertView showWithCompletion:^(NSInteger buttonIndex) {
            if (buttonIndex == alertView.cancelButtonIndex) {
                if ([[self.versionInfo objectForKey:@"versionstatus"] boolValue]) {
                    self.alertView = nil;
                    exit(0);
                } else {
                    self.alertView = nil;
                    [TPUserDefaults instance].newVersionCancel = YES;
                }
            } else {
                self.alertView = nil;
                
                NotificationPost(NotificationMsg_UPDATE_VERSION, nil, nil);
            }

        }];
    }
}

- (void)responderModifyPassword:(NSNotification *)notification {
    //显示修改密码
    //    NCBSettingModifyPasswordViewController* load = [[NCBSettingModifyPasswordViewController alloc] init];
    //    [NCBModelWindow showModelWindow:load.view
    //                           showSize:CGSizeMake(503, 416)
    //                       confirmBlock:nil
    //                        cancelBlock:nil];
}
@end