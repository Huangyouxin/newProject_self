//
//  TPModelNavigationController.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-29.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPModelNavigationController.h"
#import <objc/runtime.h>

@interface UIViewController (CustomNaviBack)
@end
@implementation UIViewController (CustomNaviBack)
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method fixedMethod = class_getInstanceMethod([self class], @selector(swize_viewDidLoad));
    method_exchangeImplementations(originalMethod, fixedMethod);
}

- (void) leftTextButton:(NSString*)aTitle selector:(SEL)sel {
	UIBarButtonItem *button = [[UIBarButtonItem alloc]
							   initWithTitle:aTitle
							   style:UIBarButtonItemStylePlain
							   target:self
							   action:sel];
	self.navigationItem.leftBarButtonItem = button;
}

- (void) rightTextButton:(NSString*)aTitle selector:(SEL)sel {
	UIBarButtonItem *button = [[UIBarButtonItem alloc]
							   initWithTitle:aTitle
							   style:UIBarButtonItemStylePlain
							   target:self
							   action:sel];
	self.navigationItem.rightBarButtonItem = button;
}

- (void) swize_viewDidLoad {
    [self swize_viewDidLoad];
    if ([self.navigationController isKindOfClass:[TPModelNavigationController class]]) {
        if (self.navigationController.viewControllers.count <= 1) {
            [self leftTextButton:@"取消"
                        selector:@selector(onModelWindowCancelEvent:)];
            [self rightTextButton:@"确定"
                        selector:@selector(onModelWindowConfirmEvent:)];
        }
    }
}

- (void) onModelWindowCancelEvent:(UIButton *)button {
    id data = nil;
    if ([self respondsToSelector:@selector(getModelWindowCancelData)]) {
        data = [self performSelector:@selector(getModelWindowConfirmData)];
    }
    NotificationPost(NotificationMsg_ModelWindowConceled, nil, data);
}

- (void) onModelWindowConfirmEvent:(UIButton*)button {
    id data = nil;
    if ([self respondsToSelector:@selector(getModelWindowConfirmData)]) {
        data = [self performSelector:@selector(getModelWindowConfirmData)];
    }
    NotificationPost(NotificationMsg_ModelWindowConfirmed, nil, data);
}


- (void) hideLeftBarButtonItem {
    self.navigationItem.leftBarButtonItem = nil;
}
@end

@interface TPModelNavigationController ()
@end

@implementation TPModelNavigationController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TextBackGroudColor;
//    self.navigationBar.backgroundColor = TextBackGroudColor;
//    self.navigationBar.backgroundColor = [UIColor redColor];
//    self.navigationBar.tintColor = TEXTCOLOR(@"0xfffbf0");
    self.navigationBar.tintColor = [UIColor redColor];

    
    UIColor *cc = TEXTCOLOR(@"0xb4b0af");
    NSDictionary *dict = [NSDictionary dictionaryWithObject:cc forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
    
    if (isIOS7) {
        __weak typeof(self) Self = self;
        [Self.view addLayoutBlock:^{
            [Self.view.subviews enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL *stop) {
                if ([item isKindOfClass:[UINavigationBar class]]) {
                    item.frame = CGRectMake(0, 0, Self.view.width, 44.0);
                } else {
                    item.frame = CGRectMake(0, 44.0, Self.view.width, Self.view.height-44.0);
                }
            }];
        }];
    }
}

- (id) getModelWindowConfirmData {
    UIViewController *viewController = self.viewControllers.lastObject;
    id data = nil;
    if ([viewController respondsToSelector:@selector(getModelWindowConfirmData)]) {
        data = [viewController performSelector:@selector(getModelWindowConfirmData)];
    }
    return data;
}
@end

@interface UINavigationBar (CustomImage)
@end

@implementation UINavigationBar (CustomImage)

- (UIImage *)barBackground {
    return [Image(@"background/navigationbar_bg.png") stretch];
}

+ (void)load {
    Method originalMethod = class_getClassMethod([self class], @selector(drawRect:));
    Method fixedMethod = class_getClassMethod([self class], @selector(ie_customDrawRect:));
    method_exchangeImplementations(originalMethod, fixedMethod);
    
    originalMethod = class_getClassMethod([self class], @selector(setTranslucent:));
    fixedMethod = class_getClassMethod([self class], @selector(setCustomTranslucent:));
    method_exchangeImplementations(originalMethod, fixedMethod);
}

- (void) fillBackground:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRGBHex:0xffffff].CGColor);
    CGContextFillRect(context, rect);
    CGContextSaveGState(context);
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion floatValue] < 5.0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor colorWithRGBHex:0xffffff].CGColor);
        CGContextFillRect(context, rect);
        CGContextSaveGState(context);
    }
    
    [[self barBackground] drawInRect:rect];
}

- (void)ie_customDrawRect:(CGRect)rect {
    //calling original drawRect
    [self ie_customDrawRect:rect];
    
    [self fillBackground:rect];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    //iOS5 only
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void) setCustomTranslucent:(BOOL)translucent {
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
        return;
    }
    [self setCustomTranslucent:translucent];
}
@end

















