//
//  TPLPopView.m
//  CNTaiPingAgent
//
//  Created by lee on 13-9-17.
//  Copyright (c) 2013年 lee. All rights reserved.
//

#import "TPPopView.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat PopArrowSize = 12.f;

@implementation TPLPopMenuItem

+ (instancetype) menuItem:(NSString *) title image:(UIImage *) image target:(id)target action:(SEL) action tag:(int)tag{
    return [[TPLPopMenuItem alloc] init:title image:image target:target action:action tag:tag];
}

- (id) init:(NSString *) title image:(UIImage *) image target:(id)target action:(SEL) action tag:(int)tag{
    NSParameterAssert(title.length || image);
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _target = target;
        _action = action;
        _tag = tag;
        self.alignment = NSTextAlignmentCenter;
    }
    return self;
}

- (BOOL) enabled
{
    return _target != nil && _action != NULL;
}

- (void) performAction
{
    __strong id target = self.target;
    if (target && [target respondsToSelector:_action]) {
        [target performSelectorOnMainThread:_action withObject:self waitUntilDone:YES];
    }
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"<%@ #%p %@>", [self class], self, _title];
}

@end


@interface TPLPopMenuView : UIView

@end

@interface TPLPopMenuOverlay : UIView
@end

@implementation TPLPopMenuOverlay

// - (void) dealloc { NSLog(@"dealloc %@", self); }

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *touched = [[touches anyObject] view];
    if (touched == self) {
        for (UIView *v in self.subviews) {
            if ([v isKindOfClass:[TPLPopMenuView class]] &&
                [v respondsToSelector:@selector(dismissMenu:)]) {
                [v performSelector:@selector(dismissMenu:) withObject:@(YES)];
            }
        }
    }
}

@end


@implementation TPLPopMenuView {
    TPLPopMenuViewArrowDirection    _arrowDirection;
    CGFloat                     _arrowPosition;
    UIView                      *_contentView;
    NSArray                     *_menuItems;
}

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        self.alpha = 0;
        
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 2;
    }
    return self;
}

// - (void) dealloc { NSLog(@"dealloc %@", self); }

