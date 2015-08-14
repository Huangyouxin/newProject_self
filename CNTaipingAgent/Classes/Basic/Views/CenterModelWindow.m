//
//  CenterModelWindow.m
//  CNTaipingAgent
//
//  Created by Stone on 14-10-16.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "CenterModelWindow.h"
#import <QuartzCore/QuartzCore.h>

@interface CenterModelWindow ()
@property (nonatomic, strong)   ModelWindowBlock succBlock;
@property (nonatomic, strong)   ModelWindowBlock failBlock;
@property (nonatomic, strong)   UIViewController *vc;
@property (nonatomic, copy)     NSString *confirmKey;
@property (nonatomic, copy)     NSString *cancelKey;
@property (nonatomic, readonly) UIWindow *window;
@property (nonatomic, strong)   UIView *bottom;
@property (nonatomic, strong)   UIView *contentView;
@property (nonatomic, assign)   BOOL isTouchedDismiss;
@end

@implementation CenterModelWindow
@synthesize succBlock, failBlock;
@synthesize vc;
@synthesize confirmKey, cancelKey;
@synthesize bottom, contentView;
@synthesize isTouchedDismiss;

- (UIWindow *)window {
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count == 0) {
        return nil;
    }
    return windows[0];
}

#define ModelWindowTag      8080

- (id)initWithViewController:(UIViewController *)viewController touchedDismiss:(BOOL)IsTouchedDismiss {
    UIWindow *window = self.window;
    CGRect rect = window.rootViewController.view.bounds;
    if (self = [super initWithFrame:rect]) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0;
        self.tag = ModelWindowTag;
        
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 88)];
        header.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        header.backgroundColor = color;
        [self addSubview:header];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(header.frame), width, height-CGRectGetHeight(header.frame))];
        bottom.backgroundColor = color;
        bottom.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:bottom];
        
        UIView *left = [[UIView alloc] initWithFrame:bottom.bounds];
        left.backgroundColor = [UIColor clearColor];
        left.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
        [bottom addSubview:left];
        
        self.isTouchedDismiss = IsTouchedDismiss;
        if (TRUE) {
            UITapGestureRecognizer *gecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onModelWindowTouchedCanceled:)];
            [header addGestureRecognizer:gecognizer1];
            
            UITapGestureRecognizer *gecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onModelWindowTouchedCanceled:)];
            [left addGestureRecognizer:gecognizer2];
        }

        height = CGRectGetHeight(bottom.bounds)-21;
        CGRect frame = CGRectMake(51, 0, 920, height);
        self.contentView = [[UIView alloc] initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor clearColor];
        [bottom addSubview:self.contentView];
        
        [self.contentView addSubview:viewController.view];
        viewController.view.frame = self.contentView.bounds;
        
        self.vc = viewController;
        [window.rootViewController.view addSubview:self];
    }
    return self;
}

- (void) setConfirmKey:(NSString *)key {
    if (nil == key) {
        return ;
    }
    if (nil != confirmKey) {
        [self NotificationRemoveObserver:self:confirmKey];
    }
    confirmKey = key;
    [self NotificationAddObserver:self:confirmKey:@selector(onModelWindowConfirmed:)];
}

- (void) setCancelKey:(NSString *)key {
    if (nil == key) {
        return;
    }
    if (nil != cancelKey) {
        [self NotificationRemoveObserver:self:cancelKey];
    }
    cancelKey = key;
    [self NotificationAddObserver:self:cancelKey:@selector(onModelWindowCanceled:)];
}

- (void)dealloc {
    if (nil != self.confirmKey) {
        [self NotificationRemoveObserver:self :self.confirmKey];
    }
    if (nil != self.cancelKey) {
        [self NotificationRemoveObserver:self :self.cancelKey];
    }
    
    self.window.rootViewController.view.userInteractionEnabled = YES;
    self.succBlock = nil;
    self.failBlock = nil;
    self.contentView = nil;
    self.vc = nil;
}

- (void) show {
    self.alpha = 1.0;
    
    CGFloat width = CGRectGetWidth(self.contentView.superview.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.superview.bounds)-21;
    CGFloat viewWidth = 920.0f;
    CGRect frame = CGRectMake(width, 0, viewWidth, height);
    self.contentView.frame = frame;
    self.vc.view.frame = self.contentView.bounds;
    
    frame.origin.x -= viewWidth + 51.0;
    
    [UIView animateWithDuration:.3 animations:^{
        self.contentView.frame = frame;
        self.vc.view.frame = self.contentView.bounds;
    }completion:nil];
}

- (void)hide:(id)data withBlock:(ModelWindowBlock)block {
    CGFloat width = CGRectGetWidth(self.contentView.superview.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.superview.bounds);
    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
    CGRect frame = CGRectMake(width, 0, viewWidth, height);
    
    [UIView animateWithDuration:.3 animations:^{
        self.contentView.frame = frame;
        self.vc.view.frame = self.contentView.bounds;
    }completion:^(BOOL finished) {
        if (block) {
            block (data);
        }
        self.alpha = 0.0f;
        [self removeFromSuperview];
    }];
}

+ (void) showModelWindow:(UIViewController *)viewController
          touchedDismiss:(BOOL)isTouchedDismiss
            confirmBlock:(ModelWindowBlock)confirmBlock
             cancelBlock:(ModelWindowBlock)cancelBlock {
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count <= 0) {
        return ;
    }
    NSArray *subViews = ((UIWindow *)windows[0]).rootViewController.view.subviews;
    for (UIView *item in subViews) {
        if ([item isKindOfClass:[CenterModelWindow class]]) {
            NSLog(@"-------不能同时出现两个CenterModelWindow形式的弹出框页面------");
            return;
        }
    }
    
    CenterModelWindow *window = [[CenterModelWindow alloc] initWithViewController:viewController
                                                                   touchedDismiss:isTouchedDismiss];
    window.succBlock = confirmBlock;
    window.failBlock = cancelBlock;
    window.confirmKey = NotificationMsg_ModelWindowConfirmed;
    window.cancelKey = NotificationMsg_ModelWindowConceled;
    
    [window show];
}

- (void) onModelWindowConfirmed:(NSNotification *)notification {
    if (![notification isKindOfClass:[NSNotification class]]) {
        notification = nil;
    }
    [self hide:notification.userInfo withBlock:self.succBlock];
}

- (void) onModelWindowCanceled:(NSNotification *)notification {
    if (![notification isKindOfClass:[NSNotification class]]) {
        notification = nil;
    }
    [self hide:notification.userInfo withBlock:self.failBlock];
}

- (void) onModelWindowTouchedCanceled:(UITapGestureRecognizer *)gecognizer {
    if (self.isTouchedDismiss) {
        id data = nil;
        if ([self.vc respondsToSelector:@selector(getModelWindowConfirmData)]) {
            data = [self.vc performSelector:@selector(getModelWindowConfirmData)];
        }
        [self hide:data withBlock:self.failBlock];
    }
}

- (void)NotificationAddObserver:(id)target :(NSString*)name :(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:name object:nil];
}

- (void)NotificationRemoveObserver:(id)target : (NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:target name:name object:nil];
}

@end





