//
//  TPRemoteResponse.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//


#import "TPRemoteResponse.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import "TPErrorManager.h"


@implementation TPRemote(Response)




/*===============================================================================================*/
/*                                  下载文件相关的响应处理部分                                         */
/*===============================================================================================*/
- (void)DownloadFinish:(ASIHTTPRequest *)request {
	@synchronized(self) {
		@try {
            id<TPRemoteDelegate> delegate = [[request userInfo] objectForKey:@"delegate"];
            int commandTag = [[[request userInfo] objectForKey:@"actionTag"] intValue];
			NSString* fileName = [[request userInfo] objectForKey:@"fileName"];
			
			//通知已成功下载消息给相关代理
			if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
				[delegate remoteResponsSuccess:commandTag withResponsData:fileName];
			}
			
			//停止等待光标
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:[request userInfo]];
            request.userInfo = nil;
		}
		@catch (NSException * e) {
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:[request userInfo]];
		}
        @finally {
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:request.userInfo];
            request.userInfo = nil;
        }
	}
}

- (void)DownloadFailed:(ASIHTTPRequest *)request {
	@synchronized(self) {
		@try {
            NSError *error = [request error];
			//通知错误消息
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[error localizedDescription]
                       withObject:[request userInfo]];
		}
		@catch (NSException * e) {
			[self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:[request userInfo]];
		}
        @finally {
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:request.userInfo];
            request.userInfo = nil;
        }
	}
}
/*===============================================================================================*/
/*                                     doAction响应处理部分                                         */
/*===============================================================================================*/
static const int STATUS_SUCCESS = 90001;
- (void)ActionReceiveResponseHeaders:(ASIHTTPRequest *)request withHeaders:(NSDictionary*)headers {
	@synchronized(self) {
		@try {
            //            TPLLOG(@"-----Response Header=%@", request.responseHeaders);
            if ([headers objectForKey:@"INTSERV_TOKEN"]) {
                [TPUserDefaults instance].intservToken = [headers objectForKey:@"INTSERV_TOKEN"];
            }
            //没有错误代码，放过
            if (nil == [headers valueForKey:@"errorcode"]) {
                return;
            }
            //服务器返回非成功状态，cancel请求链接
			NSArray* eCodes = [[headers valueForKey:@"errorcode"] componentsSeparatedByString:@","];
			int responseStatus = [[eCodes lastObject] intValue];
            //检查新版本发布
            id<TPRemoteDelegate> delegate = [[request userInfo] objectForKey:@"delegate"];
            if (20001 == responseStatus) {
                if ([delegate isKindOfClass:[TPViewController class]]) {
                    NSMutableDictionary* newVersion = [NSMutableDictionary dictionary];
                    [newVersion setObject:[headers valueForKey:@"versioncode"] forKey:@"versioncode"];
                    [newVersion setObject:[headers valueForKey:@"versionaddr"] forKey:@"versionaddr"];
                    if (UpdateNetUpdateStatus) {
                        if ([[headers valueForKey:@"versionstatus"] isKindOfClass:[NSString class]]) {
                            if ([[headers valueForKey:@"versionstatus"] isEqualToString:@"Y"]) {
                                [newVersion setObject:@YES forKey:@"versionstatus"];
                            }else [newVersion setObject:@NO forKey:@"versionstatus"];
                        }else [newVersion setObject:[headers valueForKey:@"versionstatus"] forKey:@"versionstatus"];
                    }else {
                        [newVersion setObject:@YES forKey:@"versionstatus"];
                    }

                    
                    NotificationPost(NotificationMsg_HAS_NEW_VERSION, nil, newVersion);
                    
//                    if (![[headers valueForKey:@"versionstatus"] boolValue]) {
                    if ([[headers valueForKey:@"versionstatus"] isEqualToString:@"Y"]) {
                        //返回错误信息
                        [self performSelector:@selector(onError:userInfo:)
                                   withObject:nil
                                   withObject:[request userInfo]];
                        [self performSelector:@selector(stopWaitCursor:)
                                   withObject:request.userInfo];
                        request.userInfo = nil;
                    }
                }
            } else if (responseStatus != STATUS_SUCCESS && responseStatus != Login_Lost_Status) {
                [request clearDelegatesAndCancel];
                //返回错误信息
                [self performSelector:@selector(onError:userInfo:)
                           withObject:[TPErrorManager parseErrorMsg:responseStatus]
                           withObject:[request userInfo]];
                [self performSelector:@selector(stopWaitCursor:)
                           withObject:request.userInfo];
                request.userInfo = nil;
            }
            if (responseStatus == Login_Lost_Status) {
                [TPUserDefaults instance].status_login = responseStatus;
            }
		}
		@catch (NSException * e) {
			[self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:[request userInfo]];
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:request.userInfo];
            request.userInfo = nil;
		}
	}
}

