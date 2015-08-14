//
//  TPRemoteHeartRateManage.m
//  CNTaiPingLife
//
//  Created by apple on 13-5-10.
//  Copyright (c) 2013年 CNTaiPing. All rights reserved.
//

#import "TPRemoteHeartRateManage.h"
#import "TPWindow.h"
#import "TPLAppDelegate.h"

static TPRemoteHeartRateManage* g_remoteHeartRateInstance;

@interface TPRemoteHeartRateManage ()<TPRemoteDelegate>
@property(nonatomic, strong)NSTimer*  heartRateTimer;
@end

@implementation TPRemoteHeartRateManage

+ (TPRemoteHeartRateManage *)instance {
	@synchronized(self) {
		if (nil == g_remoteHeartRateInstance) {
			g_remoteHeartRateInstance = [[TPRemoteHeartRateManage alloc] init];
		}
	}
	return g_remoteHeartRateInstance;
}

- (id) init {
    if (self = [super init]) {
        self.heartRateTimer = [NSTimer scheduledTimerWithTimeInterval:5*60
                                                               target:self
                                                             selector:@selector(onEventHeartRateTimeout:)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    return self;
}

- (void) dealloc {
    [self.heartRateTimer invalidate];
}

- (void) onEventHeartRateTimeout:(NSTimer*)timer {
    if ([TPUserDefaults instance].userName) {
        TPWindow* window = (TPWindow*) ((TPLAppDelegate*)[UIApplication sharedApplication].delegate).window;
        NSString* lastTouchTime = StringFromDate(window.lastTouchTime, @"yyyy-MM-dd HH:mm:ss");
        NSString* heartTime = StringFromDate([NSDate date], @"yyyy-MM-dd HH:mm:ss");
        
        if (![TPUserDefaults instance].onlyNote) {
            [TPRemote doAction:0
                          type:@"心跳检测接口"
                 interfaceType:RemoteInterfaceTypeHeart
                    requestUrl:URL_heartRate
                      delegate:self
                     parameter:[TPUserDefaults instance].intservToken,heartTime,lastTouchTime,nil];
        }
    }
}


#pragma mark TPLRemoteDelegate
- (void) startWaitCursor:(int)actionTag{
    
}
- (void) stopWaitCursor:(int)actionTag{
    
}

- (void) remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData {
    
}
- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message {
    
}
@end
