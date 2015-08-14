//
//  SegmentedControl.m
//  SMHotel
//
//  Created by Stone on 14-6-15.
//  Copyright (c) 2014年 shimaogroup. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SegmentedControl.h"

#define SVSegmentedControlBG [[UIImage imageNamed:@"SVSegmentedControl.bundle/inner-shadow"] stretchableImageWithLeftCapWidth:4 topCapHeight:5]


@interface SegmentedThumb ()

@property (nonatomic, assign) SegmentedControl *segmentedControl;
@property (nonatomic, assign) UIFont *font;

@property (nonatomic, readonly) UILabel *label;
@property (nonatomic, readonly) UILabel *secondLabel;

- (void)activate;
- (void)deactivate;

@end



@interface SegmentedControl()
{
    UIImageView *backgroundView;
}
- (void)activate;
- (void)snap:(BOOL)animated;
- (void)toggle;

@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *thumbRects;

@property (nonatomic, readwrite) NSUInteger snapToIndex;
@property (nonatomic, readwrite) BOOL trackingThumb;
@property (nonatomic, readwrite) BOOL moved;
@property (nonatomic, readwrite) BOOL activated;

@property (nonatomic, readwrite) CGFloat halfSize;
@property (nonatomic, readwrite) CGFloat dragOffset;
@property (nonatomic, readwrite) CGFloat segmentWidth;
@property (nonatomic, readwrite) CGFloat thumbHeight;

@end


@implementation SegmentedControl

@synthesize selectedSegmentChangedHandler, changeHandler, selectedIndex, animateToInitialSelection;
@synthesize cornerRadius, tintColor, backgroundImage, font, textColor, textShadowColor, textShadowOffset, segmentPadding, titleEdgeInsets, crossFadeLabelsOnDrag;
@synthesize titlesArray, imagesArray, thumb, thumbRects, snapToIndex, trackingThumb, moved, activated, halfSize, dragOffset, segmentWidth, thumbHeight;

// deprecated
@synthesize delegate, thumbEdgeInset, shadowColor, shadowOffset;

#pragma mark -
#pragma mark Life Cycle

- (id)initWithSectionTitles:(NSArray*)array images:(NSArray *)images{
    
	if (self = [super initWithFrame:CGRectZero]) {

        self.titlesArray = [NSMutableArray arrayWithArray:array];
        self.imagesArray = [NSMutableArray arrayWithArray:images];
        self.thumbRects = [NSMutableArray arrayWithCapacity:[array count]];
        
        self.backgroundColor = [UIColor clearColor];
        self.tintColor = [UIColor grayColor];
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.animateToInitialSelection = NO;
        self.clipsToBounds = NO;
        
        self.font = [UIFont boldSystemFontOfSize:15];
        self.textColor = [UIColor grayColor];
        self.textShadowColor = [UIColor blackColor];
        self.textShadowOffset = CGSizeMake(0, 0);
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        self.thumbEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.selectedIndex = 0;
        self.thumb.segmentedControl = self;
    }
    
	return self;
}

