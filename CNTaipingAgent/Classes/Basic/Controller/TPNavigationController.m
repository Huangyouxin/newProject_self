//
//  TPNavigationController.m
//  CNTaipingAgent
//
//  Created by Stone on 15/1/21.
//  Copyright (c) 2015年 Taiping. All rights reserved.
//

#import "TPNavigationController.h"

@interface TPNavigationController () <UINavigationControllerDelegate>

@end

@implementation TPNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController dragPopStyle:(UINavigationControllerDragPopStyle)style
{
    if (self = [super initWithRootViewController:rootViewController dragPopStyle:style])
    {
        self.delegate = self;
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UINavigationController Delegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (navigationController.viewControllers.count > 1) {
        if ([viewController isKindOfClass:[TPViewController class]]) {
            ((TPViewController *)viewController).backButton.hidden = NO;
        }
    } else {
        if ([viewController isKindOfClass:[TPViewController class]]) {
            ((TPViewController *)viewController).backButton.hidden = YES;
        }
    }
}
@end















