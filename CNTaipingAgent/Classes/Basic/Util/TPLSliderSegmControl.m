//
//  TPLSliderSegmControl.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-7.
//  Copyright (c) 2014年 Tai ping. All rights reserved.
//

#import "TPLSliderSegmControl.h"

@class TPLSliderSegmControlItem;

typedef void (^TPLSliderBlock)(int index);
@interface TPLSlider : UIView {
	CGPoint lastTouchPoint;
    TPLSliderBlock sliderBlock;
    dispatch_once_t onceDispatch;
}
@property(nonatomic, assign)NSUInteger valueCount;
@property(nonatomic, assign)int value;
@property(nonatomic, assign)CGFloat lineWidth;
@property(nonatomic, strong)UIColor *lineColor;
@property(nonatomic, strong)UIImageView *selector;
@property(nonatomic, assign)BOOL isTouching;
@property(nonatomic, assign)CGRect moveRect;
@property(nonatomic, assign)NSUInteger moveSensitivity;
@property(nonatomic, strong)NSMutableArray *superGestures;
@property(nonatomic, strong)NSArray *items;

- (void) addValueChangedBlock:(TPLSliderBlock)block;
- (CGRect)dotFrame:(NSUInteger)index;
@end
@implementation TPLSlider
@synthesize valueCount;
@synthesize lineWidth;
@synthesize lineColor;
@synthesize selector;
@synthesize value;
@synthesize isTouching;
@synthesize moveRect;
@synthesize moveSensitivity;
@synthesize items;

#define ITEMTag  -20000
- (id) init {
    if (self = [super init]) {
        self.lineWidth = 2.0f;
        self.lineColor = [UIColor blueColor];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        selector = [[UIImageView alloc] init];
        [self addSubview:selector];
        moveSensitivity = 2;
        
        self.superGestures = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
    [self.superGestures removeAllObjects];
}
- (void) setIsTouching:(BOOL)flag {
    isTouching = flag;
    [self.superGestures enumerateObjectsUsingBlock:^(UIGestureRecognizer *obj, NSUInteger idx, BOOL *stop) {
        obj.enabled = !flag;
    }];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0);
    
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, center.y-self.lineWidth/2.0);
    CGContextAddLineToPoint(context, rect.size.width, center.y-self.lineWidth/2.0);
    CGContextStrokePath(context);
    
    CGContextSaveGState(context);
}

- (void) setValueCount:(NSUInteger)count {
    valueCount = count;
    //    //删除所有子单元
    //    while (self.subviews.count) {
    //        UIView* child = self.subviews.lastObject;
    //        [child removeFromSuperview];
    //    }
    //    for (int i = 0; i < count; ++i) {
    //        UIImageView *item = [[UIImageView alloc] initWithImage:self.thumbImage];
    //        item.tag = ITEMTag+i;
    //        [self addSubview:item];
    //    }
    //    selector.image = self.thumbSelectedImage;
    //    [self addSubview:selector];
    //    [self setNeedsLayout];
}

- (void) setItems:(NSArray *)_items {
    items = _items;
    valueCount = _items.count;
    //删除所有子单元
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    for (int i = 0; i < valueCount; ++i) {
        TPLSliderSegmControlItem *itemcon = _items[i];
        
        UIImageView *item = [[UIImageView alloc] initWithImage:itemcon.thumbImage];
        
        item.image = itemcon.thumbImage;
        
        item.tag = ITEMTag+i;
        
        self.selector.image = itemcon.thumbSelectedImage;
        
        [self addSubview:item];
    }
    [self addSubview:selector];
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    dispatch_once(&onceDispatch, ^{
        UIView *view = self;
        while (view.superview) {
            [view.superview.gestureRecognizers enumerateObjectsUsingBlock:^(UIGestureRecognizer *obj, NSUInteger idx, BOOL *stop) {
                if (([obj isKindOfClass:[UIPanGestureRecognizer class]] ||
                     [obj isKindOfClass:[UISwipeGestureRecognizer class]]) &&
                    obj.enabled) {
                    [self.superGestures addObject:obj];
                }
            }];
            view = view.superview;
        }
    });
    
    if (valueCount == 0) {
        return;
    }
    
    CGSize thumbSize = [self imageSize];
    CGFloat posX, posY, stepX;
    CGPoint center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    posX = -thumbSize.width/2.0;
    posY = center.y-(thumbSize.height-self.lineWidth)/2.0-1;
    stepX = CGRectGetWidth(self.bounds)/(valueCount-1);
    
    for (int i = 0; i < valueCount; ++i) {
        UIView *item = [self viewWithTag:ITEMTag+i];
        item.frame = CGRectMake(posX, posY, thumbSize.width, thumbSize.height);
        posX+=stepX;
    }
    thumbSize = [self imageThuSize];
    stepX = CGRectGetWidth(self.bounds)/(valueCount-1);
    self.selector.frame = CGRectMake(stepX*self.value-thumbSize.width/2.0,
                                     center.y-(thumbSize.height-self.lineWidth)/2.0-1, thumbSize.width, thumbSize.height);
}

