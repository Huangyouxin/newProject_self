//
//  UIScrollView+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-3-1.
//
//




//设置刷新view的展现属性通知
UIKIT_EXTERN NSString *const NotificationRefreshViewTheme;
//{@
//正在下拉状态时的状态文字（传字符串类型数据）
UIKIT_EXTERN NSString *const CYGRefreshPullingStatusText;
//正在加载中状态时的状态文字（传字符串类型数据）
UIKIT_EXTERN NSString *const CYGRefreshLoadingStatusText;
//正常状态时的状态文字（传字符串类型数据）
UIKIT_EXTERN NSString *const CYGRefreshNormalStatusText;
//最近一次更新显示文字（传字符串类型数据）
UIKIT_EXTERN NSString *const CYGRefreshLastUpdatedShowText;
//刷新环颜色（传UIColor型数据）
UIKIT_EXTERN NSString *const CYGRefreshCircleDrawColor;
//刷新状态文字颜色（传UIColor型数据）
UIKIT_EXTERN NSString *const CYGRefreshStatusTextColor;
//最近一次更新显示文字颜色（传UIColor型数据）
UIKIT_EXTERN NSString *const CYGRefreshLastUpdatedTextColor;
//@}

//设置系统语言的通知
UIKIT_EXTERN NSString *const NotificationLoadMoreViewTheme;
//{@
//正在上拉状态时的状态文字
UIKIT_EXTERN NSString *const CYGLoadMorePullingStatusText;
//正在加载中状态时的状态文字
UIKIT_EXTERN NSString *const CYGLoadMoreLoadingStatusText;
//正常状态时的状态文字
UIKIT_EXTERN NSString *const CYGLoadMoreNormalStatusText;
//状态文字颜色（传UIColor型数据）
UIKIT_EXTERN NSString *const CYGLoadMoreStatusTextColor;
//@}

@protocol RefreshAndLoadMoreDelegate<NSObject>
//下拉刷新需要关注的两个方法
- (BOOL)scrollViewCanRefresh:(UIScrollView *)scrollView;
- (void)scrollViewStartRefresh:(UIScrollView *)scrollView;
//加载更多需要关注的两个方法
- (BOOL)scrollViewCanLoadMore:(UIScrollView *)scrollView;
- (void)scrollViewStartLoadMore:(UIScrollView *)scrollView;
@end


@interface UIScrollView (ThemeKit)
@property(nonatomic,weak)id<RefreshAndLoadMoreDelegate> dataReqDelegate;
//数据请求完毕后恢复到初始状态
- (void) stopDataReq;
@end
