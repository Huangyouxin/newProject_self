//
//  TPLPopView.h
//  CNTaiPingAgent
//
//  Created by lee on 13-9-17.
//  Copyright (c) 2013年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TPLPopMenuViewArrowDirectionNone,
    TPLPopMenuViewArrowDirectionUp,
    TPLPopMenuViewArrowDirectionDown,
    TPLPopMenuViewArrowDirectionLeft,
    TPLPopMenuViewArrowDirectionRight,
} TPLPopMenuViewArrowDirection;

@interface TPLPopMenuItem : NSObject

@property (readwrite, nonatomic, strong) UIImage *image;
@property (readwrite, nonatomic, strong) NSString *title;
@property (readwrite, nonatomic, weak) id target;
@property (readwrite, nonatomic) SEL action;
@property (readwrite, nonatomic , assign) int tag;
@property (readwrite, nonatomic, strong) UIColor *foreColor;
@property (readwrite, nonatomic) NSTextAlignment alignment;

+ (instancetype) menuItem:(NSString *) title
                    image:(UIImage *) image
                   target:(id)target
                   action:(SEL) action
                      tag:(int)tag;

@end

@interface TPPopView : UIView


+ (void) showMenuInView:(UIView *)view
               fromRect:(CGRect)rect
              direction:(TPLPopMenuViewArrowDirection)direction
              menuItems:(NSArray *)menuItems;

+ (void) dismissMenu;

+ (UIColor *) tintColor;
+ (void) setTintColor: (UIColor *) tintColor;

+ (UIFont *) titleFont;
+ (void) setTitleFont: (UIFont *) titleFont;

@end
