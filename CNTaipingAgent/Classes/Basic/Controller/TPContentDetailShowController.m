//
//  TPContentDetailShowController.m
//  TPPensionSell
//
//  Created by cuiyuguo
//  Copyright (c) 2014年 cntaiping. All rights reserved.
//

#import "TPContentDetailShowController.h"

@interface TPContentDetailShowController ()

@end

@implementation TPContentDetailShowController




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (0 < cell.textLabel.text.length) {
        CGFloat height = [cell.textLabel textHeight:tableView.width-2*PADDING];
        return height + PADDING * 2;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [tableView dequeueReusableCellOfDefultTheme];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initTheme];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.useAttributed = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(cell) Cell = cell;
        [cell addLayoutBlock:^{
            Cell.textLabel.frame = CGRectMake(PADDING, PADDING, Cell.width-PADDING*2, Cell.height-PADDING*2);
        }];
	}
    cell.textLabel.text = self.param;
    
	return cell;
}

@end
