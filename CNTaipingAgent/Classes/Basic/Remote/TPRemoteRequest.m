//
//  TPRemoteRequest.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "TPRemoteRequest.h"


@implementation TPRemote(Request)


- (void) setInterfaceHeader:(ASIHTTPRequest*)request interfaceType:(RemoteInterfaceType)type {
    switch (type) {
            //基础数据接口
        case RemoteInterfaceTypeBase:
            [request addRequestHeader:@"insType" value:@"BASICZ_INS"];
            [request addRequestHeader:@"deviceType" value:@"1"];
            [request addRequestHeader:@"deviceCode" value:[TPUserDefaults instance].uuid];
            [request addRequestHeader:@"versionId" value:[TPUserDefaults instance].appVersion];
            //布类型（1：App-Store，0：In House）
            [request addRequestHeader:@"releaseType" value:@"0"];
            //应用类型（1：银保）
            [request addRequestHeader:@"appType" value:@"12"];
            break;
            //用户登录接口
        case RemoteInterfaceTypeLogin: {
            NSString* userName = [[request userInfo] objectForKey:@"userName"];
            NSString* passWord = [[request userInfo] objectForKey:@"passWord"];
            
            [request addRequestHeader:@"insType" value:@"LOGIN_INS"];
            [request addRequestHeader:@"_login_sAction" value:@"MOBIL_LOGIN"];
            [request addRequestHeader:@"_login_user_name" value:userName];
            [request addRequestHeader:@"_login_password" value:passWord];
            [request addRequestHeader:@"deviceType" value:@"1"];
            [request addRequestHeader:@"deviceCode" value:[TPUserDefaults instance].uuid];
            [request addRequestHeader:@"PLANT_ID" value:NQ_PLANTID];
            
            [request addRequestHeader:@"versionId" value:[TPUserDefaults instance].appVersion];
            //布类型（1：App-Store，0：In House）
            [request addRequestHeader:@"releaseType" value:@"0"];
            //应用类型（1：银保）
            [request addRequestHeader:@"appType" value:@"12"];
        }
            break;
            //心跳检测接口
        case RemoteInterfaceTypeHeart:
            [request addRequestHeader:@"insType" value:@"HEART_THROB"];
            break;
            //其他接口
        case RemoteInterfaceTypeUpadte:
            [request addRequestHeader:@"insType" value:@"HEART_THROB"];
            break;
        case RemoteInterfaceTypeMessage://消息类型:
            break;
            //其他接口
        default:
            [request addRequestHeader:@"_login_user_name" value:[TPUserDefaults instance].loginUserBO.userName];
            [request addRequestHeader:@"deviceCode" value:[TPUserDefaults instance].uuid];
            [request addRequestHeader:@"versionId" value:[TPUserDefaults instance].appVersion];
            //布类型（1：App-Store，0：In House）
            [request addRequestHeader:@"releaseType" value:@"0"];
            //应用类型（1：银保，2：续期，3：个险，12:个险内勤）
            [request addRequestHeader:@"appType" value:@"12"];
            
            [request addRequestHeader:@"insType" value:@"OTHER_INS"];//权限较多  有互踢功能  和升级提示
#if TARGET_IPHONE_SIMULATOR
            [request addRequestHeader:@"insType" value:@"SIGHTSEER"];//最大权限  不互踢
#endif
            
            [request addRequestHeader:@"upFlag"
                                value:[TPUserDefaults instance].newVersionCancel? @"cancel":@"11"];
            if ([TPUserDefaults instance].intservToken.length >0) {
                [request addRequestHeader:@"INTSERV_TOKEN" value:[TPUserDefaults instance].intservToken];
            }
            [request addRequestHeader:@"PLANT_ID" value:NQ_PLANTID];
            
            break;
    }
}

//下载文件接口，
//url:对应于服务器文件路径
//filePath:下载的文件存放的全路径
//delegate:接收异步返回消息的代理
- (void)downloadFile:(NSString*)requestUrl
           actionTag:(int)actionTag
            filePath:(NSString*)filePath
            delegate:(id<TPRemoteDelegate>)delegate {
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:delegate forKey:@"delegate"];
    [userInfo setObject:filePath forKey:@"fileName"];
    [userInfo setObject:[NSNumber numberWithInt:actionTag] forKey:@"actionTag"];
    ASIHTTPRequest *request = nil;
    @try {
		//开始等待光标
		[self performSelector:@selector(startWaitCursor:) withObject:userInfo];
		
        NSURL *URL = nil;
        if ([requestUrl hasPrefix:@"http://"]) {
            URL = [NSURL URLWithString:requestUrl];
        } else {
            NSString* serverUrl = [self.serverUrl stringByAppendingString:requestUrl];
            URL = [NSURL URLWithString:serverUrl];
        }
        
        request = [ASIHTTPRequest requestWithURL:URL];
		
		// 组织报文头
		[request setRequestMethod:@"GET"];
		[request setUserInfo:userInfo];
        [request setUseCookiePersistence:YES];
        [request setCookieHeaderKey:@"Cookie"];
        
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(DownloadFinish:)];
		[request setDidFailSelector:@selector(DownloadFailed:)];
        //设置下载文件存放路径
		[request setDownloadDestinationPath:filePath];
        //设置文件完成下载前的存放路径，当文件下载完毕后会移到DownloadDestinationPath
        //此主要是为断点续传做个贮备
        [request setTemporaryFileDownloadPath:DownloadTemporaryPath(filePath)];
        [request setShouldAttemptPersistentConnection:NO];
        [request setShouldRedirect:NO];
        [request setShouldContinueWhenAppEntersBackground:NO];
		
		//实现断点续传
		[request setAllowResumeForFileDownloads:YES];
        [request startAsynchronous];
	}
	@catch (NSException * e) {
        TPLLOG(@"-------NSException = %@----", e.reason);
        [self performSelector:@selector(onError:userInfo:request:)
                   withObject:[e reason]
                   withObject:userInfo withObject:nil];
        [self performSelector:@selector(stopWaitCursor:)
                   withObject:userInfo];
        request.userInfo = nil;
	}
}

