//
//  TPHttpListViewController.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-22.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPHttpViewController.h"

/**
 * @brief   主布局以listview为展现的页面
 */
@interface TPHttpListViewController : TPHttpViewController
@property(nonatomic, readonly) CYGListView*   listview;

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
