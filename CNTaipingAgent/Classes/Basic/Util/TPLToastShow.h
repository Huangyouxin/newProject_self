//
//  TPLToastShow.h
//  CNTaiPingPension
//
//  Created by 崔玉国 on 13-9-6.
//  Copyright (c) 2013年 CNTaiPing. All rights reserved.
///

#import <Foundation/Foundation.h>

@interface TPLToastShow : NSObject

+ (void) showToast:(UIImage*)image content:(NSString*)content completion:(void (^)(void))completion;
@end
