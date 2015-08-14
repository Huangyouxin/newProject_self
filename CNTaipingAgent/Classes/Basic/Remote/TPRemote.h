//
//  TPRemote.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
// 


@protocol TPRemoteDelegate<NSObject>
@required
- (void) startWaitCursor:(int)actionTag;
- (void) stopWaitCursor:(int)actionTag;
@optional
//actionTag:客户端在发送请求时可以随便定义一个数值，以便于接收消息的delegate能够区分返回的数据是哪个命令的反馈数据
- (void) remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData;
- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message;
@end



/**
 *	@brief	远程调用接口类
 */
@interface TPRemote : NSObject
//网络是否可用
@property(nonatomic, assign)BOOL isNetReachability;
//接口请求地址
@property(nonatomic, readonly)NSString*  serverUrl;


+ (TPRemote *)instance;

@end

