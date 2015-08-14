//
//  TPLListValuesUtil.h
//  CNTaiPingAgent
//
//  Created by lee on 13-12-14.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLListValuesUtil : NSObject

+ (TPLListValuesUtil *)instance;

- (NSArray *)calTheMaxTitle:(NSArray *)_headerTitles objects:(id)bo withMap:(NSArray *)_relation;
@end