- (void)ActionFinish:(ASIHTTPRequest *)request {
#ifdef GenerateRemoteDataCache
    NSString *methodName = request.userInfo[@"methodName"];
    NSString *parameters = request.userInfo[@"parameters"];
#endif
	if ([self onHessianData:request data:request.responseData]) {
#ifdef GenerateRemoteDataCache
        TPLCacheDataBO *bo = [[TPLCacheDataBO alloc] init];
        bo.methodName = methodName;
        bo.parameters = parameters;
        bo.remoteData = request.responseData;
        [DB addDataToDB:bo];
#endif
    }
}

- (void)ActionFailed:(ASIHTTPRequest *)request {
	@synchronized(self) {
        @try {
#ifdef GenerateRemoteDataCache
            __block TPLCacheDataBO *cacheData = nil;
            NSString *methodName = request.userInfo[@"methodName"];
            NSString *parameters = request.userInfo[@"parameters"];
            [DB searchWhere:@{@"methodName":methodName, @"parameters":parameters}
                    orderBy:nil offset:0 count:1000 Class:[TPLCacheDataBO class]
                   callback:^(NSArray *results) {
                       if (results.count > 0) {
                           cacheData = results[0];
                       }
                   }];
            if ([self onHessianData:request data:cacheData.remoteData]) {
                return;
            }
#endif
            NSError *error = [request error];
			//通知错误消息
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[error localizedDescription]
                       withObject:[request userInfo]];
        }
        @catch (NSException *e) {
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:[request userInfo]];
        }
        @finally {
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:request.userInfo];
            request.userInfo = nil;
        }
	}
}

- (BOOL)onHessianData:(ASIHTTPRequest *)request data:(NSData*)responseData {
    @try {
        if ([responseData length] <= 0) {
            TPLLOG(@"数据接口返回的数据为空，请调试检查！");
            [self performSelector:@selector(restoreRefreshState:)
                       withObject:request.userInfo[@"delegate"]];
            return FALSE;
        }
        NSDictionary *userInfo = request.userInfo;
        int type = [userInfo[@"interfaceType"] intValue];
        NSObject* hessianObject = userInfo[@"TPLRemoteObject"];
        
        //反序列化服务器接口数据
        id returnValue = [hessianObject performSelector:@selector(unarchiveData:)
                                             withObject:responseData];
        //数据不正确
        if (nil == returnValue) {
            TPLLOG(@"数据接口返回的数据不能被Hessian反序列化！");
            [self performSelector:@selector(restoreRefreshState:)
                       withObject:request.userInfo[@"delegate"]];
            return FALSE;
        }
        
        //处理消息
        if (RemoteInterfaceTypeMessage == type) {
            return [self onMessageSuccess:userInfo withData:returnValue];
        } else {
            if (RemoteInterfaceTypeUpadte == type) {
                return [self onUpdateSuccess:userInfo withData:returnValue];
            }else return [self onHessianServiceSuccess:userInfo
                                              withData:[self parseRemoteData:returnValue]];
        }
    }
    @catch (NSException * e) {
        TPLLOG(@"-------NSException = %@----", e.reason);
        [self performSelector:@selector(onError:userInfo:)
                   withObject:[e reason]
                   withObject:[request userInfo]];
        return FALSE;
    }
    @finally {
        [self performSelector:@selector(stopWaitCursor:)
                   withObject:request.userInfo];
        request.userInfo = nil;
    }
}

- (BOOL)onMessageSuccess:(NSDictionary *)userInfo withData:(id)resData {
    NSDictionary *jsonData = [resData JSONDecoder];
    id<TPRemoteDelegate> delegate = userInfo[@"delegate"];
    if (nil == jsonData) {
        [self performSelector:@selector(restoreRefreshState:)
                   withObject:delegate];
        return TRUE;
    }
    
    int actionTag = [userInfo[@"actionTag"] intValue];
    
    //将页码数据信息返回给页面
    if ([delegate respondsToSelector:@selector(setPageInfo:)]) {
        [(NSObject*)delegate setValue:nil forKey:@"pageInfo"];
    }
    if ([delegate conformsToProtocol:@protocol(TPRemoteDelegate)] &&
        [delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
        [delegate remoteResponsSuccess:actionTag withResponsData:jsonData];
    }
    //空数据统一处理
    if ([delegate respondsToSelector:@selector(checkNullRecords)]) {
        [delegate performSelector:@selector(checkNullRecords)];
    }
    return TRUE;
}

- (BOOL)onUpdateSuccess:(NSDictionary*)userInfo withData:(id)resData {
    NSDictionary *dic = resData;
    
    id<TPRemoteDelegate> delegate = userInfo[@"delegate"];
    int actionTag = [userInfo[@"actionTag"] intValue];
    
    if (nil == dic) {
        TPLLOG(@"数据接口返回的数据有问题，请核查！");
        return FALSE;
    }
    
    //将数据返回到页面
    if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
        [delegate remoteResponsSuccess:actionTag
                       withResponsData:dic];
    }
    
    return YES;
}

