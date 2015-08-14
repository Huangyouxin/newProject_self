//
//  TPHttpViewController.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//
#import "TPViewController.h"
#import "TPRemote.h"


/**
 *	@brief	有网络请求的页面基类
 */
@interface TPHttpViewController : TPViewController<TPRemoteDelegate>
//是否正在加载数据
@property(nonatomic,readonly)BOOL isLoading;
@property(nonatomic,weak)ASIHTTPRequest *request;

- (void) startWaitCursor:(int)actionTag;
- (void) stopWaitCursor:(int)actionTag;
@end


