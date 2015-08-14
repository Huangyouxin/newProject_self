//
//  UIControl+Block.h
//
//  Created by apple on 12-9-10.
//  Copyright (c) 2012年 apple. All rights reserved.
//


@interface UIControl (Block)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)removeHandlerForEvent:(UIControlEvents)event;

@end