- (SegmentedThumb *)thumb {
    
    if(thumb == nil)
        thumb = [[SegmentedThumb alloc] initWithFrame:CGRectZero];
    
    return thumb;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.thumbHeight = self.height;
    int count = self.titlesArray.count;
    NSMutableArray *rects = [NSMutableArray array];
	for(int i = 0; i < count; ++i) {
        CGRect rc = [self.thumbRects[i] CGRectValue];
        [rects addObject:[NSValue valueWithCGRect:CGRectMake(rc.origin.x, rc.origin.y, rc.size.width, self.thumbHeight)]];
	}
    self.thumbRects = rects;
    self.thumb.frame = [self.thumbRects[self.selectedIndex] CGRectValue];
    backgroundView.frame = self.bounds;
    backgroundView.image = self.backgroundImage;
    [self setNeedsDisplay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	
	if(newSuperview == nil)
		return;
    
	int c = [self.titlesArray count];
	
	self.segmentWidth = 0;

    for (NSString *name in self.imagesArray) {
        UIImage *image = Image(name);
        CGFloat Width = image.size.width;
        self.segmentWidth = MAX(Width, self.segmentWidth);
    }
	
	self.segmentWidth = ceil(self.segmentWidth/2.0)*2; // make it an even number so we can position with center
	self.bounds = CGRectMake(0, 0, self.segmentWidth*c, self.height);
    self.thumbHeight = self.height;
    
    int count = self.titlesArray.count;
	for(int i = 0; i < count; ++i) {
        [self.thumbRects addObject:[NSValue valueWithCGRect:CGRectMake(self.segmentWidth*i+self.thumbEdgeInset.left, self.thumbEdgeInset.top, self.segmentWidth, self.thumbHeight)]];
	}
	
    if (self.thumbRects.count <= self.selectedIndex) {
        return;
    }
	self.thumb.frame = [self.thumbRects[self.selectedIndex] CGRectValue];
    self.thumb.backgroundImage = Image(self.imagesArray[self.selectedIndex]);
    self.thumb.highlightedBackgroundImage = self.thumb.backgroundImage;
	self.thumb.font = self.font;
	
	[self insertSubview:self.thumb atIndex:0];
    
    BOOL animateInitial = self.animateToInitialSelection;
    
    if(self.selectedIndex == 0)
        animateInitial = NO;
	
    [self moveThumbToIndex:selectedIndex animate:animateInitial];
}

#pragma mark - Drawing code


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.thumbRects.count <= 0) {
        return;
    }
 
    [self.backgroundImage drawInRect:rect];
    
    CGRect rc = [self.thumbRects[self.thumbRects.count-1] CGRectValue];
    rect = CGRectMake(rect.origin.x, rect.origin.y, CGRectGetMaxX(rc)+self.thumbEdgeInset.right, rect.size.height);
    
	CGContextSetShadowWithColor(context, self.textShadowOffset, 0, self.textShadowColor.CGColor);
	[self.textColor set];
	
	CGFloat posY = ceil((CGRectGetHeight(rect)-self.font.pointSize+self.font.descender)/2)+self.titleEdgeInsets.top-self.titleEdgeInsets.bottom;
	int pointSize = self.font.pointSize;
	
	if(pointSize%2 != 0)
		posY--;
    
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString *titleString, NSUInteger i, BOOL *stop) {
        CGRect labelRect = CGRectMake((self.segmentWidth*i), posY, self.segmentWidth, self.font.pointSize+2);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *textAttributes = @{NSFontAttributeName: self.font,
                                         NSForegroundColorAttributeName:self.textColor,
                                         NSParagraphStyleAttributeName: paragraphStyle};
        [titleString drawInRect:labelRect withAttributes:textAttributes];
    }];
}

#pragma mark -
#pragma mark Tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    
    CGPoint cPos = [touch locationInView:self.thumb];
	self.activated = NO;
	
	self.snapToIndex = floor(self.thumb.center.x/self.segmentWidth);
	
	if(CGRectContainsPoint(self.thumb.bounds, cPos)) {
		self.trackingThumb = YES;
        [self.thumb deactivate];
		self.dragOffset = (self.thumb.frame.size.width/2)-cPos.x;
	}
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGRect rect = self.bounds;
    CGRect rc = [self.thumbRects[self.thumbRects.count-1] CGRectValue];
    rect = CGRectMake(rect.origin.x, rect.origin.y, CGRectGetMaxX(rc)+self.thumbEdgeInset.right,
                      CGRectGetMaxY(rc)+self.thumbEdgeInset.bottom);
    
    CGPoint cPos = [touch locationInView:self];
	CGFloat newPos = cPos.x+self.dragOffset;
	CGFloat newMaxX = newPos+(CGRectGetWidth(self.thumb.frame)/2);
	CGFloat newMinX = newPos-(CGRectGetWidth(self.thumb.frame)/2);
	
	CGFloat buffer = 2.0; // to prevent the thumb from moving slightly too far
	CGFloat pMaxX = CGRectGetMaxX(rect) - buffer;
	CGFloat pMinX = CGRectGetMinX(rect) + buffer;
	
	if((newMaxX > pMaxX || newMinX < pMinX) && self.trackingThumb) {
		self.snapToIndex = floor(self.thumb.center.x/self.segmentWidth);
        
        if(newMaxX-pMaxX > 10 || pMinX-newMinX > 10)
            self.moved = YES;
        
		[self snap:NO];
	}
	
	else if(self.trackingThumb) {
		self.thumb.center = CGPointMake(cPos.x+self.dragOffset, self.thumb.center.y);
		self.moved = YES;
	}
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    CGRect rect = self.bounds;
    CGRect rc = [self.thumbRects[self.thumbRects.count-1] CGRectValue];
    rect = CGRectMake(rect.origin.x, rect.origin.y, CGRectGetMaxX(rc)+self.thumbEdgeInset.right,
                      CGRectGetMaxY(rc)+self.thumbEdgeInset.bottom);
    
    CGPoint cPos = [touch locationInView:self];
    CGFloat buffer = 2.0;
	CGFloat pMaxX = CGRectGetMaxX(rect)-buffer;
	CGFloat pMinX = CGRectGetMinX(rect)+buffer;
	
	if(!self.moved && self.trackingThumb && [self.titlesArray count] == 2)
		[self toggle];
	
	else if(!self.activated && cPos.x > pMinX && cPos.x < pMaxX) {
		self.snapToIndex = floor(cPos.x/self.segmentWidth);
		[self snap:YES];
	}
	
	else {
        CGFloat posX = cPos.x;
        
        if(posX < pMinX)
            posX = pMinX;
        
        if(posX >= pMaxX)
            posX = pMaxX-1;
        
        self.snapToIndex = floor(posX/self.segmentWidth);
        [self snap:YES];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    
    if(self.trackingThumb)
		[self snap:NO];
}

