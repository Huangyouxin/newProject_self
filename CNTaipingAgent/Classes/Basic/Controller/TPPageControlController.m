//
//  TPPageControlController.m
//  TPPensionSell
//
//  Created by xc.yubin on 14-5-29.
//  Copyright (c) 2014年 cntaiping. All rights reserved.
//

#import "TPPageControlController.h"

@interface TPPageControlController ()<CYGPagingViewDelegate>

@end

@implementation TPPageControlController
@synthesize pageView, pageControl;
@synthesize leftButton, rightButton;
@synthesize numberOfPages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageView = [[CYGPagingView alloc] init];
    self.pageView.gapBetweenPages = 0.0f;
    self.pageView.delegate = self;
    [self.view addSubview:self.pageView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.numberOfPages;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventValueChanged];
    self.pageControl.currentPageIndicatorTintColor = BACKCOLOR(@"0x1655a5");
    [self.pageView addSubview:self.pageControl];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setBackgroundImage:Image(@"mainMenu/leftArrow") forState:UIControlStateNormal];
    self.leftButton.tag = 0;
    [self.leftButton addTarget:self action:@selector(onImageArrowEvent:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.pageView addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setBackgroundImage:Image(@"mainMenu/rightArrow") forState:UIControlStateNormal];
    self.rightButton.tag = 1;
    [self.rightButton addTarget:self action:@selector(onImageArrowEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.pageView addSubview:self.rightButton];
    
    //位置赋值
    __weak typeof(self) Self = self;
    [self.view addLayoutBlock:^{
        Self.pageView.frame = CGRectMake(0, 0, Self.view.width, iPhone5 ? 455 : 363);
        Self.pageControl.frame = CGRectMake(0, Self.pageView.height-20, Self.pageView.width, 20);
        Self.leftButton.frame = CGRectMake(20, (Self.pageView.height-20)/2 - 15, 12, 20);
        Self.rightButton.frame = CGRectMake(Self.pageView.width-32, (Self.pageView.height-20)/2 - 15, 12, 20);
    }];
    self.pageView.backgroundColor = BACKCOLOR(@"0xE7E7E7");
}

- (void)setNumberOfPages:(NSInteger)_numberOfPages
{
    numberOfPages = _numberOfPages;
    self.pageControl.numberOfPages = _numberOfPages;
    [self.pageView reloadData];
}

- (void) onImageArrowEvent:(UIButton*)sender {
    if (0 == sender.tag && 0 < self.pageView.currentPageIndex) {
        self.pageView.currentPageIndex -= 1;
    }else if (1 == sender.tag && self.numberOfPages > self.pageView.currentPageIndex+1)
        self.pageView.currentPageIndex += 1;
}

- (void)pageControlClicked:(UIPageControl *)sender
{
    self.pageView.currentPageIndex = sender.currentPage;
}

#pragma --mark CYGPagingViewDelegate
- (NSInteger)numberOfPagesInPagingView:(CYGPagingView *)pagingView
{
    return numberOfPages;
}

- (UIView *)viewForPageInPagingView:(CYGPagingView *)pagingView atIndex:(NSInteger)index {
    UIView *contentView = (UIView *)[pageView dequeueReusablePage];
    if (nil == contentView) {
        contentView = [[UIView alloc] init];
    }
    contentView.tag = index;
    
    return contentView;
}

- (void)currentPageDidChangeInPagingView:(CYGPagingView *)pagingView {
    self.pageControl.currentPage = pagingView.currentPageIndex;
}

@end
