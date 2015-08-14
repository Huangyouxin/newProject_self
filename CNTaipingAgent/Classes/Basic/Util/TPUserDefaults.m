//
//  TPUserDefaults.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright 2014 CNTaiping. All rights reserved.
//

#import "TPUserDefaults.h"
#import "TPUIToolkit.h"




static TPUserDefaults *userDefaultsInstance = nil;



@interface TPUserDefaults()
@property(nonatomic, strong)NSUserDefaults *defaults;
@property(nonatomic, strong)NSDictionary *constantSetting;
@property(nonatomic, strong)NSDictionary *skinColors;
@end

@implementation TPUserDefaults
@synthesize defaults, constantSetting, skinColors;
@synthesize loginTimestamp;
@synthesize userName, password;
@synthesize authToken, intservToken;
@synthesize newVersionCancel;
@synthesize hasNewMsg;
@synthesize isFirstLogin;
@synthesize status_login;
@synthesize loginUserBO;
@synthesize prodFileName;
@synthesize isAgentBO;
@synthesize onlyNote;
@synthesize isHasInApp;
@synthesize pdfLength;
@synthesize wxpdfLength;
@synthesize selMessage;
@synthesize selMsgCustomer;
@synthesize canShowProduct = _canShowProduct;

+ (TPUserDefaults *)instance {
	@synchronized(self) {
		if (userDefaultsInstance == nil) {
			userDefaultsInstance = [[self alloc] init];
		}
	}
	return userDefaultsInstance;
}


- (id)init {
	if (self = [super init]) {
        // Custom initialization
		defaults = [NSUserDefaults standardUserDefaults];
		self.authToken = @"";
        self.intservToken = @"";
        
        self.loginUserBO = [[TPIPISUserExt alloc] init];
        self.isAgentBO = [[TPISAgentAgnetBO alloc] init];
        self.filePath = [[NSMutableDictionary alloc] init];
        
		self.constantSetting = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"constantSetting.plist")];
		NSFileManager *manager = [NSFileManager defaultManager];
		if (nil != self.skinBundle &&
			[manager fileExistsAtPath:ResourcePath([self.skinBundle stringByAppendingString:@"/ColorSetting.plist"])]) {
			
			self.skinColors = [NSDictionary dictionaryWithContentsOfFile:
                               ResourcePath([self.skinBundle stringByAppendingString:@"/ColorSetting.plist"])];
		} else {
			self.skinColors = [NSDictionary dictionaryWithContentsOfFile:
                               ResourcePath([NSString stringWithFormat:@"resource.bundle/ColorSetting.plist"])];
		}
    }
    return self;
}


//应用的中文名称
- (NSString*) appName {
	NSDictionary* plistInfo = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"Info.plist")];
	
	return [plistInfo objectForKey:@"CFBundleDisplayName"];
}

//应用的版本号
- (NSString*) appVersion {
	NSDictionary* plistInfo = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"Info.plist")];
	
    //	return [plistInfo objectForKey:@"CFBundleVersion"];
    return [plistInfo objectForKey:@"CFBundleShortVersionString"];
}

- (NSString*) skinBundle {
	NSString* skinName = [defaults stringForKey:@"skinBundle"];
	if (nil != skinName) {
		return skinName;
	} if (nil != constantSetting) {
		if ([(NSArray *)[constantSetting objectForKey:@"Skins"] count] > 0) {
			return [[constantSetting objectForKey:@"Skins"] objectAtIndex:0];
		}
	}
	return nil;
}

- (void) setSkinBundle:(NSString*)skinBundle {
	[defaults setObject:skinBundle forKey:@"skinBundle"];
	[defaults synchronize];
	
	self.skinColors = [NSDictionary dictionaryWithContentsOfFile:
                       ResourcePath([skinBundle stringByAppendingString:@"/ColorSetting.plist"])];
}

- (UIColor*) tintColor {
	return BACKCOLOR(@"0x185992");
}

- (UIColor*) getColorByColorKey:(NSString*) colorKey {
	if (nil == [skinColors objectForKey:colorKey]) {
		NSRange range = [colorKey rangeOfString:@"_0x"];
		if (range.length > 0) {
			return [UIColor colorWithHexString:[colorKey substringFromIndex:range.location+1]];
		}
	}
	return [UIColor colorWithHexString:[self.skinColors objectForKey:colorKey]];
}

- (NSString*) deviceIdentifier {
    return [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
}

- (NSString*) macAddress {
    return [[UIDevice currentDevice] macaddress];
}


- (NSString*) uuid {
    __block NSArray *resultArray = nil;
    [DB searchSQL:@"select * from EIS_UUID" Class:[TPDBUUID class] callback:^(NSArray *results) {
        resultArray = results;
    }];
    if (resultArray.count == 0) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        TPDBUUID *uuidBO = [[TPDBUUID alloc] init];
        uuidBO.CODE = @"1";
        uuidBO.UUID = result;
        [DB insertToDB:uuidBO];
        return result;
    }else {
        TPDBUUID *uuidBO = resultArray[0];
        return [uuidBO valueForKey:@"UUID"];;
    }
}

//保存的用户名
- (NSString*) userName {
	return [defaults objectForKey:@"userName"];
}
- (void) setUserName:(NSString*)username {
    if (nil == username) {
        [defaults removeObjectForKey:@"userName"];
    } else {
        [defaults setObject:username forKey:@"userName"];
    }
	[defaults synchronize];
}

- (BOOL)isHasInApp {
    return [[defaults objectForKey:@"isHasInApp"] boolValue];
}

- (void)setIsHasInApp:(BOOL)_isHasInApp {
    [defaults setObject:@(_isHasInApp) forKey:@"isHasInApp"];
	[defaults synchronize];
}

- (NSNumber *)pdfLength {
    return [defaults objectForKey:@"pdfLength"];
}

- (void)setPdfLength:(NSNumber *)_pdfLength {
    [defaults setObject:_pdfLength forKey:@"pdfLength"];
	[defaults synchronize];
}

- (NSNumber *)wxpdfLength {
    return [defaults objectForKey:@"wxpdfLength"];
}

- (void)setWxpdfLength:(NSNumber *)_wxpdfLength {
    [defaults setObject:_wxpdfLength forKey:@"wxpdfLength"];
	[defaults synchronize];
}

// 存取用户消息推送的会话令牌
- (NSString*) deviceToken {
	return [defaults objectForKey:@"deviceToken"];
}
- (void) setDeviceToken:(NSString *)deviceToken {
	[defaults setObject:deviceToken forKey:@"deviceToken"];
	[defaults synchronize];
}

@end
