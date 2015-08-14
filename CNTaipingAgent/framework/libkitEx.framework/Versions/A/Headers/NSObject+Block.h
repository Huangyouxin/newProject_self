//
//  NSObject(Block).h
//
//  Created by apple on 12-9-10.
//  Copyright (c) 2012年 apple. All rights reserved.
//

@interface NSObject(Block)

//perform block1 in main thread,when finished perform block2 in background
+(void)perform:(void(^)())block1 withCompletion:(void (^)())block2;
-(void)perform:(void(^)())block1 withCompletion:(void (^)())block2;


//用户传递附加参数
@property(nonatomic, strong)id param;


@end
