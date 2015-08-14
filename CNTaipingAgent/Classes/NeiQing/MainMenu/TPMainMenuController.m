//
//  TPLMainMenuController.m
//  CNTaiPingPerson
//
//  Created by 崔玉国 on 13-8-15.
//  Copyright (c) 2013年 cntaiping. All rights reserved.
//

#import "TPMainMenuController.h"
#import "TPTabBarController.h"
#import "UIView+Origami.h"

@interface TPMainMenuController ()
{
    UIImageView *statusBar;
    
    BOOL        isShowing;
}
@property(nonatomic, strong)UIView* centerView;
@property(nonatomic, strong)UIImageView* maskView;
@property(nonatomic, strong)TPTabBarController* centerController;
@property(nonatomic, strong)UIImageView* divView;
@end



@implementation TPMainMenuController
@synthesize centerView, maskView;
@synthesize centerController;

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (isIOS7) {
        statusBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
        statusBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        statusBar.backgroundColor = BACKCOLOR(@"0x000000");
        [self.view addSubview:statusBar];
    }
    
    CGFloat posY = statusBar.height;
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, posY, self.view.width, self.view.height-posY)];
    self.centerView.backgroundColor = [UIColor clearColor];
    self.centerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.centerView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMaskViewTapEvent:)];
    tapRecognizer.numberOfTapsRequired = 1;
    self.maskView = [[UIImageView alloc] initWithFrame:self.centerView.bounds];
    self.maskView.backgroundColor = [UIColor clearColor];
    self.maskView.autoresizingMask = self.centerView.autoresizingMask;
    self.maskView.userInteractionEnabled = YES;
    [self.maskView addGestureRecognizer:tapRecognizer];
    [self.centerView addSubview:self.maskView];

    self.centerController = [TPTabBarController controller];
    [self.centerView addSubview:self.centerController.view];
    self.centerController.view.frame = self.centerView.bounds;
    self.centerController.view.autoresizingMask = self.centerView.autoresizingMask;
}

- (void) dealloc {
}

- (void) onSwipeRightGesture:(UISwipeGestureRecognizer*)gesture {
    if (!isShowing)
    {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            
            CGRect frame = weakSelf.centerController.view.frame;
            frame.origin.x = 69;
            weakSelf.centerController.view.frame = frame;
            
            CGRect maskFrame = weakSelf.maskView.frame;
            maskFrame.origin.x = 69;
            weakSelf.maskView.frame = maskFrame;
            
        }completion:^(BOOL finished) {
            isShowing = YES;
            [weakSelf.centerView bringSubviewToFront:weakSelf.maskView];
        }];
    }
}

- (void) onSwipeLeftGesture:(UISwipeGestureRecognizer*)gesture {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        
        CGRect frame = weakSelf.centerController.view.frame;
        frame.origin.x = 0;
        weakSelf.centerController.view.frame = frame;
        
        CGRect maskFrame = weakSelf.maskView.frame;
        maskFrame.origin.x = 0;
        weakSelf.maskView.frame = maskFrame;
        
    }completion:^(BOOL finished) {
        isShowing = NO;
        [weakSelf.centerView sendSubviewToBack:weakSelf.maskView];
    }];
    
}

- (void)onShowLeftView {
    [self onSwipeRightGesture:nil];
}

- (void) onMaskViewTapEvent:(UITapGestureRecognizer*)gesture {
    [self onSwipeLeftGesture:nil];
}

- (void) onEnterFullScreen:(NSNotification *)notification {
    [self onSwipeLeftGesture:nil];
}

- (void) onInterfaceKeyMessage:(NSNotification *)notification {
    if ([notification.object isEqualToString:@"hide"]) {
        [self onMaskViewTapEvent:nil];
    }
}
@end
