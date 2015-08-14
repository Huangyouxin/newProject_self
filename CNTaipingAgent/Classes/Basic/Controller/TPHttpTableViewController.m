//
//  TPHttpTableViewController.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "TPHttpTableViewController.h"


@protocol TableDataRequestDelegate<NSObject>
@required
- (void) requestTableData:(TPPageInfoBO*)page;
@end


@interface TPHttpTableViewController()
<UITableViewDelegate, UITableViewDataSource,RefreshAndLoadMoreDelegate, TableDataRequestDelegate> {
    BOOL  refreshable;
}
//是否可以取下一页
@property(nonatomic, readonly)TPPageInfoBO* pageInfo;
@property(nonatomic, assign)int currentPage;
//请求代理
@property(nonatomic, weak)id<TableDataRequestDelegate>  delegate;
@end

@implementation TPHttpTableViewController
@synthesize tableview;
@synthesize delegate;
@synthesize pageInfo, currentPage;
@synthesize refreshable;
@synthesize records;


- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super init]) {
		CGFloat width  = [UIScreen mainScreen].applicationFrame.size.width;
		CGFloat height = [UIScreen mainScreen].applicationFrame.size.height;
		tableview = [[CYGTableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:style];
		tableview.delegate = self;
		tableview.dataSource = self;
		tableview.autoresizingMask = AutoresizingFull;
        tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableview.backgroundColor = [UIColor clearColor];
        tableview.flotageLabelBack = Image(@"backgrounds/flotageBackgroud");
		
        tableview.dataReqDelegate = self;
        tableview.delegate = self;
        self.delegate = self;
        
        records = [NSMutableArray array];
	}
	return self;
}

- (id)init {
	if (self = [self initWithStyle:UITableViewStylePlain]) {
	}
	return self;
}

- (void) setRecords:(NSMutableArray *)_records {
    records = _records;
    [self.tableview reloadData];
}

- (id) initWithMsgKey:(NSString*)msgKey {
    if (self = [self initWithStyle:UITableViewStylePlain]) {
        [self setValue:msgKey forKey:@"msgKey"];
        if (msgKey.length > 0) {
            NotificationAddObserver(self, msgKey, @selector(onInterfaceKeyMessage:));
        }
    }
    return self;
}

- (void) requestTableData:(TPPageInfoBO*)page {

}

- (void) viewDidLoad {
	[super viewDidLoad];
    self.currentPage = 1;

    records = [NSMutableArray array];
    
    self.tableview.frame = self.view.bounds;
    [self.view addSubview:self.tableview];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableview.editing = NO;
}

- (void) restoreToInitialState {
    self.currentPage = 1;
    pageInfo = nil;
    [self.records removeAllObjects];
    [self.tableview reloadData];
}

- (void) setPageInfo:(TPPageInfoBO *)info {
    if (info&&![info isKindOfClass:[TPPageInfoBO class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"老大，setPageInfo传进来的参数不是TPPageInfo类型！"];
    }
    if (nil == info) {
        [self.tableview stopDataReq];
        return;
    }
    pageInfo = info;
    //给当前页赋值
    int nowPage = [self.pageInfo.currentPageIndex intValue];
    if (self.currentPage <= nowPage) {
        self.currentPage = nowPage;
    }
    [self.tableview stopDataReq];
}


- (void) refreshTableViewData {
    @try {
        int pageSize = [self.pageInfo.pageSize intValue];
        pageSize = pageSize == 0 ? 10 : pageSize;
        TPPageInfoBO *pageInfoBO = [[TPPageInfoBO alloc] init];
        pageInfoBO.currentPageIndex = @1;
        pageInfoBO.pageSize = @(pageSize);

        if ([self.delegate conformsToProtocol:@protocol(TableDataRequestDelegate)] &&
            [self.delegate respondsToSelector:@selector(requestTableData:)]) {
            [self.delegate requestTableData:pageInfoBO];
        }
    }
    @catch (NSException *exception) {
        TPLLOG(@"------refreshTableViewData---%@", exception.reason);
    }
}


- (void) nextTableViewData {
    @try {
        int pageSize = [self.pageInfo.pageSize intValue];
        pageSize = pageSize == 0 ? 10 : pageSize;
        TPPageInfoBO *pageInfoBO = [[TPPageInfoBO alloc] init];
        pageInfoBO.currentPageIndex = @(self.currentPage+1);
        pageInfoBO.pageSize = @(pageSize);
        
        if ([self.delegate conformsToProtocol:@protocol(TableDataRequestDelegate)] &&
            [self.delegate respondsToSelector:@selector(requestTableData:)]) {
            [self.delegate requestTableData:pageInfoBO];
        }
    }
    @catch (NSException *exception) {
        TPLLOG(@"------nextTableViewData---%@", exception.reason);
    }
}

#pragma mark UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;//self.records.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* httpTableViewCellIdentefier = @"TPHttpTableViewController cell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:httpTableViewCellIdentefier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:httpTableViewCellIdentefier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
	}
	cell.textLabel.text = [NSString stringWithFormat:@"section:%ld,row=%ld",(long)indexPath.row, (long)indexPath.row];

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.5f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // To "clear" the footer view
    UIView* view = [UIView new];
    view.backgroundColor = tableView.separatorColor;
    return view;
}


//下拉刷新需要关注的两个方法
- (BOOL)scrollViewCanRefresh:(UIScrollView *)scrollView {
    BOOL canRefreshable =  nil != self.delegate && refreshable &&
    [self.delegate conformsToProtocol:@protocol(TableDataRequestDelegate)]&&
    [self.delegate respondsToSelector:@selector(requestTableData:)];
    return canRefreshable;
}

- (void)scrollViewStartRefresh:(UIScrollView *)scrollView {
    [self refreshTableViewData];
}

//加载更多需要关注的两个方法
- (BOOL)scrollViewCanLoadMore:(UIScrollView *)scrollView {
    if (self.currentPage < self.pageInfo.totlePage) {
        return YES;
    } else {
        return NO;
    }
}

- (void)scrollViewStartLoadMore:(UIScrollView *)scrollView {
    [self nextTableViewData];
}

- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message {
    [super remoteResponsFailed:actionTag withMessage:message];
    [self.tableview stopDataReq];
}
@end


