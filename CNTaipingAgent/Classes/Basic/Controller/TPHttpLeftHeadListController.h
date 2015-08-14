//
//  TPHttpLeftHeadListController.h
//  CNTaipingAgent
//
//  Created by song on 14/11/11.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPHttpViewController.h"

@interface TPHttpLeftHeadListController : TPHttpViewController
@property(nonatomic, readonly) CYGListView*   headListview;    // tag = 101
@property(nonatomic, readonly) CYGListView*   contentListview; // tag = 102

- (void) requestListData:(TPPageInfoBO *)page;

//是否可以刷新最新
@property(nonatomic, assign) BOOL refreshable;
//数据记录集合
@property(nonatomic, strong, readonly) NSMutableArray *records;

//请求第一页数据
- (void) refreshListViewData;
//恢复为初始状态
- (void) restoreToInitialState;
@end
