//
//  UITableViewCell+CellHeight.h
//  framework
//
//  Created by 崔玉国 on 14-2-28.
//
//

#import <UIKit/UIKit.h>




typedef CGFloat (^UITableViewCellHeightBlock)(UITableViewCell *cell);
@interface UITableViewCell (CellHeight)

@property(nonatomic, readonly)CGFloat cellHeight;
@property(nonatomic, copy)UITableViewCellHeightBlock cellHeightBlock;
@end
