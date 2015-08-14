//
//  UIThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-2-28.
//
//

#import <UIThemeKit/UIView+ThemeKit.h>
#import <UIThemeKit/UITableViewCell+ThemeKit.h>
#import <UIThemeKit/UITableView+ThemeKit.h>
#import <UIThemeKit/UIImageView+ThemeKit.h>
#import <UIThemeKit/UILabel+ThemeKit.h>
#import <UIThemeKit/UITextField+ThemeKit.h>
#import <UIThemeKit/UITextView+ThemeKit.h>
#import <UIThemeKit/UIScrollView+ThemeKit.h>



@interface UIThemeKit : NSObject
+(void) setGlobleThemeFile:(NSString*)themeFile;
//根据图片路径加载图片,此函数不在工程中实现的话，默认则
//使用[UIImage imageNamed:imageName],如需要重新实现
//请在工程中覆盖此函数
+(UIImage*) Image:(NSString*)imageName;
+(UIFont*) Font:(NSUInteger)fontSize;

+(NSString*) CachePath:(NSString*)fileName;

//计算文字显示高度
+(CGFloat) textHeight:(NSString*)text font:(UIFont*)font width:(CGFloat)width;
@end
