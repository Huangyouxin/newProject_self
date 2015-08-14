//
//  SegmentedControl.h
//  SMHotel
//
//  Created by Stone on 14-6-15.
//  Copyright (c) 2014年 shimaogroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentedThumb.h"
#import <AvailabilityMacros.h>

@protocol SegmentedControlDelegate;

@interface SegmentedControl : UIControl

@property (nonatomic, copy) void (^changeHandler)(NSUInteger newIndex); // you can also use addTarget:action:forControlEvents:

@property (nonatomic, strong, readonly) SegmentedThumb *thumb;
@property (nonatomic, readwrite) NSUInteger selectedIndex; // default is 0
@property (nonatomic, readwrite) BOOL animateToInitialSelection; // default is NO
@property (nonatomic, readwrite) BOOL crossFadeLabelsOnDrag; // default is NO

@property (nonatomic, strong) UIColor *tintColor; // default is [UIColor grayColor]
@property (nonatomic, strong) UIImage *backgroundImage; // default is nil

@property (nonatomic, readwrite) UIEdgeInsets thumbEdgeInset; // default is UIEdgeInsetsMake(2, 2, 3, 2)
@property (nonatomic, readwrite) UIEdgeInsets titleEdgeInsets; // default is UIEdgeInsetsMake(0, 10, 0, 10)
@property (nonatomic, readwrite) CGFloat cornerRadius; // default is 4.0

@property (nonatomic, strong) UIFont *font; // default is [UIFont boldSystemFontOfSize:15]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor grayColor];
@property (nonatomic, strong) UIColor *textShadowColor;  // default is [UIColor blackColor]
@property (nonatomic, readwrite) CGSize textShadowOffset;  // default is CGSizeMake(0, -1)

// deprecated properties
@property (nonatomic, copy) void (^selectedSegmentChangedHandler)(id sender) DEPRECATED_ATTRIBUTE; // use changeHandler instead
@property (nonatomic, strong) UIColor *shadowColor DEPRECATED_ATTRIBUTE;  // use textShadowColor instead
@property (nonatomic, readwrite) CGSize shadowOffset DEPRECATED_ATTRIBUTE;  // use textShadowOffset instead
@property (nonatomic, unsafe_unretained) id<SegmentedControlDelegate> delegate DEPRECATED_ATTRIBUTE; // use addTarget:action:forControlEvents: instead
@property (nonatomic, readwrite) CGFloat segmentPadding DEPRECATED_ATTRIBUTE; // use titleEdgeInsets instead

- (SegmentedControl*)initWithSectionTitles:(NSArray*)titlesArray images:(NSArray*)imagesArray;
- (void)moveThumbToIndex:(NSUInteger)segmentIndex animate:(BOOL)animate;

- (void) updateSegmentTitles:(NSArray *)array;
@end


@protocol SegmentedControlDelegate

- (void)segmentControl:(SegmentedControl*)segmentedControl didSelectIndex:(NSUInteger)index;

@end

