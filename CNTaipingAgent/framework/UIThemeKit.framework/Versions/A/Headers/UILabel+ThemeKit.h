//
//  UILabel+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-2-28.
//
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

/*---------------------------------------------------------------------------------------*
 配置属性说明：
 
 1、设置背景颜色
 关键字：backgroundcolor或backcolor
 值：字符串类型，可以是0xffffff形式，或clearColor，blackColor，darkGrayColor，lightGrayColor，
 whiteColor，grayColor，redColor，greenColor，blueColor，cyanColor，yellowColor，
 magentaColor，orangeColor，purpleColor，brownColor
 2、设置文字颜色
 关键字：textcolor，值：同背景色
 3、设置文字大小
 关键字：fontsize，值：正整数型
 4、设置文字对齐方式
 关键字：textalignment或alignment，值：正整数型，值域范围（0～4）
 5、设置阴影颜色
 关键字：shadowcolor，值：同背景色
 6、设置阴影区域
 关键字：shadowoffset，值：字符串类型，{x,y}形式
 7、设置最大行数
 关键字：numberoflines，值：正整数型
 8、设置行间距
 关键字：linespace，值：正整数型
 *---------------------------------------------------------------------------------------*/


typedef NS_ENUM(NSInteger, VerticalAlignment) {
    VerticalAlignmentTop = 1,
    VerticalAlignmentMiddle = 0,// default
    VerticalAlignmentBottom = 2
};

@interface UILabel (ThemeKit)
//获得当前label内文本文字显示需要的实际高度
@property(nonatomic, readonly)CGFloat textHeight;
//是否使用coretext模式描画，此一般用于多行文本模式，为了实现文字的对齐显示
//以避免在右侧出现犬牙不规则状
@property(nonatomic, assign)BOOL useAttributed;
//行间隙，只有在useAttributed＝true时有效
@property(nonatomic, assign)NSUInteger lineSpace;
//纵向显示方式
@property(nonatomic, assign)VerticalAlignment vAlignment;

//根据给定的宽度计算文本显示的实际高度
- (CGFloat)textHeight:(CGFloat)width;

/**
*	@brief	给文字添加属性，比如某部分区域文字需要改字体、文字变色
*注意：只有在useAttributed＝true时有效
*	@param 	ranges 	文字区域数组，每个元素为AttrRange
*	@param 	font 	文字类型
*	@param 	color 	文字颜色
*
*	@return	无
*/
-(void)addRange:(NSRange)range withFont:(UIFont *)font textColor:(UIColor *)color;
-(void)addRange:(NSRange)range textColor:(UIColor *)color;
/**
*	@brief	给某部分文字添加下划线
*
*	@param 	range 	添加下划线的文字区域
*	@param 	color 	下划线颜色
*	@param 	style 	下划线风格
*
*	@return	无
*/
-(void)underLine:(NSRange)range lineColor:(UIColor *)color style:(CTUnderlineStyleModifiers)style;

@end

