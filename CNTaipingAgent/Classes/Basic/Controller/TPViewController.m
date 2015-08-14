//
//  TPViewController.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "TPViewController.h"
#import "UIKeyboardCoView.h"
#include <objc/runtime.h>
#import "TPLAppDelegate.h"

@implementation UIView (ANAdvancedNavigationControllerNormal)
- (UIViewController*)vcNormal {
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end

@interface TPViewController () {
    NSString*  _msgKey;
    NSString*  _superMsgKey;
    UIButton *backButton;
    dispatch_once_t onceTipDispatch;
}
@end

@implementation TPViewController
@synthesize msgKey = _msgKey;
@synthesize backgroundView;
@synthesize superMsgKey = _superMsgKey;
@synthesize backButton;
@synthesize noneTipShow;


-(UIStatusBarStyle)preferredStatusBarStyle {
    return 1;//UIStatusBarStyleLightContent;
}

- (NSString *)description {
    return NSStringFromClass([self class]);
}

- (BOOL) userParentSearchView {
    return NO;
}
- (NSString*)searchViewControllerClassName {
    return nil;
}
- (NSString*)searchViewMsgKey {
    return nil;
}

- (void)dealloc {
    if (self.msgKey.length > 0) {
        NotificationRemoveObserver(self, self.msgKey);
    }
    NSString *searchKey = [self searchViewMsgKey];
    if ([self searchViewControllerClassName] && searchKey) {
        NotificationRemoveObserver(self, searchKey);
    }
    
    self.param = nil;
    
	TPLLOG(@"-------%@ dealloc", [self description]);
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardCoViewWillRotateNotification  object:nil];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardCoViewDidRotateNotification object:nil];
}

- (void) setMsgKey:(NSString *)msgKey {
    _msgKey = msgKey;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    backgroundView = [[UIImageView alloc] initWithImage:Image(@"maintabbar/viewBack.png")];
    backgroundView.frame = self.view.bounds;
    backgroundView.autoresizingMask = AutoresizingFull;
    backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    self.view.backgroundColor = BACKCOLOR(@"0xffffff");
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, self.view.height-70, 40, 40);
    backButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [backButton setBackgroundImage:Image(@"report/reportBackBtn.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    backButton.hidden = YES;
    [self.view addSubview:backButton];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:backButton];
}

- (void) onBackButtonEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *	@brief	是否可以横竖屏切换
 *
 *	@param 	interfaceOrientation 	将要切换到的屏幕状态
 *
 *	@return	YES：可以切换，NO：不可以切换
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [UIApplication sharedApplication].statusBarOrientation;
}

- (UIViewController*) rootViewController {
    return ((TPLAppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
}

- (void) setRootViewController:(UIViewController *)rootViewController {
    ((TPLAppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController = rootViewController;
}

- (id) initWithMsgKey:(NSString*)msgKey {
    if (self = [super init]) {
        _msgKey = msgKey;
        if (msgKey.length > 0) {
            NotificationAddObserver(self, msgKey, @selector(onInterfaceKeyMessage:));
        }
    }
    return self;
}

- (id) initWithSuperMsgKey:(NSString*)superMsgKey {
    if (self = [super init]) {
        _superMsgKey = superMsgKey;
    }
    return self;
}

- (void) onInterfaceKeyMessage:(NSNotification *)notification {
    
}

@end