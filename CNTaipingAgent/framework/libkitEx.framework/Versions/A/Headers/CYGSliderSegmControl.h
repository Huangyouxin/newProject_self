//
//  CYGSliderSegmControl.h
//  CNTaiPingAgent
//
//  Created by 崔玉国 on 13-12-3.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CYGSliderSegmControl;
@protocol CYGSliderSegmControlDelegate <NSObject>
@optional
- (void) CYGSliderSegmControl:(CYGSliderSegmControl*)segmControl index:(int)index;
@end

typedef void (^CYGSliderSegmControlIndexChangeListener)(int index);

typedef NS_ENUM(NSInteger, CYGSliderSegmControlAlignment) {
    CYGSliderSegmControlAlignmentHorizental_Top,    //横向排布,选项按钮在上方出现
    CYGSliderSegmControlAlignmentHorizental_Bottom, //横向排布,选项按钮在下方出现
    CYGSliderSegmControlAlignmentVertical_Left,     //纵向排布,选项按钮在左方出现
    CYGSliderSegmControlAlignmentVertical_Right     //纵向排布,选项按钮在右方出现
};

@interface CYGSliderSegmControlItem : NSObject
@property(nonatomic, strong)NSString *title;
@property(nonatomic, assign)NSUInteger badgeNum;
@property(nonatomic, strong)UIColor  *titleColor;
@property(nonatomic, strong)UIColor  *badgeColor;
@property(nonatomic, assign)NSTextAlignment  titleAlignment;
@property(nonatomic, strong)UIFont  *titleFont;
@property(nonatomic, strong)UIFont  *badgeFont;
@end

@interface CYGSliderSegmControl : UIView
@property(nonatomic, strong)UIColor *lineColor;
@property(nonatomic, assign)CGFloat lineWidth;
@property(nonatomic, strong)UIImage *thumbImage;
@property(nonatomic, strong)UIImage *thumbSelectedImage;
@property(nonatomic, strong)UIImage *segmItemBKImage;
@property(nonatomic, strong)UIImage *segmItemSelectedBKImage;
//拖动灵敏度控制，默认为2,值域在1～5
@property(nonatomic, assign)NSUInteger moveSensitivity;
//每一项的厚度，默认为40，值域在20～80
@property(nonatomic, assign)CGFloat segmItemWidth;

@property(nonatomic, assign)NSUInteger selectedIndex;
@property(nonatomic, assign)CYGSliderSegmControlAlignment alignment;


//CYGSliderSegmControlItem的数组
@property(nonatomic, strong)NSArray *items;

//如需要更新badge信息，可调用此函数
- (void) updateBadge:(NSUInteger)index badge:(NSString*)badge;

//@{这两个是二选其一的，优先满足CYGSliderSegmControlIndexChangeListener的，其中
// index 是从0开始的
@property(nonatomic, weak)id<CYGSliderSegmControlDelegate> delegate;
- (void) setOnIndexChangeListener:(CYGSliderSegmControlIndexChangeListener)listener;
//@}
@end