- (UIImage*)thumbSelectedImage{return self.selector.image;}
- (void) setThumbSelectedImage:(UIImage *)thumbSelectedImage {
    self.selector.image = thumbSelectedImage;
    [self setNeedsLayout];
}

- (CGRect)dotFrame:(NSUInteger)index {
    if (index >= valueCount) {
        return CGRectZero;
    }
    CGSize thumbSize = [self imageSize];
    CGFloat posX, posY, stepX;
    CGPoint center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    posX = -thumbSize.width/2.0;
    posY = center.y-(thumbSize.height-self.lineWidth)/2.0-1;
    stepX = CGRectGetWidth(self.bounds)/(valueCount-1);
    posX += index * stepX;
    CGRect frame = CGRectMake(posX, posY, thumbSize.width, thumbSize.height);
    return [self convertRect:frame toView:self.superview];
}

- (CGSize)imageSize {
    TPLSliderSegmControlItem *itemcon = items[0];
    return itemcon.thumbImage.size;
}
- (CGSize)imageThuSize {
    TPLSliderSegmControlItem *itemcon = items[0];
    return itemcon.thumbSelectedImage.size;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    self.isTouching = YES;
	lastTouchPoint = touchPoint;
    self.moveRect = self.selector.frame;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    //
    //    CGRect selectorFrame = self.selector.frame;
    //    CGFloat moveDistance, step;
    //    moveDistance = (lastTouchPoint.x - touchPoint.x);
    //    step = CGRectGetWidth(self.bounds)/moveSensitivity/(valueCount-1);
    //    selectorFrame.origin.x -= moveDistance;
    //    if (CGRectGetMinX(selectorFrame) < -CGRectGetWidth(selectorFrame)) {
    //        selectorFrame.origin.x = -CGRectGetWidth(selectorFrame)/2.0;
    //    } else if (CGRectGetMaxX(selectorFrame) >= CGRectGetWidth(self.bounds)+CGRectGetWidth(selectorFrame)/2.0) {
    //        selectorFrame.origin.x = CGRectGetWidth(self.bounds)-CGRectGetWidth(selectorFrame)/2.0;
    //    }
    //    self.moveRect = selectorFrame;
    //    int addValue = (CGRectGetMidX(self.moveRect)-CGRectGetMidX(self.selector.frame))/step;
    //    if (abs(addValue) >= 1) {
    //        lastTouchPoint = touchPoint;
    //    }
    //    self.value += addValue;
}

//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    self.isTouching = NO;
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesEnded:touches withEvent:event];
//
//    self.isTouching = NO;
//}

- (void) setMoveSensitivity:(NSUInteger)sensitivity {
    if (sensitivity < 1) {
        sensitivity = 1;
    } else if (sensitivity > 5) {
        sensitivity = 5;
    }
    moveSensitivity = sensitivity;
}

- (void)setValue:(int)vl {
    value = vl;
    CGSize thumbSize = [self imageThuSize];
    CGPoint center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGFloat stepX = CGRectGetWidth(self.bounds)/(valueCount-1);
    self.selector.frame = CGRectMake(stepX*self.value-thumbSize.width/2.0,
                                     center.y-(thumbSize.height-self.lineWidth)/2.0-1, thumbSize.width, thumbSize.height);
}

- (void) addValueChangedBlock:(TPLSliderBlock)block {
    sliderBlock = [block copy];
}


@end


