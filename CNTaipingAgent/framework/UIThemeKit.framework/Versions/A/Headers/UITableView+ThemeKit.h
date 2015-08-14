//
//  UITableView+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-3-1.
//
//

#import <UIKit/UIKit.h>



@interface UITableView (ThemeKit)
- (id)dequeueReusableCellOfDefultTheme;
- (id)dequeueReusableCellOfTheme:(NSString*)themeKey;
@end
