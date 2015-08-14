//
//  CYGToolBar.h
//
//  Created by 崔玉国 on 13-11-17.
//  Copyright (c) 2013年 cuiyuguo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CYGToolBar;
@protocol CYGToolBarDelegate <NSObject>
@optional
- (void) CYGToolBar:(CYGToolBar*)toolbar clickIndex:(int)index;
@end



typedef NS_ENUM(NSInteger, CYGToolBarAlignment) {
    CYGToolBarAlignmentHorizentalLeft,  //横向从左侧开始排布
    CYGToolBarAlignmentHorizentalRight, //横向从右侧开始排布
    CYGToolBarAlignmentVerticalTop,     //纵向从顶端开始排布
    CYGToolBarAlignmentVerticalBottom   //纵向从底端开始排布
};

@interface CYGToolBarButtonItem : NSObject
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)UIColor  *titleColor;
@property(nonatomic, strong)UIColor  *highlitedTitleColor;
@property(nonatomic, strong)UIFont   *font;
@property(nonatomic, strong)UIImage  *bkImage;
@property(nonatomic, strong)UIImage  *highlitedBKImage;
@property(nonatomic, strong)UIImage  *iconImage;
@property(nonatomic, strong)UIImage  *highlitedIconImage;
@property(nonatomic)UIEdgeInsets      titleEdgeInsets;
@property(nonatomic)UIEdgeInsets      iconEdgeInsets;
@property(nonatomic, assign)CGFloat   dispWidth;
@property(nonatomic, assign)CGFloat   dispHeight;
@property(nonatomic, assign)BOOL      disableWhileClicked;
@property(nonatomic, assign)CGSize    iconSize;
@end

@interface CYGToolBarLabelItem : NSObject
@property(nonatomic, strong)NSString *text;
@property(nonatomic, strong)UIColor  *textColor;
@property(nonatomic, strong)UIFont   *font;
@property(nonatomic)NSTextAlignment   textAlignment;
@property(nonatomic, assign)CGFloat   dispWidth;
@property(nonatomic, assign)CGFloat   dispHeight;
@end

#define NSValueEdgeInsetsMake(l, t, r, b)  [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(l,t,r,b)]
typedef void (^CYGToolBarItemClickListener)(int index);
typedef UIView* (^CreateSelector)(void);
typedef float (^SelectAnimation)(UIView *selector, CGRect newRect);
/**
 *	@brief	工具条:此工具条做了强大的抽象，支持CYGToolBarButtonItem及CYGToolBarLabelItem
 *                等类型，它们的属性都是可选的。当然也可以通过字典形式传递，字典的关键字为相应
 *                的属性名。如果用字典形式，则必须标明是哪种类型，标法如：
 *                @"class":@"CYGToolBarButtonItem",
 *                另外：titleEdgeInsets和iconEdgeInsets如用字典形式传递需使用NSValueEdgeInsetsMake来组织
 *  使用上如：
 *     CYGToolBar* toolBar = [[CYGToolBar alloc] initWithItems:@[
 *                                @{@"class":@"CYGToolBarButtonItem", @"title":@"提交", 
 *                                  @"titleColor":[UIColor whiteColor], @"dispWidth":@80,
 *                                  @"bkImage":Image(@"behave/redButton.png"),
 *                                  @"font":FontOfSize(FontNormalSize)}]];
 */
@interface CYGToolBar : UIImageView
//控制控件的上下左右的空白，默认为UIEdgeInsetsZero
@property(nonatomic, assign)UIEdgeInsets contentInsets;
//子元素之间间隔,默认为10像素
@property(nonatomic, assign)int    step;
//子控件元素排布原则,默认为CYGToolBarAlignmentHorizentalLeft
@property(nonatomic, assign)CYGToolBarAlignment alignment;
//当前选中的子控件序号,初始为0
@property(nonatomic, assign)int selectedIndex;
//控件上的子元素数组，可以是CYGToolBarButtonItem，CYGToolBarLabelItem中任意
//另外也支持字典形式
@property(nonatomic, strong)NSArray* items;
//是否需要根据实际尺寸平均分配,
//如果为true那么当横向排列时dispWidth将不起作用
//如果为true那么当纵向排列时dispHeight将不起作用
@property(nonatomic, assign)BOOL isNeedCalculate;

- (id) initWithItems:(NSArray*)items;

//@{这两个是二选其一的，优先满足CYGToolBarItemClickListener的，其中
// index 是从0开始的
@property(nonatomic, weak)id<CYGToolBarDelegate> delegate;
- (void) setOnItemClickListener:(CYGToolBarItemClickListener)listener;
//@}

//如果需要有选中滑块效果，请调用此函数创建滑块，并控制滑块移动
- (void) addItemSelector:(CreateSelector)createBlock
         selectAnimation:(SelectAnimation)animation;
//根据index获得子控件
- (UIView*)getItemView:(NSUInteger)index;
@end
