//
//  TPLLoginViewController.h
//  CNTaiPingLife
//
//  Created by apple on 13-4-16.
//  Copyright (c) 2013年 CNTaiPing. All rights reserved.
//

#import "TPHttpViewController.h"

/**
 *	@brief	打开客户端启动页后的第一个页面：使用者登录系统
 */


@interface TPLoginViewController : TPHttpViewController

- (id)initWithWinkTocken:(NSString*)winktocken;

@end