- (void) setupFrameInView:(UIView *)view fromRect:(CGRect)fromRect{
    const CGSize contentSize = _contentView.frame.size;
    const CGFloat outerWidth = view.bounds.size.width;
    const CGFloat outerHeight = view.bounds.size.height;
    
    const CGFloat rectX0 = fromRect.origin.x;
    const CGFloat rectX1 = fromRect.origin.x + fromRect.size.width;
    const CGFloat rectXM = fromRect.origin.x + fromRect.size.width * 0.5f;
    const CGFloat rectY0 = fromRect.origin.y;
    const CGFloat rectY1 = fromRect.origin.y + fromRect.size.height;
    const CGFloat rectYM = fromRect.origin.y + fromRect.size.height * 0.5f;;
    
    const CGFloat widthPlusArrow = contentSize.width + PopArrowSize;
    const CGFloat heightPlusArrow = contentSize.height + PopArrowSize;
    const CGFloat widthHalf = contentSize.width * 0.5f;
    const CGFloat heightHalf = contentSize.height * 0.5f;
    const CGFloat kMargin = 5.f;
    
    if (_arrowDirection == TPLPopMenuViewArrowDirectionUp) {
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY1
        };
        
        if (point.x < kMargin) point.x = kMargin;
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        //_arrowPosition = MAX(16, MIN(_arrowPosition, contentSize.width - 16));
        _contentView.frame = (CGRect){0, PopArrowSize, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + PopArrowSize
        };

        
    }else if (_arrowDirection == TPLPopMenuViewArrowDirectionDown){
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        if (point.x < kMargin) point.x = kMargin;
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + PopArrowSize
        };

    
    }else if(_arrowDirection == TPLPopMenuViewArrowDirectionLeft){
        CGPoint point = (CGPoint){
            rectX1,
            rectYM - heightHalf
        };
        if (point.y < kMargin) point.y = kMargin;
        if ((point.y + contentSize.height + kMargin) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){PopArrowSize, 0, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width + PopArrowSize,
            contentSize.height
        };

        
    }else if (_arrowDirection == TPLPopMenuViewArrowDirectionRight){
        CGPoint point = (CGPoint){
            rectX0 - widthPlusArrow,
            rectYM - heightHalf
        };
        if (point.y < kMargin) point.y = kMargin;
        if ((point.y + contentSize.height + 5) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        self.frame = (CGRect) {
            point,
            contentSize.width  + PopArrowSize,
            contentSize.height
        };

    
    }else{
        self.frame = (CGRect) {
            (outerWidth - contentSize.width)   * 0.5f,
            (outerHeight - contentSize.height) * 0.5f,
            contentSize,
        };
    
    }
    
    
    
    
//    if (heightPlusArrow < (outerHeight - rectY1)) {
//        _arrowDirection = TPLPopMenuViewArrowDirectionUp;
//        CGPoint point = (CGPoint){
//            rectXM - widthHalf,
//            rectY1
//        };
//        
//        if (point.x < kMargin) point.x = kMargin;
//        if ((point.x + contentSize.width + kMargin) > outerWidth)
//            point.x = outerWidth - contentSize.width - kMargin;
//        
//        _arrowPosition = rectXM - point.x;
//        //_arrowPosition = MAX(16, MIN(_arrowPosition, contentSize.width - 16));
//        _contentView.frame = (CGRect){0, PopArrowSize, contentSize};
//        self.frame = (CGRect) {
//            point,
//            contentSize.width,
//            contentSize.height + PopArrowSize
//        };
//        
//    } else if (heightPlusArrow < rectY0) {
//        _arrowDirection = TPLPopMenuViewArrowDirectionDown;
//        CGPoint point = (CGPoint){
//            rectXM - widthHalf,
//            rectY0 - heightPlusArrow
//        };
//        if (point.x < kMargin) point.x = kMargin;
//        if ((point.x + contentSize.width + kMargin) > outerWidth)
//            point.x = outerWidth - contentSize.width - kMargin;
//        
//        _arrowPosition = rectXM - point.x;
//        _contentView.frame = (CGRect){CGPointZero, contentSize};
//        self.frame = (CGRect) {
//            point,
//            contentSize.width,
//            contentSize.height + PopArrowSize
//        };
//    } else if (widthPlusArrow < (outerWidth - rectX1)) {
//        _arrowDirection = TPLPopMenuViewArrowDirectionLeft;
//        CGPoint point = (CGPoint){
//            rectX1,
//            rectYM - heightHalf
//        };
//        if (point.y < kMargin) point.y = kMargin;
//        if ((point.y + contentSize.height + kMargin) > outerHeight)
//            point.y = outerHeight - contentSize.height - kMargin;
//        
//        _arrowPosition = rectYM - point.y;
//        _contentView.frame = (CGRect){PopArrowSize, 0, contentSize};
//        self.frame = (CGRect) {
//            point,
//            contentSize.width + PopArrowSize,
//            contentSize.height
//        };
//    } else if (widthPlusArrow < rectX0) {
//        _arrowDirection = TPLPopMenuViewArrowDirectionRight;
//        CGPoint point = (CGPoint){
//            rectX0 - widthPlusArrow,
//            rectYM - heightHalf
//        };
//        if (point.y < kMargin) point.y = kMargin;
//        if ((point.y + contentSize.height + 5) > outerHeight)
//            point.y = outerHeight - contentSize.height - kMargin;
//        
//        _arrowPosition = rectYM - point.y;
//        _contentView.frame = (CGRect){CGPointZero, contentSize};
//        self.frame = (CGRect) {
//            point,
//            contentSize.width  + PopArrowSize,
//            contentSize.height
//        };
//    } else {
//        _arrowDirection = TPLPopMenuViewArrowDirectionNone;
//        self.frame = (CGRect) {
//            (outerWidth - contentSize.width)   * 0.5f,
//            (outerHeight - contentSize.height) * 0.5f,
//            contentSize,
//        };
//    }
}

- (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect  direction: (TPLPopMenuViewArrowDirection)direction menuItems:(NSArray *)menuItems
{
    _arrowDirection = direction;
    _menuItems = menuItems;
    _contentView = [self mkContentView];
//    _contentView.backgroundColor = BACKCOLOR(@"0x202538");
    [self addSubview:_contentView];
    [self setupFrameInView:view fromRect:rect];
    TPLPopMenuOverlay *overlay = [[TPLPopMenuOverlay alloc] initWithFrame:view.bounds];
    [overlay addSubview:self];
    [view addSubview:overlay];
    
    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    self.frame = (CGRect){self.arrowPoint, 1, 1};
    
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         self.alpha = 1.0f;
                         self.frame = toFrame;
                     } completion:^(BOOL completed) {
                         _contentView.hidden = NO;
                     }];
}

