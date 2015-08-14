//
//  TPDataBaseItemSelectController.m
//  TPPensionSell
//
//  Created by 崔玉国 on 14-5-19.
//  Copyright (c) 2014年 cntaiping. All rights reserved.
//

#import "TPDataBaseItemSelectController.h"

@interface TPDataBaseItemSelectController ()

@end

@implementation TPDataBaseItemSelectController
@synthesize items;
@synthesize showField;
@synthesize viewHeight;
@synthesize lastRemarked;

- (id)init {
	if (self = [self initWithStyle:UITableViewStylePlain]) {
        self.lastRemarked = -1;
	}
	return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKCOLOR(@"0xffffff");
}
-(NSNumber*)asModelViewHeight {
    return @(self.viewHeight);
}

#pragma mark UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [tableView dequeueReusableCellOfDefultTheme];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initTheme];
	}
    if (self.showField) {
        cell.textLabel.text = [self.items[indexPath.row] valueForKeyPath:self.showField];
    } else {
        cell.textLabel.text = self.items[indexPath.row];
    }
	
    if (-1!=self.lastRemarked&&indexPath.row==self.lastRemarked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-------------%d :  %@",indexPath.row,self.items[indexPath.row]);
    if (-1!=self.lastRemarked) {
        [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastRemarked inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    } else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NotificationPost(self.superMsgKey, nil, @{@"item":self.items[indexPath.row], @"index":@(indexPath.row)});
    [self.navigationController popViewControllerAnimated:YES];
}


@end
