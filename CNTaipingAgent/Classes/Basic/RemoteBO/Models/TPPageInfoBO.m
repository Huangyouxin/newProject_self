//
//  TPPageInfo.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPPageInfoBO.h"

@implementation TPPageInfoBO
@synthesize totalCount;
@synthesize totlePage;
@synthesize currentPageIndex;
@synthesize pageSize;

- (int) totlePage {
    int pagesize = [self.pageSize intValue];
    if ([totalCount intValue] + pagesize == 0) {
        return 0;
    }
    return ([totalCount intValue] + pagesize - 1) / pagesize;
}

- (NSArray *)encodeIgnorePropertys {
    return @[@"totlePage"];
}
@end
