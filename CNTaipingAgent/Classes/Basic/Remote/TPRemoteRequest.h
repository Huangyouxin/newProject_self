//
//  TPRemoteRequest.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//
#import "TPRemote.h"


@interface TPRemote(Request)



typedef NS_ENUM(NSInteger, RemoteInterfaceType) {
    RemoteInterfaceTypeBase,  //基础数据调用类型
    RemoteInterfaceTypeLogin, //用户登录接口调用类型
    RemoteInterfaceTypeHeart, //心跳检测接口类型
    RemoteInterfaceTypeOther, //其他接口调用类型
    RemoteInterfaceTypeMessage,//消息类型
    RemoteInterfaceTypeUpadte//自动更新类型
};

/**
 *	@brief	向服务器发送Hessian请求动作
 *
 *	@param 	actionTag 	标志本请求的tag
 *	@param 	requestType 请求类型，与RemoteInterfaceConfig第一级对应
 *	@param 	interfaceType 接口类型
 *	@param 	requestUrl 	请求接口地址
 *	@param 	delegate 	响应的回掉代理
 *	@param 	parameter 	请求的方法要传的参数顺序列表
 *                      可变参数，在调用的时候要在参数结尾加nil
 */
+ (void)doAction:(int)actionTag
            type:(NSString*)requestType
   interfaceType:(RemoteInterfaceType)interfaceType
      requestUrl:(NSString*)requestUrl
        delegate:(id<TPRemoteDelegate>)delegate
       parameter:(id)parameter,...;

/**
 *	@brief	异步下载文件
 *
 *	@param 	actionTag 	标志本请求的tag
 *	@param 	filePath    文件下载后的全路径
 *	@param 	requestUrl 	请求文件地址
 *	@param 	delegate 	响应的回掉代理
 */
+ (void)downloadFile:(NSString*)requestUrl
           actionTag:(int)actionTag
            filePath:(NSString*)filePath
            delegate:(id<TPRemoteDelegate>)delegate;
@end
