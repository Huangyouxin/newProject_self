//
//  TPLSliderSegmControl.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-7.
//  Copyright (c) 2014年 Tai ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPLSliderSegmControl;
@protocol TPLSliderSegmControlDelegate <NSObject>
@optional
- (void) TPLSliderSegmControl:(TPLSliderSegmControl*)segmControl index:(int)index;
@end

typedef void (^TPLSliderSegmControlIndexChangeListener)(int index);

typedef NS_ENUM(NSInteger, TPLSliderSegmControlAlignment) {
    TPLSliderSegmControlAlignmentHorizental_Top,    //横向排布,选项按钮在上方出现
    TPLSliderSegmControlAlignmentHorizental_Bottom, //横向排布,选项按钮在下方出现
    TPLSliderSegmControlAlignmentVertical_Left,     //纵向排布,选项按钮在左方出现
    TPLSliderSegmControlAlignmentVertical_Right     //纵向排布,选项按钮在右方出现
};

@interface TPLSliderSegmControlItem : NSObject
@property(nonatomic, strong)NSString *title;
@property(nonatomic, assign)NSUInteger badgeNum;
@property(nonatomic, strong)UIColor  *titleColor;
@property(nonatomic, strong)UIColor  *badgeColor;
@property(nonatomic, assign)NSTextAlignment  titleAlignment;
@property(nonatomic, strong)UIFont  *titleFont;
@property(nonatomic, strong)UIFont  *badgeFont;
@property(nonatomic, strong)UIImage *thumbImage;
@property(nonatomic, strong)UIImage *thumbSelectedImage;
@property(nonatomic, strong)UIImage *segmItemBKImage;
@property(nonatomic, strong)UIImage *segmItemSelectedBKImage;
@end

@interface TPLSliderSegmControl : UIView {
    void(^sliderHasBeenClicked)(BOOL isBeginSelect);
}

@property(nonatomic, strong)UIColor *lineColor;
@property(nonatomic, assign)CGFloat lineWidth;
//拖动灵敏度控制，默认为2,值域在1～5
@property(nonatomic, assign)NSUInteger moveSensitivity;
//每一项的厚度，默认为40，值域在20～80
@property(nonatomic, assign)CGFloat segmItemWidth;

@property(nonatomic, assign)NSUInteger selectedIndex;
@property(nonatomic, assign)TPLSliderSegmControlAlignment alignment;


//TPLSliderSegmControlItem的数组
@property(nonatomic, strong)NSArray *items;

//如需要更新badge信息，可调用此函数
- (void) updateBadge:(NSUInteger)index badge:(NSString*)badge;

//@{这两个是二选其一的，优先满足TPLSliderSegmControlIndexChangeListener的，其中
// index 是从0开始的
@property(nonatomic, weak)id<TPLSliderSegmControlDelegate> delegate;
- (void) setOnIndexChangeListener:(TPLSliderSegmControlIndexChangeListener)listener;
- (void)sliderHasBeenClicked:(void(^)(BOOL))block;
//@}
@end