@implementation TPLSliderSegmControlItem
@synthesize title;
@synthesize badgeNum;
@synthesize titleColor;
@synthesize badgeColor;
@synthesize titleAlignment;
@synthesize titleFont, badgeFont;
@synthesize segmItemBKImage;
@synthesize segmItemSelectedBKImage;
@end

@interface TPLSliderSegmItemButton : UIImageView {
    void(^btnClick)();
}
- (void)btnClick:(void(^)())block;
@property(nonatomic, strong)UIImage *segmItemBKImage;
@property(nonatomic, strong)UIImage *segmItemSelectedBKImage;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *badgeLabel;
@property(nonatomic, assign)TPLSliderSegmControlAlignment alignment;
@property(nonatomic, assign)BOOL  isHighlighted;

@property(nonatomic, strong)UIImage *thumbImage;
@property(nonatomic, strong)UIImage *thumbSelectedImage;
@end
@implementation TPLSliderSegmItemButton
@synthesize segmItemBKImage;
@synthesize segmItemSelectedBKImage;
@synthesize titleLabel, badgeLabel;
@synthesize alignment;
@synthesize isHighlighted;
@synthesize thumbSelectedImage,thumbImage;

- (id)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLabel];
        
        badgeLabel = [[UILabel alloc] init];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.font = [UIFont systemFontOfSize:14];
        badgeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:badgeLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(clickBtn:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void) setIsHighlighted:(BOOL)flag {
    isHighlighted = flag;
    if (isHighlighted) {
        self.image = segmItemSelectedBKImage;
    } else {
        self.image = segmItemBKImage;
    }
}

- (void)clickBtn:(UITapGestureRecognizer*)gesture {
    if (btnClick) {
        btnClick();
    }
}

- (void)btnClick:(void (^)())block {
    btnClick = [block copy];
}

- (void) setAlignment:(TPLSliderSegmControlAlignment)alig {
    alignment = alig;
    if (TPLSliderSegmControlAlignmentHorizental_Top == alignment ||
        TPLSliderSegmControlAlignmentHorizental_Bottom == alignment) {
        titleLabel.numberOfLines = 100;
    } else {
        titleLabel.numberOfLines = 1;
    }
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (TPLSliderSegmControlAlignmentHorizental_Top == alignment) {
        badgeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)-5, 16);
        titleLabel.frame = CGRectMake((CGRectGetWidth(self.bounds)-20)/2.0, 10, 20, CGRectGetHeight(self.bounds)-20);
    } else if (TPLSliderSegmControlAlignmentHorizental_Bottom == alignment) {
        badgeLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-16, CGRectGetWidth(self.bounds)-5, 16);
        titleLabel.frame = CGRectMake((CGRectGetWidth(self.bounds)-20)/2.0, 10, 20, CGRectGetHeight(self.bounds)-20);
    } else if (TPLSliderSegmControlAlignmentVertical_Left == alignment) {
        badgeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)-15, 16);
        titleLabel.frame = CGRectMake(10, 0, CGRectGetWidth(self.bounds)-30, CGRectGetHeight(self.bounds));
    } else {
        badgeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)-5, 16);
        titleLabel.frame = CGRectMake(10, 0, CGRectGetWidth(self.bounds)-20, CGRectGetHeight(self.bounds));
    }
}
@end


@interface TPLSliderSegmControl () {
    TPLSliderSegmControlIndexChangeListener indexChangeListener;
    UITapGestureRecognizer *tapGesture;
}

@property(nonatomic, strong)TPLSlider *slider;
@property(nonatomic, strong)UIView *segmBack;
@property(nonatomic, assign)CGFloat maxWidth;
@property(nonatomic, assign)int oldSelectedIndex;
@end

@implementation TPLSliderSegmControl
@synthesize selectedIndex;
@synthesize alignment;
@synthesize slider;
@synthesize items;
@synthesize segmBack;
@synthesize maxWidth;
@synthesize oldSelectedIndex;
@synthesize delegate;
@synthesize segmItemWidth;


- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
        self.userInteractionEnabled = NO;
		[self setup];
	}
    
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setup];
	}
	
	return self;
}

- (void)set {
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TPLSliderSegmItemButton *item = (TPLSliderSegmItemButton*)[self.segmBack viewWithTag:100+idx];
        item.segmItemSelectedBKImage = item.segmItemSelectedBKImage;
        item.segmItemBKImage = item.segmItemBKImage;
        item.isHighlighted = idx == self.selectedIndex;
    }];
    
}

