//
//  TPPageControlController.h
//  TPPensionSell
//
//  Created by xc.yubin on 14-5-29.
//  Copyright (c) 2014年 cntaiping. All rights reserved.
//

#import "TPHttpViewController.h"

@interface TPPageControlController : TPHttpViewController
@property(nonatomic,strong)CYGPagingView* pageView;
@property(nonatomic,strong)UIPageControl* pageControl;
@property(nonatomic,strong)UIButton* leftButton;
@property(nonatomic,strong)UIButton* rightButton;
@property(nonatomic,assign)NSInteger numberOfPages;

@end