#pragma mark -

- (void)snap:(BOOL)animated {
	[self.thumb deactivate];
    
    if (self.thumbRects.count <= 0) {
        return;
    }
    if(self.crossFadeLabelsOnDrag)
        self.thumb.secondLabel.alpha = 0;
    
	int index;
	
	if(self.snapToIndex != -1)
		index = self.snapToIndex;
	else
		index = floor(self.thumb.center.x/self.segmentWidth);
	
    index = index<0 ? 0 : index >= self.thumbRects.count ? self.thumbRects.count-1 : index;
    
    self.thumb.backgroundImage = Image([self.imagesArray objectAtIndex:index]);
    self.thumb.highlightedBackgroundImage = self.thumb.backgroundImage;
    
    if(self.changeHandler && self.snapToIndex != self.selectedIndex && !self.isTracking)
		self.changeHandler(self.snapToIndex);
    
	if(animated)
		[self moveThumbToIndex:index animate:YES];
	else
		self.thumb.frame = [self.thumbRects[index] CGRectValue];
}

- (void)activate {
	
	self.trackingThumb = self.moved = NO;
    
    void (^oldChangeHandler)(id sender) = [self valueForKey:@"selectedSegmentChangedHandler"];
    
	if(oldChangeHandler)
		oldChangeHandler(self);
    
    if([self valueForKey:@"delegate"]) {
        id controlDelegate = [self valueForKey:@"delegate"];
        
        if([controlDelegate respondsToSelector:@selector(segmentedControl:didSelectIndex:)])
            [controlDelegate segmentControl:self didSelectIndex:selectedIndex];
    }
    
	[UIView animateWithDuration:0.1
						  delay:0
						options:UIViewAnimationOptionAllowUserInteraction
					 animations:^{
						 self.activated = YES;
						 [self.thumb activate];
					 }
					 completion:NULL];
}


- (void)toggle {
	
	if(self.snapToIndex == 0)
		self.snapToIndex = 1;
	else
		self.snapToIndex = 0;
	
	[self snap:YES];
}

- (void)moveThumbToIndex:(NSUInteger)segmentIndex animate:(BOOL)animate {
    
    self.selectedIndex = segmentIndex;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
	if(animate) {
        
        [self.thumb deactivate];
		
		[UIView animateWithDuration:0.2
							  delay:0
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^{
							 self.thumb.frame = [[self.thumbRects objectAtIndex:segmentIndex] CGRectValue];
						 }
						 completion:^(BOOL finished){
                             if (finished) {
                                 [self activate];
                             }
						 }];
	}
	
	else {
		self.thumb.frame = [[self.thumbRects objectAtIndex:segmentIndex] CGRectValue];
		[self activate];
	}
}

#pragma mark -

- (void)setBackgroundImage:(UIImage *)newImage {
    
    if(backgroundImage)
        backgroundImage = nil;
    
    if(newImage) {
        backgroundImage = newImage;
    }
}

#pragma mark - Support for deprecated methods

- (void)setSegmentPadding:(CGFloat)newPadding {
    self.titleEdgeInsets = UIEdgeInsetsMake(0, newPadding, 0, newPadding);
}

- (void)setShadowOffset:(CGSize)newOffset {
    self.textShadowOffset = newOffset;
}

- (void)setShadowColor:(UIColor *)newColor {
    self.textShadowColor = newColor;
}

- (void) updateSegmentTitles:(NSArray *)array {
    if (self.selectedIndex > [array count])
        return ;
    
    self.titlesArray = [NSMutableArray arrayWithArray:array];
    [self setNeedsDisplay];
}

@end