- (BOOL)onHessianServiceSuccess:(NSDictionary *)userInfo withData:(id)resData {
    id<TPRemoteDelegate> delegate = userInfo[@"delegate"];
    int actionTag = [userInfo[@"actionTag"] intValue];
    
    //数据不正确
    if (nil == resData) {
        TPLLOG(@"数据接口返回的数据有问题，请核查！");
        [self performSelector:@selector(restoreRefreshState:)
                   withObject:delegate];
        return FALSE;
    }
    
    TPResultBO* result = (TPResultBO*)resData;
    
    //先检查错误信息
    if (0 == result.error.errCode) {
        //无错误，此有两种：1、result.error为空；2、result.error非空，但result.error.errCode=0
    } else if (-1 == result.error.errCode) {
        //无错误，但有提示信息需要显示给使用者（此时result.error必定不为空，并且result.error.errCode=-1）
        if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withMessage:)]) {
            [delegate performSelector:@selector(remoteResponsSuccess:withMessage:)
                           withObject:@(actionTag) withObject:result.error.message];
        }
    } else if ([TPErrorManager parseRemoteBOErrorMsg:result.error]){
        //有错误（此时result.error必定不为空，并且result.error.errCode不为0和-1）
        TPLLOG(@"----error: errCode=%d, errDesc=%@, message:%@",
               result.error.errCode, result.error.errDesc, result.error.message);
        [self performSelector:@selector(restoreRefreshState:)
                   withObject:delegate];
        if ([delegate conformsToProtocol:@protocol(TPRemoteDelegate)] &&
            [delegate respondsToSelector:@selector(remoteResponsFailed:withMessage:)]) {
            [delegate remoteResponsFailed:actionTag withMessage:nil];
        }
        return FALSE;
    }
    //将页码数据信息返回给页面
    if ([delegate respondsToSelector:@selector(setPageInfo:)]) {
        [(NSObject*)delegate setValue:result.pageInfo forKey:@"pageInfo"];
    }
//    NSLog(@"result.resultObj:%@",result.resultObj);
    //将数据返回到页面
    if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
        [delegate remoteResponsSuccess:actionTag
                       withResponsData:result.resultObj];
    }
    //空数据统一处理
    if ([delegate respondsToSelector:@selector(checkNullRecords)]) {
        [delegate performSelector:@selector(checkNullRecords)];
    }
    return YES;
}

- (id)parseRemoteData:(id)remoteData {
    if ([remoteData isKindOfClass:[TPResultBO class]]) {
        return remoteData;
    } else {
        if ([remoteData isKindOfClass:[TPLoginUserErrorBO class]]) {
            TPLoginUserErrorBO *err = (TPLoginUserErrorBO *)remoteData;
            TPResultBO *resultBO = [[TPResultBO alloc] init];
            resultBO.error = [[TPErrors alloc] init];
            resultBO.error.errCode = err.err_code;
            resultBO.error.errDesc = err.message;
            resultBO.error.message = err.err_desc;
            resultBO.resultObj = err;
            return resultBO;
            
        }else if ([remoteData isKindOfClass:[TPErrors class]]) {
            TPErrors *error = (TPErrors*)remoteData;
            TPResultBO *resultBO = [[TPResultBO alloc] init];
            
            resultBO.error = [[TPErrors alloc] init];
            resultBO.error.errCode = error.errCode;
            resultBO.error.message = error.message;
            resultBO.error.errDesc = error.errDesc;
            
            return resultBO;
        } else if ([remoteData isKindOfClass:[NSString class]]){
            if (remoteData) {
                TPResultBO *resultBO = [[TPResultBO alloc] init];
                resultBO.resultObj = remoteData;
                resultBO.error.errCode = 0;
                return resultBO;
            }
            return nil;
        }else if ([remoteData isKindOfClass:[NSNumber class]]){
            if (remoteData) {
                TPResultBO *resultBO = [[TPResultBO alloc] init];
                resultBO.resultObj = remoteData;
                resultBO.error.errCode = 0;
                return resultBO;
            }
            return nil;
        } else {
            return nil;
        }
    }
}

@end