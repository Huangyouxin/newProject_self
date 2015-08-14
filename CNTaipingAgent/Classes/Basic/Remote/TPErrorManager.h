//
//  TPErrorManager.h
//  Pension
//
//  Created by 崔玉国 on 14-4-22.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface TPErrorManager : NSObject
+ (NSString*) parseErrorMsg:(int)errorcode;
+ (BOOL) parseRemoteBOErrorMsg:(TPErrors*)error;
@end
