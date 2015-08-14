#import <Foundation/Foundation.h>



@protocol CYGPagingViewDelegate;

// a wrapper around UIScrollView in (horizontal) paging mode, with an API similar to UITableView
@interface CYGPagingView : UIImageView

@property(nonatomic, weak) IBOutlet id<CYGPagingViewDelegate> delegate;
@property(nonatomic, assign) CGFloat gapBetweenPages;  // default is 20
@property(nonatomic, assign) NSInteger pagesToPreload;  // number of invisible pages to keep loaded to each side of the visible pages, default is 1

@property(nonatomic, readonly) NSInteger pageCount;
@property(nonatomic, assign) NSInteger currentPageIndex;
@property(nonatomic, assign, readonly) NSInteger previousPageIndex; // only for reading inside currentPageDidChangeInPagingView
@property(nonatomic, assign, readonly) NSInteger firstVisiblePageIndex;
@property(nonatomic, assign, readonly) NSInteger lastVisiblePageIndex;
@property(nonatomic, assign, readonly) NSInteger firstLoadedPageIndex;
@property(nonatomic, assign, readonly) NSInteger lastLoadedPageIndex;
@property(nonatomic, assign, readonly) BOOL moving;
@property(nonatomic, assign) BOOL recyclingEnabled;
@property(nonatomic, assign) BOOL scrollEnabled;


- (void)reloadData;  // must be called at least once to display something
- (UIView *)viewForPageAtIndex:(NSUInteger)index;  // nil if not loaded
- (UIView *)dequeueReusablePage;  // nil if none
- (void)willAnimateRotation;  // call this from willAnimateRotationToInterfaceOrientation:duration:
- (void)didRotate;  // call this from didRotateFromInterfaceOrientation:

@end


@protocol CYGPagingViewDelegate <NSObject, UIScrollViewDelegate>

@required

- (NSInteger)numberOfPagesInPagingView:(CYGPagingView *)pagingView;

- (UIView *)viewForPageInPagingView:(CYGPagingView *)pagingView atIndex:(NSInteger)index;

@optional
- (void)currentPageDidChangeInPagingView:(CYGPagingView *)pagingView;

- (void)pagesDidChangeInPagingView:(CYGPagingView *)pagingView;

// a good place to start and stop background processing
- (void)pagingViewWillBeginMoving:(CYGPagingView *)pagingView;
- (void)pagingViewDidEndMoving:(CYGPagingView *)pagingView;
@end

