//
//  CYGListView.h
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-11-18.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface CYGListViewCell : UIImageView
@property (nonatomic, strong, readonly) NSString *reuseIdentifier;
@property (nonatomic, strong) UIView *selectedBackgroundView;
//此cell是否支持点击事件，默认是NO，表示单个cell不支持选择，要选择选择listview的一行
@property (nonatomic, assign) BOOL responseClickEvent;

- (id)initWithReuseIdentifier:(NSString *)identifier;
@end

//派生出来的一种label形式的cell
@interface CYGListViewLabelCell : CYGListViewCell
@property(nonatomic, strong, readonly)UILabel* textLabel;
@end

@interface CYGListIndexPath : NSObject
@property (nonatomic, readonly) int row;
@property (nonatomic, readonly) int col;

+ (CYGListIndexPath *)indexPathForCol:(int)col inRow:(int)row;

- (id)initForCol:(int)pathCol inRow:(int)pathRow;
@end


typedef NS_ENUM(NSInteger, CYGListViewSelectedStyle) {
    CYGListViewSelectedStyle_Row,  //整行选择
    CYGListViewSelectedStyle_Cell  //单个区选择
};

@protocol CYGListViewDataSource;
@protocol CYGListViewDelegate;
@interface CYGListView : UIImageView
@property(nonatomic, strong)UIImage *headerViewBack;
@property(nonatomic, strong)UIColor *rowSeparatorColor;
@property(nonatomic, strong)UIColor *colSeparatorColor;
@property(nonatomic,readonly)UIScrollView   *contentView;
@property(nonatomic, assign)CYGListViewSelectedStyle   selectedStyle;


@property(nonatomic, weak)id<CYGListViewDataSource> dataSource;
@property(nonatomic, weak)id<CYGListViewDelegate>   delegate;

- (CYGListViewCell*)dequeueReusableViewWithIdentifier:(NSString*)identifier;
- (void)reloadData;
@end

@protocol CYGListViewDataSource<NSObject>
@required
- (NSUInteger)numberOfRowsInListView:(CYGListView *)listView;
- (NSUInteger)numberOfColsInListView:(CYGListView *)listView;
- (CGFloat)listView:(CYGListView *)listView widthForCol:(NSInteger)col;
- (CGFloat)listView:(CYGListView *)listView heightForRow:(NSInteger)row;
- (CYGListViewCell *)listView:(CYGListView *)listView cellAtIndexPath:(CYGListIndexPath *)indexPath;
@optional
//@{合并列
- (BOOL)listView:(CYGListView *)listView cellAtHeaderUnionLastCol:(NSInteger)col;
- (BOOL)listView:(CYGListView *)listView cellAtIndexPathUnionLastCol:(CYGListIndexPath *)indexPath;
//@}
- (CGFloat)heightOfHeaderInListView:(CYGListView *)listView;
- (CYGListViewCell *)listView:(CYGListView *)listView headerForCol:(NSUInteger)col;
@end

@protocol CYGListViewDelegate<NSObject, UIScrollViewDelegate>
@optional
- (void)listView:(CYGListView *)listView headerDidClickAtCol:(NSUInteger)col;
- (void)listView:(CYGListView *)listView cellDidClickIndexPath:(CYGListIndexPath *)indexPath;
@end




