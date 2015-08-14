#import <Foundation/Foundation.h>

@protocol CYGArrayViewDelegate;

// A container that arranges its items in rows and columns similar to the
// thumbnails screen in Photos.app, the API is modeled after UITableView.
@interface CYGArrayView : UIView 

/* Depending on memory, I you can use the preload buffer to buffer additional rows that
should be rendered. This is useful if we are usign CATiledLayer as the layerClass of the
UIView that will be used in the grid because CATiledLayer drawRect happens in the background. Doing this will
prevent a previous reusable "grid" cell to not show the content of previous cell while we continue to render the new cell's content.
This allows for smoother scrolling and minimizing 'jerkyness' when loading network resources in cells at the tradeoff of memory.
 */
@property(nonatomic,assign) int preloadBuffer;
@property(nonatomic, weak) IBOutlet id<CYGArrayViewDelegate> delegate;

@property(nonatomic, assign) UIEdgeInsets contentInsets;

@property(nonatomic, assign) CGSize itemSize;
@property(nonatomic, assign) BOOL   horizentalScroll;
@property(nonatomic, assign) CGFloat minimumColumnGap;
@property(nonatomic, assign) CGFloat rowGap;

@property(nonatomic, strong, readonly) UIScrollView *scrollView;



- (void)reloadData;  // must be called at least once to display something
- (UIView *)viewForItemAtIndex:(NSUInteger)index;  // nil if not loaded
- (UIView *)dequeueReusableItem;  // nil if none
- (CGRect)rectForItemAtIndex:(NSUInteger)index;

@end


@protocol CYGArrayViewDelegate <NSObject>
@required
- (NSInteger)numberOfItemsInArrayView:(CYGArrayView *)arrayView;
- (UIView *)viewForItemInArrayView:(CYGArrayView *)arrayView atIndex:(NSInteger)index;
@end

