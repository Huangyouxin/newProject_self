//
//  TPHttpViewController.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "TPHttpViewController.h"
#import <ASIHTTPRequest/Reachability.h>
#import "TPLToastShow.h"

@interface TPHttpViewController() {
    UILabel* progressLabel;
}
@property(nonatomic, strong)MBProgressHUD* progressView;
@end


@implementation TPHttpViewController
@synthesize progressView;



- (void) startWaitCursor:(int)actionTag {
    if (nil == self.progressView) {
        progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressView.labelFont = FontOfSize(FontLargeSize);
        progressView.labelText = @"加载中....";
        progressView.opaque = .6;
    } else {
        [self.progressView show:YES];
    }
}

- (void) stopWaitCursor:(int)actionTag {
    if (self.progressView) {
        [self.progressView hide:NO];
    }
}

- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message {
    [TPLToastShow showToast:nil content:message completion:nil];
    TPLLOG(@"=============error:%@", message, nil);
}

- (void) remoteResponsSuccess:(NSNumber*)actionTag withMessage:(NSString*)message {
    ShowMessage(message, nil);
}

@end

