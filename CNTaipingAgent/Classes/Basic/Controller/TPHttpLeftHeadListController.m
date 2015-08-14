//
//  TPHttpLeftHeadListController.m
//  CNTaipingAgent
//
//  Created by song on 14/11/11.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPHttpLeftHeadListController.h"

@protocol ListDataRequestDelegate <NSObject>
@required
- (void) requestListData:(TPPageInfoBO*)page;
@end


@interface TPHttpLeftHeadListController () <CYGListViewDataSource, CYGListViewDelegate, RefreshAndLoadMoreDelegate, ListDataRequestDelegate,UIScrollViewDelegate>{
    BOOL refreshable;
}

//是否可以取下一页
@property(nonatomic, readonly)TPPageInfoBO *pageInfo;
@property(nonatomic, assign)int currentPage;
//请求代理
@property(nonatomic, weak)id<ListDataRequestDelegate> delegate;
@end

@implementation TPHttpLeftHeadListController
@synthesize contentListview;
@synthesize headListview;
@synthesize delegate;
@synthesize pageInfo, currentPage;
@synthesize refreshable;
@synthesize records;

- (void) setRecords:(NSMutableArray *)_records {
    records = _records;
    [self.contentListview reloadData];
    [self.headListview reloadData];
}


- (void) requestListData:(TPPageInfoBO *)page {

}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    
    records = [[NSMutableArray alloc] init];
    
    headListview = [[CYGListView alloc] initWithFrame:self.view.bounds];
    headListview.autoresizingMask = AutoresizingFull;
    headListview.delegate = self;
    headListview.dataSource = self;
    headListview.contentView.delegate = self;
    headListview.contentView.dataReqDelegate = self;
    headListview.tag = 101;
    headListview.contentView.tag = 101;
    headListview.selectedStyle = CYGListViewSelectedStyle_Cell;
    [self.view addSubview:headListview];
    
    contentListview = [[CYGListView alloc] initWithFrame:self.view.bounds];
    contentListview.autoresizingMask = AutoresizingFull;
    contentListview.delegate = self;
    contentListview.dataSource = self;
    contentListview.contentView.delegate = self;
    contentListview.contentView.dataReqDelegate = self;
    contentListview.tag = 102;
    contentListview.contentView.tag = 102;
    contentListview.selectedStyle = CYGListViewSelectedStyle_Cell;
    [self.view addSubview:contentListview];
    
    [headListview reloadData];
    [contentListview reloadData];
    
    self.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==102) {
        headListview.contentView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    }else if(scrollView.tag==101){
        contentListview.contentView.contentOffset = CGPointMake(contentListview.contentView.contentOffset.x, scrollView.contentOffset.y);
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) restoreToInitialState {
    self.currentPage = 1;
    pageInfo = nil;
    [self.records removeAllObjects];
    [self.contentListview reloadData];
    [self.headListview reloadData];
}

