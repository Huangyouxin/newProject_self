//
//  TPLSearchViewController.h
//  CNTaiPingAgent
//
//  Created by Eric on 13-12-13.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "TPHttpTableViewController.h"

#define rowHeight           35

@interface TPSearchViewController : TPHttpTableViewController

@property (nonatomic,strong) UIButton *buttonConfirm;
@property (nonatomic,strong) UIButton *buttonClear;

- (NSMutableString *)nsstringFromcellSelectArray:(NSArray *)arrayValue;
- (NSArray *) getArrayFromBOString: (NSString *)string ;

@end
