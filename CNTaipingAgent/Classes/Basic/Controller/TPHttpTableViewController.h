//
//  TPHttpTableViewController.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "TPHttpViewController.h"






/**
 *	@brief	主布局以tableview为展现的页面
 */
@interface TPHttpTableViewController : TPHttpViewController
@property(nonatomic, readonly)CYGTableView*     tableview;

- (void) requestTableData:(TPPageInfoBO*)page;

//是否可以刷新最新
@property(nonatomic, assign)BOOL  refreshable;
//数据记录集合
@property(nonatomic, strong, readonly)NSMutableArray* records;


- (id)initWithStyle:(UITableViewStyle)style;

//请求第一页数据
- (void) refreshTableViewData;
//恢复为初始状态
- (void) restoreToInitialState;
@end