- (UIColor*)lineColor{return self.slider.lineColor;}
- (void)setLineColor:(UIColor *)lineColor {
    self.slider.lineColor = lineColor;
    [self.slider setNeedsDisplay];
}
- (CGFloat)lineWidth{return self.slider.lineWidth;}
- (void)setLineWidth:(CGFloat)lineWidth{
    self.slider.lineWidth = lineWidth;
    [self.slider setNeedsDisplay];
}

- (UIWindow*)window {
    NSArray* windows = [UIApplication sharedApplication].windows;
    if (windows.count <= 0) {
        return nil;
    }
    return windows[0];
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
	self.slider = [[TPLSlider alloc] init];
    self.slider.backgroundColor = [UIColor clearColor];
    [self addSubview:self.slider];
    
    segmItemWidth = 40;
    
    self.segmBack = [[UIView alloc] init];
    self.segmBack.backgroundColor = [UIColor clearColor];
    self.segmBack.hidden = YES;
    self.segmBack.userInteractionEnabled = YES;
    [self addSubview:self.segmBack];
    [self bringSubviewToFront:self.segmBack];
    
    //监听滑动条被按下事件
    [self.slider addObserver:self forKeyPath:@"isTouching"
                     options:NSKeyValueObservingOptionNew context:nil];
    //监听滑动条value变化
    [self.slider addObserver:self forKeyPath:@"value"
                     options:NSKeyValueObservingOptionNew context:nil];
}

