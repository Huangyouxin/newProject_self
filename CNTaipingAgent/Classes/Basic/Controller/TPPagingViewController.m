//
//  TPLPagingViewController.m
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-11-17.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "TPPagingViewController.h"

@interface TPPagingViewController ()<CYGPagingViewDelegate>
@property(nonatomic, strong)NSMutableArray *pageViewControllers;
@property(nonatomic, readonly)NSString*  searchViewControllerClassNameEx;
@property(nonatomic, readonly)NSString*  searchViewMsgKeyEx;
@property(nonatomic, readonly)BOOL       userParentSearchViewEx;
@end

@implementation TPPagingViewController
@synthesize pagingView;
@synthesize viewControllers;
@synthesize pageViewControllers;
@synthesize noSearchCheck;

#pragma mark -
#pragma mark init/dealloc

- (BOOL) userParentSearchViewEx {
    if (self.pageViewControllers.count <= pagingView.currentPageIndex ||
        ![self.pageViewControllers[pagingView.currentPageIndex] respondsToSelector:@selector(userParentSearchView)]) {
        return self.userParentSearchView;
    } else {
        UIViewController *viewController = self.pageViewControllers[pagingView.currentPageIndex];
        return ((TPViewController*)viewController).userParentSearchView;
    }
}

- (NSString*)searchViewControllerClassNameEx {
    if (self.pageViewControllers.count <= pagingView.currentPageIndex ||
        ![self.pageViewControllers[pagingView.currentPageIndex] respondsToSelector:@selector(searchViewControllerClassName)]) {
        return self.searchViewControllerClassName;
    } else {
        TPViewController *viewController = (TPViewController*)self.pageViewControllers[pagingView.currentPageIndex];
        NSString *searchViewClass = nil;
        NSString *msgKey = nil;
        BOOL userParentSearchView = NO;
        if ([viewController respondsToSelector:@selector(searchViewControllerClassNameEx)]) {
            searchViewClass = [viewController valueForKey:@"searchViewControllerClassNameEx"];
        } else {
            searchViewClass = ((TPViewController*)viewController).searchViewControllerClassName;
        }
        if ([viewController respondsToSelector:@selector(searchViewMsgKeyEx)]) {
            msgKey = [viewController valueForKey:@"searchViewMsgKeyEx"];
        } else {
            msgKey = ((TPViewController*)viewController).searchViewMsgKey;
        }
        if ([viewController respondsToSelector:@selector(userParentSearchViewEx)]) {
            userParentSearchView = [[viewController valueForKey:@"userParentSearchViewEx"] boolValue];
        } else {
            userParentSearchView = ((TPViewController*)viewController).userParentSearchView;
        }
        
        if (userParentSearchView) {
            return self.searchViewControllerClassName;
        } else if (searchViewClass && msgKey) {
            return searchViewClass;
        } else {
            return nil;
        }
    }
}
- (NSString*)searchViewMsgKeyEx {
    if (self.pageViewControllers.count <= pagingView.currentPageIndex ||
        ![self.pageViewControllers[pagingView.currentPageIndex] respondsToSelector:@selector(searchViewMsgKey)]) {
        return self.searchViewControllerClassName;
    } else {
        TPViewController *viewController = (TPViewController*)self.pageViewControllers[pagingView.currentPageIndex];
        NSString *searchViewClass = nil;
        NSString *msgKey = nil;
        BOOL userParentSearchView = NO;
        if ([viewController respondsToSelector:@selector(searchViewControllerClassNameEx)]) {
            searchViewClass = [viewController valueForKey:@"searchViewControllerClassNameEx"];
        } else {
            searchViewClass = ((TPViewController*)viewController).searchViewControllerClassName;
        }
        if ([viewController respondsToSelector:@selector(searchViewMsgKeyEx)]) {
            msgKey = [viewController valueForKey:@"searchViewMsgKeyEx"];
        } else {
            msgKey = ((TPViewController*)viewController).searchViewMsgKey;
        }
        if ([viewController respondsToSelector:@selector(userParentSearchViewEx)]) {
            userParentSearchView = [[viewController valueForKey:@"userParentSearchViewEx"] boolValue];
        } else {
            userParentSearchView = ((TPViewController*)viewController).userParentSearchView;
        }
        if (userParentSearchView) {
            return self.searchViewMsgKey;
        } else if (searchViewClass && msgKey) {
            return msgKey;
        } else {
            return nil;
        }
    }
}

- (void)dealloc {
    self.viewControllers = nil;
    self.pageViewControllers = nil;
}


#pragma mark -
#pragma mark View Loading
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景有图片没有任何意义，白占用内存。
    self.backgroundView.image = nil;
    
    pagingView = [[CYGPagingView alloc] initWithFrame:self.view.bounds];
	pagingView.scrollEnabled = NO;
    pagingView.gapBetweenPages = 0;
    pagingView.recyclingEnabled = NO;
    pagingView.backgroundColor = [UIColor clearColor];
    pagingView.autoresizingMask = AutoresizingFull;
    pagingView.delegate = self;
    [self.view addSubview:pagingView];
    self.noSearchCheck = YES;
    
    //到最左边或最右边时不能再拖动
    UIScrollView *scrollView = (UIScrollView*)[pagingView descendantOrSelfWithClass:[UIScrollView class]];
    scrollView.bounces = NO;
}

#pragma mark Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.pagingView reloadData];
}

- (void) setViewControllers:(NSArray *)controllers {
    viewControllers = controllers;
    if (nil == self.pageViewControllers) {
        self.pageViewControllers = [NSMutableArray array];
    } else {
        [self.pageViewControllers removeAllObjects];
    }
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIViewController class]]) {
            [self.pageViewControllers addObject:obj];
        } else {
            [self.pageViewControllers addObject:[NSNull null]];
        }
    }];
}

#pragma mark -
#pragma mark ATPagingViewDelegate methods

- (NSInteger)numberOfPagesInPagingView:(CYGPagingView *)pagingView {
    return self.viewControllers.count;
}

- (UIView *)viewForPageInPagingView:(CYGPagingView *)pagingView atIndex:(NSInteger)index {
    if (self.pageViewControllers[index] == [NSNull null]) {
        NSString *className = self.viewControllers[index];
        Class class = NSClassFromString(className);
        TPViewController *vc = [[class alloc] initWithMsgKey:className];
        vc.superMsgKey = self.msgKey;
        self.pageViewControllers[index] = vc;
    }
    ((UIViewController*)self.pageViewControllers[index]).param = self.param;
    return ((UIViewController*)self.pageViewControllers[index]).view;
}

- (void)pagesDidChangeInPagingView:(CYGPagingView *)pagingView {
    if (!self.noSearchCheck) {
        return ;
    }
    NSString *searchViewClass = self.searchViewControllerClassNameEx;
    NSString *msgKey = self.searchViewMsgKeyEx;
    BOOL userParentSearchView = self.userParentSearchViewEx;
    
    if (userParentSearchView) {
        searchViewClass = self.searchViewControllerClassNameEx;
        msgKey = self.searchViewMsgKey;
        if (nil == searchViewClass || nil == msgKey) {
            if ([self.navigationController respondsToSelector:@selector(postSearchViewMsg)]) {
                [self.navigationController performSelector:@selector(postSearchViewMsg)];
            }
            return;
        }
    }
}
@end