//执行动作
- (void)doAction:(int)actionTag
            type:(NSString*)requestType
   interfaceType:(RemoteInterfaceType)interfaceType
      requestUrl:(NSString*)requestUrl
       parameter:(NSArray*)parameter
        delegate:(id<TPRemoteDelegate>)delegate {
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    if (nil != delegate) {
        [userInfo setObject:delegate forKey:@"delegate"];
    }
    [userInfo setObject:@(actionTag) forKey:@"actionTag"];
    [userInfo setObject:@(interfaceType) forKey:@"interfaceType"];
    ASIHTTPRequest *request = nil;
    @try {
		//开始等待光标
		[self performSelector:@selector(startWaitCursor:) withObject:userInfo];
        
        NSURL *URL = nil;
        if ([requestUrl hasPrefix:@"http://"]) {
            URL = [NSURL URLWithString:requestUrl];
        } else {
            NSString* serverUrl = [self.serverUrl stringByAppendingString:requestUrl];
            URL = [NSURL URLWithString:serverUrl];
        }
        
        SEL selector = [HessianUtils receiveMethodSelector:requestType];
        if (nil != selector) {
            NSString *selectorName = NSStringFromSelector(selector);
            int count = [selectorName componentsSeparatedByString:@":"].count-1;
            if (count != parameter.count) {
                TPLLOG(@"---请检查接口方法=%@ 对应的请求参数个数是否本接口一致！\n该接口需要%d个参数但当前您只传了%d个参数，如必须某参数"
                       @"传递null值，则请用[NSNull null]代替", selectorName, count, parameter.count);
                [self performSelector:@selector(restoreRefreshState:) withObject:delegate];
                [self performSelector:@selector(stopWaitCursor:)
                           withObject:userInfo];
                return;
            }
        } else {
            TPLLOG(@"---老大，你把接口函数在RemoteInterfaceConfig.plist文件中注册啊，你这么干能干通你牛B！");
            [self performSelector:@selector(restoreRefreshState:) withObject:delegate];
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:userInfo];
            return;
        }
        
        TPLLOG(@"---Hessian-------ServerUrl=%@", URL.absoluteString);
        TPLLOG(@"----------method=%@", NSStringFromSelector(selector));
        TPLLOG(@"----------parameter=%@", parameter);
        
        if (interfaceType == RemoteInterfaceTypeLogin&&parameter.count>=2) {
            [userInfo setObject:[parameter objectAtIndex:0] forKey:@"userName"];
            [userInfo setObject:[parameter objectAtIndex:1] forKey:@"passWord"];
            [ASIHTTPRequest clearSession];
        }
        // 组织报文头
        request = [ASIHTTPRequest requestWithURL:URL];
        [request setUserInfo:userInfo];
		[request setRequestMethod:@"POST"];
		[request addRequestHeader:@"Content-Type" value:@"text/xml"];
		[request setUseCookiePersistence:YES];
        [request setCookieHeaderKey:@"Cookie"];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(ActionFinish:)];
		[request setDidFailSelector:@selector(ActionFailed:)];
        [self setInterfaceHeader:request interfaceType:interfaceType];
        [request setDidReceiveResponseHeadersSelector:@selector(ActionReceiveResponseHeaders:withHeaders:)];
        [request setShouldAttemptPersistentConnection:NO];
        [request setShouldRedirect:NO];
        [request setShouldContinueWhenAppEntersBackground:NO];
        
        //        TPLLOG(@"---------request header=%@", request.requestHeaders);
        id proxy = (id) [CWHessianConnection proxyWithURL:URL reqBlock:^(NSData *data) {
            [request setPostBody:(NSMutableData*)data];
            [request startAsynchronous];
        }];
        
        [userInfo setObject:proxy forKey:@"TPLRemoteObject"];
        [proxy performSelector:selector withObjects:parameter];
	}
	@catch (NSException * e) {
        [self performSelector:@selector(onError:userInfo:request:)
                   withObject:[e reason]
                   withObject:userInfo withObject:nil];
        [self performSelector:@selector(restoreRefreshState:) withObject:delegate];
        [self performSelector:@selector(stopWaitCursor:)
                   withObject:userInfo];
        request.userInfo = nil;
	}
}


+ (void)doAction:(int)actionTag
            type:(NSString*)requestType
   interfaceType:(RemoteInterfaceType)interfaceType
      requestUrl:(NSString*)requestUrl
        delegate:(id<TPRemoteDelegate>)delegate
       parameter:(id)parameter,... {
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    if(nil != parameter) {
        [argsArray addObject:parameter];
        id arg;
        va_list argList;
        va_start(argList,parameter);
        while ((arg = va_arg(argList,id))) {
            if (nil != arg) {
                [argsArray addObject:arg];
            }
        }
        va_end(argList);
    }
    
    [[TPRemote instance] doAction:actionTag
                              type:requestType
                     interfaceType:interfaceType
                        requestUrl:requestUrl
                         parameter:argsArray
                          delegate:delegate];
}


+ (void)downloadFile:(NSString*)requestUrl
           actionTag:(int)actionTag
            filePath:(NSString*)filePath
            delegate:(id<TPRemoteDelegate>)delegate {
    [[TPRemote instance] downloadFile:requestUrl
                             actionTag:actionTag
                              filePath:filePath
                              delegate:delegate];
}



@end