- (void)dismissMenu:(BOOL) animated
{
    if (self.superview) {
        if (animated) {
            _contentView.hidden = YES;
            const CGRect toFrame = (CGRect){self.arrowPoint, 1, 1};
            [UIView animateWithDuration:0.2
                             animations:^(void) {
                                 self.alpha = 0;
                                 self.frame = toFrame;
                             } completion:^(BOOL finished) {
                                 if ([self.superview isKindOfClass:[TPLPopMenuOverlay class]]){
                                     [self.superview removeFromSuperview];
                                 }
                                 [self removeFromSuperview];
                             }];
        } else {
            if ([self.superview isKindOfClass:[TPLPopMenuOverlay class]])
                [self.superview removeFromSuperview];
            [self removeFromSuperview];
        }
    }
}

- (void)performAction:(id)sender
{
    [self dismissMenu:YES];
    UIButton *button = (UIButton *)sender;
    TPLPopMenuItem *menuItem = _menuItems[button.tag];
    [menuItem performAction];
}

- (UIView *) mkContentView
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    if (!_menuItems.count)
        return nil;
    
    const CGFloat kMinMenuItemHeight = 32.f;
    const CGFloat kMinMenuItemWidth = 32.f;
    const CGFloat kMarginX = 5.f;
    const CGFloat kMarginY = 0.f;
    
    UIFont *titleFont = [TPPopView titleFont];
    if (!titleFont) titleFont = [UIFont boldSystemFontOfSize:16];
    
    CGFloat maxImageWidth = 0;
    CGFloat maxItemHeight = 0;
    CGFloat maxItemWidth = 0;
    
    for (TPLPopMenuItem *menuItem in _menuItems) {
        const CGSize imageSize = menuItem.image.size;
        if (imageSize.width > maxImageWidth)  maxImageWidth = imageSize.width;
    }
    
    for (TPLPopMenuItem *menuItem in _menuItems) {
        const CGSize titleSize = [menuItem.title sizeWithAttributes: @{NSFontAttributeName:titleFont}];
        const CGSize imageSize = menuItem.image.size;
        
        const CGFloat itemHeight = MAX(titleSize.height, imageSize.height) + kMarginY * 2;
        const CGFloat itemWidth = (menuItem.image ? maxImageWidth + kMarginX : 0) + titleSize.width + kMarginX * 4;
        if (itemHeight > maxItemHeight) maxItemHeight = itemHeight;
        if (itemWidth > maxItemWidth)  maxItemWidth = itemWidth;
    }
    maxItemWidth  = MAX(maxItemWidth, kMinMenuItemWidth);
    maxItemHeight = MAX(maxItemHeight, kMinMenuItemHeight);
    
    const CGFloat titleX = kMarginX * 2 + (maxImageWidth > 0 ? maxImageWidth + kMarginX : 0);
    const CGFloat titleWidth = maxItemWidth - titleX - kMarginX;
    
    UIImage *selectedImage = [TPLPopMenuView selectedImage:(CGSize){maxItemWidth, maxItemHeight + 2}];
    UIImage *gradientLine = [TPLPopMenuView gradientLine: (CGSize){maxItemWidth - kMarginX * 4, 1}];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.autoresizingMask = UIViewAutoresizingNone;
    contentView.backgroundColor = [UIColor clearColor];//BACKCOLOR(@"0x202538");//
    contentView.opaque = NO;
    
    CGFloat itemY = kMarginY * 2;
    NSUInteger itemNum = 0;
    
    for (TPLPopMenuItem *menuItem in _menuItems) {
        const CGRect itemFrame = (CGRect){0, itemY, maxItemWidth, maxItemHeight};
        
        UIView *itemView = [[UIView alloc] initWithFrame:itemFrame];
        itemView.autoresizingMask = UIViewAutoresizingNone;
        itemView.backgroundColor = [UIColor clearColor];
        itemView.opaque = NO;
        
        [contentView addSubview:itemView];
        if (menuItem.enabled) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = itemNum;
            button.frame = itemView.bounds;
            button.enabled = menuItem.enabled;
            button.backgroundColor = [UIColor clearColor];
            button.opaque = NO;
            button.autoresizingMask = UIViewAutoresizingNone;
            [button addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
            [itemView addSubview:button];
        }
        if (menuItem.title.length) {
            CGRect titleFrame;
            if (!menuItem.enabled && !menuItem.image) {
                titleFrame = (CGRect){
                    kMarginX * 2,
                    kMarginY,
                    maxItemWidth - kMarginX * 4,
                    maxItemHeight - kMarginY * 2
                };
            } else {
                titleFrame = (CGRect){
                    titleX,
                    kMarginY,
                    titleWidth,
                    maxItemHeight - kMarginY * 2
                };
            }
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
            titleLabel.text = menuItem.title;
            titleLabel.font = titleFont;
            titleLabel.textAlignment = menuItem.alignment;
            titleLabel.textColor = menuItem.foreColor ? menuItem.foreColor : [UIColor whiteColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.autoresizingMask = UIViewAutoresizingNone;
            //titleLabel.backgroundColor = [UIColor greenColor];
            [itemView addSubview:titleLabel];
        }
        if (menuItem.image) {
            const CGRect imageFrame = {kMarginX * 2, kMarginY, maxImageWidth, maxItemHeight - kMarginY * 2};
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
            imageView.image = menuItem.image;
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeCenter;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            [itemView addSubview:imageView];
        }
        if (itemNum < _menuItems.count - 1) {
            UIImageView *gradientView = [[UIImageView alloc] initWithImage:gradientLine];
            gradientView.frame = (CGRect){kMarginX * 2, maxItemHeight + 1, gradientLine.size};
            gradientView.contentMode = UIViewContentModeLeft;
            [itemView addSubview:gradientView];
            itemY += 2;
        }
        itemY += maxItemHeight;
        ++itemNum;
    }
    contentView.frame = (CGRect){0, 0, maxItemWidth, itemY + kMarginY * 2};
    return contentView;
}

