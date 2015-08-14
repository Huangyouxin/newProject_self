
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, UIViewControllerAnimation) {
    UIViewControllerAnimationNone,
    UIViewControllerAnimationPush,
    UIViewControllerAnimationFlip,
    UIViewControllerAnimationCurl,
    UIViewControllerAnimationTurn//从下面向上插入
};


/*---------------------------------------------------------------------------------------*
 功能说明：
 
 1、实现右拽页面出栈动作
 2、如果已被push进来的顶层页面实现了 -(UIViewController*)detailViewController;
    当此函数返回的结果不为nil时，可以从右侧拽出一层页面
 3、如果页面有自己独特的对应的导航栏、状态条展示形式，需在-(void)updateStatusThemes中实现。
 *---------------------------------------------------------------------------------------*/


typedef NS_ENUM(NSInteger, UINavigationControllerDragPopStyle) {
    //不能拖拽出栈
    UINavigationControllerDragPopStyleNone,
    //整个屏幕内都可以拖拽出栈
    UINavigationControllerDragPopStyleDragPop,
    //只有在屏幕左侧边向右拖拽出栈，此时不支持-(UIViewController*)detailViewController
    UINavigationControllerDragPopStyleEdgeDragPop,
    //苹果特有的在屏幕左侧边向右拖拽出栈
    UINavigationControllerDragPopStyleInteractivePop,
};

@interface CYGNavigationController : UINavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
                    dragPopStyle:(UINavigationControllerDragPopStyle)style;

- (void)pushViewController:(UIViewController *)viewController
                 animation:(UIViewControllerAnimation)animation;

+ (instancetype)naviWithRootViewController:(UIViewController*)viewController;
@end


@interface UINavigationController (CYGAnimation)
- (void)pushViewController:(UIViewController *)viewController
                 animation:(UIViewControllerAnimation)animation;
+ (instancetype)naviWithRootViewController:(UIViewController*)viewController;
@end