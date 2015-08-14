//
//  TPDBAuthModulBO.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-29.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPDBAuthModulBO.h"

// 消息
NSString *const MenuUrl_Message = @"com.eagent.xx";
// 会议
NSString *const MenuUrl_Meeting = @"com.eagent.mt";
// 报表
NSString *const MenuUrl_Report = @"com.eagent.bb";

// 参与会议
NSString *const MenuUrl_AttMeeting = @"com.eagent.mt.mt";
// 审批会议
NSString *const MenuUrl_SMeeting = @"com.eagent.mt.sp";

@implementation TPDBAuthModulBO
@synthesize name;
@synthesize leaf;
@synthesize level;
@synthesize moduleId;
@synthesize moduleName;
@synthesize parentId;
@synthesize url;
@synthesize listOrder;

+ (NSArray *) visitorAuthModuls {
    NSMutableArray *list = [NSMutableArray array];
    
    return list;
}
@end

@implementation TPAuthManagement
+ (BOOL) hasAuth:(NSString *)url {
    __block BOOL hasAuth = FALSE;
    [DB searchWhere:@{@"url": url, @"name":[TPUserDefaults instance].userName} orderBy:nil offset:0 count:100000 Class:[TPDBAuthModulBO class] callback:^(NSArray *result) {
        hasAuth = (result.count == 1);
    }];
    return hasAuth;
}

@end
