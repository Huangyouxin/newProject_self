//
//  UIView+FromNib.h
//  libkit
//
//  Created by 崔玉国 on 12-11-13.
//
//

#import <UIKit/UIKit.h>



@interface UIView(FromNib)

//@{
+ (void) setGlobalNibName:(NSString*)nibName;
+ (UITableViewCell*) cellWithIdentifier:(NSString*)Identifier
                          withClassName:(NSString*)clsName;
+ (UIView*) viewWithClassName:(NSString*)clsName;
+ (UIView*) viewWithRestorationIdentifier:(NSString*)restorationIdentifier;
//@}


+ (UITableViewCell*) cellWithIdentifier:(NSString*)Identifier
                          withClassName:(NSString*)clsName
                                nibPath:(NSString *)nibPath;
+ (UIView*) viewWithClassName:(NSString*)clsName
                      nibPath:(NSString *)nibPath;
+ (UIView*) viewWithRestorationIdentifier:(NSString*)restorationIdentifier
                                  nibPath:(NSString *)nibPath;


- (UIView*) subViewWithRestorationIdentifier:(NSString*)restorationIdentifier;
@end



