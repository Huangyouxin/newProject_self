//
//  TPActivityHomeController.m
//  CNTaipingAgent
//
//  Created by Stone on 15/1/20.
//  Copyright (c) 2015年 Taiping. All rights reserved.
//

#import "TPActivityHomeController.h"

@implementation TPActivityHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 210, 210);
    [button setTitle:@"活动" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onButton
{
    TPViewController *vc = [[TPViewController alloc] initWithMsgKey:@"Test"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
