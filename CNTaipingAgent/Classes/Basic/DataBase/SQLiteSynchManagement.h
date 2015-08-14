//
//  SQLiteSynchManagement.h
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-9-2.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//


/**
 *	@brief	码表同步管理
 */
@interface SQLiteSynchManagement : NSObject
+ (SQLiteSynchManagement *)instance;
//是否已经同步过了
+ (BOOL) hasSynched;
- (void) startSynch;
@end
