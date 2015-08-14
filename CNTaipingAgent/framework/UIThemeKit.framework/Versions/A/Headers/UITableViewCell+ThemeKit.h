//
//  UITableViewCell+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-2-28.
//
//

#import <UIKit/UIKit.h>




/*---------------------------------------------------------------------------------------*
 配置属性说明：
 
 1、设置textLabel、detailTextLabel同UILabel的默认属性
 2、设置backgroundColor和contentView.backgroundColor为透明色
 
 3、设置style类型
 关键字：style，值：正整数，值域氛围（0～3）
 4、设置附属类型
 关键字：accessoryType，值：正整数，值域氛围（0～4）
 5、设置选择背景类型
 关键字：selectionStyle，值：正整数，值域氛围（0～3）
 6、设置分割线区域
 关键字：separatorInset，值：字符串类型，{top,left,bottom,right}
 *---------------------------------------------------------------------------------------*/


@interface UITableViewCell (ThemeKit)
//从默认配置派生，使用此来初始化
- (instancetype)initTheme;
//从默认配置派生，使用传入的identifier
- (instancetype)initWithIdentifier:(NSString*)identifier;
//从特定配置派生，使用此来初始化
- (instancetype)initTheme:(NSString*)themeKey;
@end
