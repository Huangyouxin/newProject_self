//
//  UIView+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-3-1.
//
//

#import <UIKit/UIKit.h>




/*---------------------------------------------------------------------------------------*
 配置属性说明：
 
 设置背景颜色
 关键字：backgroundcolor或backcolor
 值：字符串类型，可以是0xffffff形式，或clearColor，blackColor，darkGrayColor，lightGrayColor，
 whiteColor，grayColor，redColor，greenColor，blueColor，cyanColor，yellowColor，
 magentaColor，orangeColor，purpleColor，brownColor
 *---------------------------------------------------------------------------------------*/

@interface UIView (ThemeKit)
//获得默认配置
+(instancetype)theme;
//获得特定配置
+(instancetype)theme:(NSString*)themeKey;


- (void)tapActionWithBlock:(void (^)(void))block;
- (void)longTapActionWithBlock:(void (^)(void))block;

//工具函数
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

- (void) addLayoutBlock:(void(^)(void))block;
@end
