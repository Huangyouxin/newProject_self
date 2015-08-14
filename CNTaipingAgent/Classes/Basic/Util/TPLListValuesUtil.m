    //
//  TPLListValuesUtil.m
//  CNTaiPingAgent
//
//  Created by lee on 13-12-14.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "TPLListValuesUtil.h"

static TPLListValuesUtil *utilInstance = nil;

@implementation TPLListValuesUtil

+ (TPLListValuesUtil *)instance
{
    @synchronized(self) {
		if (utilInstance == nil) {
			utilInstance = [[self alloc] init];
		}
	}
	return utilInstance;
}

- (NSArray *)calTheMaxTitle:(NSArray *)_headerTitles objects:(id)bo withMap:(NSArray *)_relation
{
    if (_headerTitles.count != _relation.count) {
        return nil;
    }
    NSMutableArray *widresult = [NSMutableArray array];
    
    __block CGFloat widths = 0;
    [_headerTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat width = 0;
        CGFloat titleWidth = CalcTextWidth(FontOfSize(FontNormalSize), _headerTitles[idx], 10000);
        
        __block CGFloat boWidth = 0;
        [bo enumerateObjectsUsingBlock:^(id objs, NSUInteger idxs, BOOL *stops) {
            id objj = [objs valueForKey: _relation[idx]];
            NSString *str = @"";
            if ([objj isKindOfClass:[NSString class]]) str = objj;
            else if ([objj isKindOfClass:[NSDate class]]) str = StringFromDate(objj, @"yyyy-MM-dd");
            else  str = [NSString stringWithFormat:@"%ld",[objj longValue]];
            
            CGFloat relationWidth = CalcTextWidth(FontOfSize(FontNormalSize), str, 10000);
            boWidth = boWidth>relationWidth ? boWidth : relationWidth;
        }];
        width = titleWidth>boWidth?titleWidth:boWidth;
        widths = widths + width;
        [widresult addObject:[NSString stringWithFormat:@"%f",width]];
    }];
    //不满一屏则铺满一屏
    NSMutableArray *result = [NSMutableArray array];
    if (widths+20*[_headerTitles count] < 904) {
        CGFloat colWidth = (904-widths)/[_headerTitles count];
        colWidth = colWidth<20?20:colWidth;
        [widresult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [result addObject:[NSString stringWithFormat:@"%f",([obj floatValue]+colWidth)]];
        }];
    }else{
        [widresult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [result addObject:[NSString stringWithFormat:@"%f",([obj floatValue]) + 20]];
        }];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