- (CGPoint) arrowPoint
{
    CGPoint point;
    if (_arrowDirection == TPLPopMenuViewArrowDirectionUp) {
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMinY(self.frame) };
    } else if (_arrowDirection == TPLPopMenuViewArrowDirectionDown) {
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMaxY(self.frame) };
    } else if (_arrowDirection == TPLPopMenuViewArrowDirectionLeft) {
        point = (CGPoint){ CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
    } else if (_arrowDirection == TPLPopMenuViewArrowDirectionRight) {
        point = (CGPoint){ CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
    } else {
        point = self.center;
    }
    return point;
}

+ (UIImage *) selectedImage: (CGSize) size
{
    const CGFloat locations[] = {0,1};
    const CGFloat components[] = {
        0.216, 0.471, 0.871, 1,
        0.059, 0.353, 0.839, 1,
    };
    return [self gradientImageWithSize:size locations:locations components:components count:2];
}

+ (UIImage *) gradientLine: (CGSize) size
{
    const CGFloat locations[5] = {0,0.2,0.5,0.8,1};
    const CGFloat R = 0.44f, G = 0.44f, B = 0.44f;
    const CGFloat components[20] = {
        R,G,B,0.1,
        R,G,B,0.4,
        R,G,B,0.7,
        R,G,B,0.4,
        R,G,B,0.1
    };
    return [self gradientImageWithSize:size locations:locations components:components count:5];
}

+ (UIImage *) gradientImageWithSize:(CGSize) size
                          locations:(const CGFloat []) locations
                         components:(const CGFloat []) components
                              count:(NSUInteger)count
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef colorGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawLinearGradient(context, colorGradient, (CGPoint){0, 0}, (CGPoint){size.width, 0}, 0);
    CGGradientRelease(colorGradient);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) drawRect:(CGRect)rect
{
    [self drawBackground:self.bounds inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context
{
    CGFloat R0 = 0.129, G0 = 0.149, B0 = 0.212;//R0 = 0.267, G0 = 0.303, B0 = 0.335;
    CGFloat R1 = 0.129, G1 = 0.149, B1 = 0.212;//R1 = 0.040, G1 = 0.040, B1 = 0.040;
    
    UIColor *tintColor = [TPPopView tintColor];
    if (tintColor) {
        CGFloat a;
        [tintColor getRed:&R0 green:&G0 blue:&B0 alpha:&a];
    }
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    // render arrow
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    // fix the issue with gap of arrow's base if on the edge
    const CGFloat kEmbedFix = 3.f;
    if (_arrowDirection == TPLPopMenuViewArrowDirectionUp) {
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - PopArrowSize;
        const CGFloat arrowX1 = arrowXM + PopArrowSize;
        const CGFloat arrowY0 = Y0;
        const CGFloat arrowY1 = Y0 + PopArrowSize + kEmbedFix;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY0}];
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        Y0 += PopArrowSize;
    } else if (_arrowDirection == TPLPopMenuViewArrowDirectionDown) {
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - PopArrowSize;
        const CGFloat arrowX1 = arrowXM + PopArrowSize;
        const CGFloat arrowY0 = Y1 - PopArrowSize - kEmbedFix;
        const CGFloat arrowY1 = Y1;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY1}];
        
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:1] set];
        Y1 -= PopArrowSize;
    } else if (_arrowDirection == TPLPopMenuViewArrowDirectionLeft) {
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X0;
        const CGFloat arrowX1 = X0 + PopArrowSize + kEmbedFix;
        const CGFloat arrowY0 = arrowYM - PopArrowSize;;
        const CGFloat arrowY1 = arrowYM + PopArrowSize;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        X0 += PopArrowSize;
    } else if (_arrowDirection == TPLPopMenuViewArrowDirectionRight) {
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X1;
        const CGFloat arrowX1 = X1 - PopArrowSize - kEmbedFix;
        const CGFloat arrowY0 = arrowYM - PopArrowSize;;
        const CGFloat arrowY1 = arrowYM + PopArrowSize;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:1] set];
        X1 -= PopArrowSize;
    }
    [arrowPath fill];
    // render body
    const CGRect bodyFrame = {X0, Y0, X1 - X0, Y1 - Y0};
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame
                                                          cornerRadius:8];
    const CGFloat locations[] = {0, 1};
    const CGFloat components[] = {
        R0, G0, B0, 1,
        R1, G1, B1, 1,
    };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 components,
                                                                 locations,
                                                                 sizeof(locations)/sizeof(locations[0]));
    CGColorSpaceRelease(colorSpace);
    [borderPath addClip];
    CGPoint start, end;
    if (_arrowDirection == TPLPopMenuViewArrowDirectionLeft ||
        _arrowDirection == TPLPopMenuViewArrowDirectionRight) {
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X1, Y0};
    } else {
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X0, Y1};
    }
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    CGGradientRelease(gradient);
}

