//
//  CYGPopTipView.h
//
//  Created by cuiyuguo on 14-8-21.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

typedef NS_ENUM(NSInteger, CYGPopTipViewDirection) {
    CYGPopTipViewDirectionUp,
    CYGPopTipViewDirectionDown,
    CYGPopTipViewDirectionLeft,
    CYGPopTipViewDirectionRight
};

@interface CYGPopTipView : UIView

/** Show the popover
 *
 * Shows an animated popover in a given view, from a given rectangle.
 * The property isVisible will be set as YES as soon as the popover is added to the given view.
 *
 * @param text The text displayed.
 * @param direction The direction of the popover.
 * @param maxWidth The maximum width of the popover. If the popover won't fit in the given space, this will be overridden.
 * @param view that the popover will show base.
 */
+ (void)showText:(NSString *)text direction:(CYGPopTipViewDirection)direction maxWidth:(CGFloat)maxWidth atView:(UIView *)view;
+ (void)showContentView:(UIView *)contentView direction:(CYGPopTipViewDirection)direction maxSize:(CGSize)maxSize atView:(UIView *)view;

/** Hide the popover
 *
 * Hides the popover and removes it from the view.
 * The property isVisible will be set to NO when the animation is complete and the popover is removed from the parent view.
 */
+ (void)dismiss:(void (^)(void))completion;


/**-----------------------------------------------------------------------------
 * @name AMPopTip Properties
 * -----------------------------------------------------------------------------
 */

/** Font
 *
 * Holds the UIFont used in the popover
 */
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

/** Text Color
 *
 * Holds the UIColor of the text
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/** Popover Background Color
 *
 * Holds the UIColor for the popover's background
 */
@property (nonatomic, strong) UIColor *popoverColor UI_APPEARANCE_SELECTOR;

/** Popover border radius
 *
 * Holds the CGFloat with the popover's border radius
 */
@property (nonatomic, assign) CGFloat radius UI_APPEARANCE_SELECTOR;

/** Text Padding
 *
 * Holds the CGFloat with the padding used for the inner text
 */
@property (nonatomic, assign) CGFloat padding UI_APPEARANCE_SELECTOR;

/** Arrow size
 *
 * Holds the CGSize with the width and height of the arrow
 */
@property (nonatomic, assign) CGSize  arrowSize UI_APPEARANCE_SELECTOR;

/** Revealing Animation time
 *
 * Holds the NSTimeInterval with the duration of the revealing animation
 */
@property (nonatomic, assign) NSTimeInterval animationIn UI_APPEARANCE_SELECTOR;

/** Disappearing Animation time
 *
 * Holds the NSTimeInterval with the duration of the disappearing animation
 */
@property (nonatomic, assign) NSTimeInterval animationOut UI_APPEARANCE_SELECTOR;

/** Visibility
 *
 * Holds the readonly BOOL with the popover visiblity. The popover is considered visible as soon as
 * it's added as a subview, and invisible when the subview is removed from its parent.
 */
@property (nonatomic, assign, readonly) BOOL isVisible;

@end
