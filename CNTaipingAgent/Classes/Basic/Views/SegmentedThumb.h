//
//  SegmentedThumb.h
//  SMHotel
//
//  Created by Stone on 14-6-15.
//  Copyright (c) 2014年 shimaogroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentedControl;

@interface SegmentedThumb : UIView

@property (nonatomic, strong) UIImage *backgroundImage; // default is nil;
@property (nonatomic, strong) UIImage *highlightedBackgroundImage; // default is nil;

@property (nonatomic, strong) UIColor *tintColor; // default is [UIColor grayColor]
@property (nonatomic, unsafe_unretained) UIColor *textColor; // default is [UIColor whiteColor]
@property (nonatomic, unsafe_unretained) UIColor *textShadowColor; // default is [UIColor blackColor]
@property (nonatomic, readwrite) CGSize textShadowOffset; // default is CGSizeMake(0, -1)
@property (nonatomic, readwrite) BOOL shouldCastShadow; // default is YES (NO when backgroundImage is set)

// deprecated properties
@property (nonatomic, unsafe_unretained) UIColor *shadowColor DEPRECATED_ATTRIBUTE; // use textShadowColor instead
@property (nonatomic, readwrite) CGSize shadowOffset DEPRECATED_ATTRIBUTE; // use textShadowOffset instead
@property (nonatomic, readwrite) BOOL castsShadow DEPRECATED_ATTRIBUTE; // use shouldCastShadow instead

@end

