//
//  UIPopView+Block.h
//
//  Created by apple on 12-9-10.
//  Copyright (c) 2012年 apple. All rights reserved.
//



@interface UIAlertView (Block)<UIAlertViewDelegate>
-(void)showWithCompletion:(void (^)(NSInteger buttonIndex))completion;
@end

@interface UIActionSheet (Block)<UIActionSheetDelegate>
-(void)showInView:(UIView *)view withCompletion:(void (^)(NSInteger buttonIndex))completion;
-(void)showFromToolbar:(UIToolbar *)view withCompletion:(void (^)(NSInteger buttonIndex))completion;
-(void)showFromTabBar:(UITabBar *)view withCompletion:(void (^)(NSInteger buttonIndex))completion;
-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
     withCompletion:(void (^)(NSInteger buttonIndex))completion;
-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
              withCompletion:(void (^)(NSInteger buttonIndex))completion;
@end