@end


static TPPopView *gMenu;
static UIColor *gTintColor;
static UIFont *gTitleFont;

@implementation TPPopView {
    TPLPopMenuView *_menuView;
    BOOL        _observing;
}

+ (instancetype) sharedMenu
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gMenu = [[TPPopView alloc] init];
    });
    return gMenu;
}

- (id) init
{
    NSAssert(!gMenu, @"singleton object");
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) dealloc
{
    if (_observing) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void) showMenuInView:(UIView *)view fromRect:(CGRect)rect direction: (TPLPopMenuViewArrowDirection )direction menuItems:(NSArray *)menuItems
{
    NSParameterAssert(view);
    NSParameterAssert(menuItems.count);
    if (_menuView) {
        [_menuView dismissMenu:NO];
        _menuView = nil;
    }
    if (!_observing) {
        _observing = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationWillChange:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    _menuView = [[TPLPopMenuView alloc] init];
    [_menuView showMenuInView:view fromRect:rect direction: direction menuItems:menuItems];
}

- (void) dismissMenu
{
    if (_menuView) {
        [_menuView dismissMenu:NO];
        _menuView = nil;
    }
    if (_observing) {
        _observing = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void) orientationWillChange: (NSNotification *) n
{
    [self dismissMenu];
}

+ (void) showMenuInView:(UIView *)view
               fromRect:(CGRect)rect
              direction:(TPLPopMenuViewArrowDirection)direction
              menuItems:(NSArray *)menuItems{
   [[self sharedMenu] showMenuInView:view fromRect:rect direction: direction menuItems:menuItems ];
}

+ (void) dismissMenu
{
    [[self sharedMenu] dismissMenu];
}

+ (UIColor *) tintColor
{
    return gTintColor;
}

+ (void) setTintColor: (UIColor *) tintColor
{
    if (tintColor != gTintColor) {
        gTintColor = tintColor;
    }
}

+ (UIFont *) titleFont
{
    return gTitleFont;
}

+ (void) setTitleFont: (UIFont *) titleFont
{
    if (titleFont != gTitleFont) {
        gTitleFont = titleFont;
    }
}
@end