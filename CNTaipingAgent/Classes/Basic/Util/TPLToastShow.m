//
//  TPLToastShow.m
//  CNTaiPingPension
//
//  Created by 崔玉国 on 13-9-6.
//  Copyright (c) 2013年 CNTaiPing. All rights reserved.
///

#import "TPLToastShow.h"


static TPLToastShow *userTPLToastShowInstance = nil;


@interface TPLToastShow ()<MBProgressHUDDelegate>

@end
@implementation TPLToastShow


+ (TPLToastShow *)instance {
	@synchronized(self) {
		if (userTPLToastShowInstance == nil) {
			userTPLToastShowInstance = [[self alloc] init];
		}
	}
	return userTPLToastShowInstance;
}


+ (void) showToast:(UIImage*)image content:(NSString*)content completion:(void (^)(void))completion {
    if (content.length <= 0) {
        return;
    }
    
    UIView* view = ((TPLAppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController.view;
	__block MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:view];
	[view addSubview:HUD];
	
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:image];

	HUD.mode = MBProgressHUDModeCustomView;
	HUD.opacity = .6;
//    HUD.fillColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
	HUD.delegate = [TPLToastShow instance];
	HUD.labelText = content;
	
	[HUD show:YES];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [HUD removeFromSuperview];
         HUD = nil;
        if (nil != completion) {
            completion();
        }
    });
}


@end