- (void) setPageInfo:(TPPageInfoBO *)info {
    if (info && ![info isKindOfClass:[TPPageInfoBO class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"老大，setPageInfo传进来的参数不是TPPageInfo类型！"];
    }
    if (nil == info) {
        [self.contentListview.contentView stopDataReq];
        return;
    }
    pageInfo = info;
    //给当前页赋值
    int nowPage = [self.pageInfo.currentPageIndex intValue];
    if (self.currentPage <= nowPage) {
        self.currentPage = nowPage;
    }
    [self.contentListview.contentView stopDataReq];
}

- (void) refreshListViewData {
    int pageSize = [self.pageInfo.pageSize intValue];
    pageSize = pageSize == 0 ? 50 : pageSize;
    TPPageInfoBO *pageInfoBO = [[TPPageInfoBO alloc] init];
    pageInfoBO.currentPageIndex = @1;
    pageInfoBO.pageSize = @(pageSize);
    
    if ([self.delegate conformsToProtocol:@protocol(ListDataRequestDelegate)] &&
        [self.delegate respondsToSelector:@selector(requestListData:)]) {
        [self.delegate requestListData:pageInfoBO];
    }
}

- (void) nextListViewData {
    int pageSize = [self.pageInfo.pageSize intValue];
    pageSize = pageSize == 0 ? 50 : pageSize;
    TPPageInfoBO *pageInfoBO = [[TPPageInfoBO alloc] init];
    pageInfoBO.currentPageIndex = @(self.currentPage + 1);
    pageInfoBO.pageSize = @(pageSize);
    
    if ([self.delegate conformsToProtocol:@protocol(ListDataRequestDelegate)] &&
        [self.delegate respondsToSelector:@selector(requestListData:)]) {
        [self.delegate requestListData:pageInfoBO];
    }
}

#pragma mark ListViewDelegate and ListViewDataSource

- (NSUInteger)numberOfRowsInListView:(CYGListView *)listView {
    return 10.0f;
}

- (NSUInteger)numberOfColsInListView:(CYGListView *)listView {
    if (listView.tag == 101) {
        return 1;
    }
    return 15.0f;
}

- (CGFloat)listView:(CYGListView *)listView widthForCol:(NSInteger)col {
    return 120.0f;
}

- (CGFloat)listView:(CYGListView *)listView heightForRow:(NSInteger)row {
    return 44.0f;
}

- (CGFloat)heightOfHeaderInListView:(CYGListView *)listView {
    return 32;
}

- (CYGListViewCell *)listView:(CYGListView *)listView headerForCol:(NSUInteger)col{
    static NSString *headerIdentifier = @"PerImageListheaderidentifier";
    CYGListViewLabelCell *cell = (CYGListViewLabelCell*)[listView dequeueReusableViewWithIdentifier:headerIdentifier];
    if (nil == cell) {
        cell = [[CYGListViewLabelCell alloc] initWithReuseIdentifier:headerIdentifier];
        cell.layer.borderWidth = 0;
        cell.layer.borderColor = [UIColor clearColor].CGColor;
    }
    cell.responseClickEvent = YES;
    cell.textLabel.text = [NSString stringWithFormat:@"第%d列", col];
    
    return cell;
}

- (CYGListViewCell *)listView:(CYGListView *)listView cellAtIndexPath:(CYGListIndexPath *)indexPath {
    static NSString *httpListViewCellIdentefier = @"CYGListViewCell Cell";
    CYGListViewLabelCell *cell = (CYGListViewLabelCell *)[listView dequeueReusableViewWithIdentifier:httpListViewCellIdentefier];
    if (nil == cell) {
        cell = [[CYGListViewLabelCell alloc] initWithReuseIdentifier:httpListViewCellIdentefier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.responseClickEvent = YES;
    cell.textLabel.text = [NSString stringWithFormat:@"Col:%d  Row:%d",indexPath.col,indexPath.row];
    
    return cell;
}

//下拉刷新需要关注的两个方法
- (BOOL)scrollViewCanRefresh:(UIScrollView *)scrollView {
    //    BOOL canRefreshable = nil != self.delegate && refreshable &&
    //    [self.delegate conformsToProtocol:@protocol(ListDataRequestDelegate)] &&
    //    [self.delegate respondsToSelector:@selector(requestListData:)];
    //    return canRefreshable;
    return NO;
}

- (void)scrollViewStartRefresh:(UIScrollView *)scrollView {
    [self refreshListViewData];
}

//加载更多需要关注的两个方法
- (BOOL)scrollViewCanLoadMore:(UIScrollView *)scrollView {
    //    if (self.currentPage < self.pageInfo.totlePage) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    return NO;
}

- (void)scrollViewStartLoadMore:(UIScrollView *)scrollView {
    [self nextListViewData];
}

- (void)remoteResponsFailed:(int)actionTag withMessage:(NSString *)message {
    [super remoteResponsFailed:actionTag withMessage:message];
}

@end
