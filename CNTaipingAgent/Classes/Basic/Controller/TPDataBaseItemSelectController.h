//
//  TPDataBaseItemSelectController.h
//  TPPensionSell
//
//  Created by 崔玉国 on 14-5-19.
//  Copyright (c) 2014年 cntaiping. All rights reserved.
//

#import "TPHttpTableViewController.h"

@interface TPDataBaseItemSelectController : TPHttpTableViewController
@property(nonatomic,strong)NSArray* items;
@property(nonatomic,strong)NSString* showField;
@property(nonatomic,assign)CGFloat viewHeight;
@property(nonatomic,assign)int lastRemarked;
@end
