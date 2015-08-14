//
//  TPRemote.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "TPRemote.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import <ASIHTTPRequest/ASIDownloadCache.h>
#import <ASIHTTPRequest/Reachability.h>
#import "TPRemoteProtocol.h"
#import "TPRemoteHeartRateManage.h"




static TPRemote* g_remoteInstance;


@interface TPRemote ()
@property(nonatomic, strong)Reachability* hostReach;
@end
@implementation TPRemote
@synthesize hostReach;


- (instancetype)init {
    if (self = [super init]) {
        // 监测网络情况
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(reachabilityChanged:)
//                                                     name: kReachabilityChangedNotification
//                                                   object: nil];
//        hostReach = [Reachability reachabilityForInternetConnection];
//        [hostReach startNotifier];
    }
    return self;
}

// 接口请求地址
- (NSString *)serverUrl {
    return SERVERL_URL;
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    self.isNetReachability = (status != NotReachable);
}

- (void) startWaitCursor:(NSDictionary*)userInfo {
    id<TPRemoteDelegate> delegate = userInfo[@"delegate"];
    
	if ([delegate conformsToProtocol:@protocol(TPRemoteDelegate)] &&
		[delegate respondsToSelector:@selector(startWaitCursor:)]) {
		[delegate startWaitCursor:[userInfo[@"actionTag"] intValue]];
	}
}

- (void) stopWaitCursor:(NSDictionary*)userInfo {
    id<TPRemoteDelegate> delegate = userInfo[@"delegate"];

	if ([delegate conformsToProtocol:@protocol(TPRemoteDelegate)] &&
		[delegate respondsToSelector:@selector(stopWaitCursor:)]) {
		[delegate stopWaitCursor:[userInfo[@"actionTag"] intValue]];
	}
}

- (void)onError:(NSString*)message userInfo:(NSDictionary*)userInfo{
    id<TPRemoteDelegate> delegate = userInfo[@"delegate"];
    int actionTag = [userInfo[@"actionTag"] intValue];
    
    if ([message isEqualToString:@"网络连接失败，请检查网络状态！"] &&
        ![([[[UIApplication sharedApplication] delegate] window]).rootViewController isKindOfClass:NSClassFromString(@"TPLoginViewController")]) {
        if ((![TPUserDefaults instance].onlyNote)) {
            [TPUserDefaults instance].onlyNote = YES;
        }
    }
    
	if ([delegate conformsToProtocol:@protocol(TPRemoteDelegate)] &&
		[delegate respondsToSelector:@selector(remoteResponsFailed:withMessage:)]) {
		[delegate remoteResponsFailed:actionTag withMessage:message];
	}
    //将页码数据信息返回给页面
    if ([delegate respondsToSelector:@selector(setPageinfo:)]) {
        [(NSObject*)delegate setValue:nil forKey:@"pageInfo"];
    }
    if ([delegate respondsToSelector:@selector(setPageinfo:)]) {
        [(NSObject*)delegate setValue:nil forKey:@"orderBO"];
    }
}

- (void)restoreRefreshState:(id<TPRemoteDelegate>)delegate {
    if ([delegate respondsToSelector:@selector(setPageinfo:)]) {
        [(NSObject *)delegate setValue:nil forKey:@"pageInfo"];
    }
}

+ (TPRemote *)instance {
	@synchronized(self) {
		if (nil == g_remoteInstance) {
			g_remoteInstance = [[TPRemote alloc] init];
            //心跳检测
            [TPRemoteHeartRateManage instance];
            //设置网络超时时间
            [ASIHTTPRequest setDefaultTimeOutSeconds:20];
            [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];
            //注册远程接口数据模型与本地数据模型的对应关系
            [HessianUtils registEntityToRemoteMap:ResourcePath(@"RemoteInterfaceConfig.plist")
                                  defaultProtocol:@protocol(TPRemoteProtocol)];
		}
	}
	return g_remoteInstance;
}

@end
