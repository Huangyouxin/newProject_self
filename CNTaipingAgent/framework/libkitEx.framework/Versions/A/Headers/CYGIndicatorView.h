
@protocol CYGIndicatorViewDelegate;

@interface CYGIndicatorView : UIView

//圆点点的数量
@property (readwrite, nonatomic) NSUInteger numberOfCircles UI_APPEARANCE_SELECTOR;
//圆点点间的空隙
@property (readwrite, nonatomic) CGFloat internalSpacing UI_APPEARANCE_SELECTOR;
//圆点点的直径
@property (readwrite, nonatomic) CGFloat radius UI_APPEARANCE_SELECTOR;

//每个圆点点的动画延迟时间
@property (readwrite, nonatomic) CGFloat delay UI_APPEARANCE_SELECTOR;
//每个圆点点动画时间
@property (readwrite, nonatomic) CGFloat duration UI_APPEARANCE_SELECTOR;


@property (weak, nonatomic) id<CYGIndicatorViewDelegate> delegate;


//开始动画
- (void)startAnimating;
+ (void)startAnimating:(UIView*)inView;

//结束动画
- (void)stopAnimating;
+ (void)stopAnimating;
@end

@protocol CYGIndicatorViewDelegate <NSObject>

@optional
- (UIColor *)cygIndicatorView:(CYGIndicatorView *)indicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index;

@end