- (void) setItems:(NSArray *)its {
    self.slider.valueCount = its.count;
    self.slider.items = its;
    [self set];
    items = its;
    //删除所有子单元
    while (self.segmBack.subviews.count) {
        UIView* child = self.segmBack.subviews.lastObject;
        [child removeFromSuperview];
    }
    [its enumerateObjectsUsingBlock:^(TPLSliderSegmControlItem *item, NSUInteger idx, BOOL *stop) {
        TPLSliderSegmItemButton *button = [[TPLSliderSegmItemButton alloc] init];
        button.segmItemBKImage = item.segmItemBKImage;
        button.segmItemSelectedBKImage = item.segmItemSelectedBKImage;
        button.thumbImage = item.thumbImage;
        button.thumbSelectedImage = item.thumbSelectedImage;
        button.isHighlighted = self.selectedIndex == idx;
        button.alignment = self.alignment;
        [button btnClick:^{
            button.isHighlighted = YES;
            self.selectedIndex = button.tag - 100;
            self.slider.isTouching = NO;
        }];
        if (nil != item.titleColor) {
            button.titleLabel.textColor = item.titleColor;
        }
        button.titleLabel.textAlignment = item.titleAlignment;
        button.titleLabel.text = item.title;
        if (nil != item.titleFont) {
            button.titleLabel.font = item.titleFont;
        }
        if (nil != item.badgeColor) {
            button.badgeLabel.textColor = item.badgeColor;
        }
        if (item.badgeNum > 0) {
            button.badgeLabel.text = [NSString stringWithFormat:@"%d",item.badgeNum];
        } else {
            button.badgeLabel.text = nil;
        }
        if (nil != item.badgeFont) {
            button.badgeLabel.font = item.badgeFont;
        }
        button.tag = 100+idx;
        [self.segmBack addSubview:button];

        NSDictionary *dic = @{NSFontAttributeName: button.titleLabel.font};
        CGSize size = [button.titleLabel.text boundingRectWithSize:button.bounds.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        
        if (self.maxWidth < size.width) {
            self.maxWidth = size.width;
        }
    }];
    self.maxWidth += 40;
    [self setNeedsLayout];
}

- (void) setSelectedIndex:(NSUInteger)index {
    selectedIndex = index;
    self.slider.value = index;
}

- (void) setAlignment:(TPLSliderSegmControlAlignment)Alignment {
    alignment = Alignment;
    if (TPLSliderSegmControlAlignmentHorizental_Top == alignment ||
        TPLSliderSegmControlAlignmentHorizental_Bottom == alignment) {
        self.slider.transform = CGAffineTransformMakeRotation(0.0);
    } else {
        self.slider.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    }
    
    self.items = self.items;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
//    self.slider.frame = CGRectMake(self.width/2-15, 20, 30, self.height - 40);
    self.slider.frame = CGRectMake(0, 20, 30, self.height-40);
    
    if (TPLSliderSegmControlAlignmentVertical_Left == alignment) {
        self.segmBack.frame = CGRectMake(self.slider.center.x-self.maxWidth, 0, self.maxWidth, height);
    } else if (TPLSliderSegmControlAlignmentVertical_Right == alignment) {
        self.segmBack.frame = CGRectMake(30, 0, self.maxWidth, height);
    } else if (TPLSliderSegmControlAlignmentHorizental_Bottom == alignment) {
        self.segmBack.frame = CGRectMake(0, self.slider.center.y, width, self.maxWidth);
    } else {
        self.segmBack.frame = CGRectMake(0, self.slider.center.y-self.maxWidth, width, self.maxWidth);
    }
    int count = self.items.count;
    for (int i = 0; i < count; ++i) {
        UIView *item = [self.segmBack viewWithTag:100+i];
        CGRect dotFrame = [self.slider dotFrame:i];
        dotFrame = [self convertRect:dotFrame toView:self.segmBack];
        
        if (TPLSliderSegmControlAlignmentVertical_Left == alignment|
            TPLSliderSegmControlAlignmentVertical_Right== alignment) {
            CGFloat posX = TPLSliderSegmControlAlignmentVertical_Left == alignment ? -20 : 20;
            item.frame = CGRectMake(posX, CGRectGetMidY(dotFrame)-segmItemWidth/2,
                                    CGRectGetWidth(self.segmBack.frame), segmItemWidth);
        } else {
            CGFloat posY = TPLSliderSegmControlAlignmentHorizental_Top == alignment ? -20 : 20;
            item.frame = CGRectMake(CGRectGetMidX(dotFrame)-segmItemWidth/2, posY,
                                    segmItemWidth, CGRectGetHeight(self.segmBack.frame));
        }
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isTouching"]) {
        if (self.slider.isTouching) {
            self.oldSelectedIndex = self.selectedIndex;
            [UIView animateWithDuration:.2 animations:^{
                self.segmBack.hidden = NO;
            } completion:nil];
            if (sliderHasBeenClicked) {
                sliderHasBeenClicked(YES);
            }
        } else {
            [UIView animateWithDuration:.2 animations:^{
                self.segmBack.hidden = YES;
            } completion:^(BOOL finished) {
                if (sliderHasBeenClicked) {
                    sliderHasBeenClicked(NO);
                }
                if (self.oldSelectedIndex != self.selectedIndex) {
                    if (indexChangeListener) {
                        indexChangeListener(self.selectedIndex);
                    } else if ([delegate conformsToProtocol:@protocol(TPLSliderSegmControlDelegate)] &&
                               [delegate respondsToSelector:@selector(TPLSliderSegmControl:index:)]) {
                        [delegate TPLSliderSegmControl:self index:self.selectedIndex];
                    }
                }
            }];
        }
    } else if ([keyPath isEqualToString:@"value"]) {
        int index = self.slider.value;
        [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TPLSliderSegmItemButton *item = (TPLSliderSegmItemButton*)[self.segmBack viewWithTag:100+idx];
            item.isHighlighted = idx==index;
        }];
        selectedIndex = index;
    }
}

- (void) setOnIndexChangeListener:(TPLSliderSegmControlIndexChangeListener)listener {
    indexChangeListener = [listener copy];
}

- (NSUInteger)moveSensitivity{return self.slider.moveSensitivity;}
- (void)setMoveSensitivity:(NSUInteger)moveSensitivity {
    self.slider.moveSensitivity = moveSensitivity;
}

- (void) setSegmItemWidth:(CGFloat)width {
    if (width < 20) {
        width = 20;
    } else if (width > 80) {
        width = 80;
    }
    segmItemWidth = width;
    [self setNeedsLayout];
}

- (void) updateBadge:(NSUInteger)index badge:(NSString*)badge {
    TPLSliderSegmItemButton *button = (TPLSliderSegmItemButton*)[self.segmBack viewWithTag:100+index];
    if ([badge isKindOfClass:[NSString class]]) {
        button.badgeLabel.text = badge;
    }
}

- (void)sliderHasBeenClicked:(void (^)(BOOL))block {
    sliderHasBeenClicked = [block copy];
}

@end
