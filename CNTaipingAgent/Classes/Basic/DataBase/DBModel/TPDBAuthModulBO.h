//
//  TPDBAuthModulBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-29.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

// 消息
UIKIT_EXTERN NSString *const MenuUrl_Message;
// 会议
UIKIT_EXTERN NSString *const MenuUrl_Meeting;
// 报表
UIKIT_EXTERN NSString *const MenuUrl_Report;

// 参与会议
UIKIT_EXTERN NSString *const MenuUrl_AttMeeting;
// 审批会议
UIKIT_EXTERN NSString *const MenuUrl_SMeeting;

@interface TPDBAuthModulBO : LKModelBase
@property(nonatomic, strong) NSString *name;
//是否是叶子节点
@property(nonatomic, strong) NSString *leaf;
//节点等级
@property(nonatomic, assign) int level;
//模块id
@property(nonatomic, assign) long moduleId;
@property(nonatomic, strong) NSString *moduleName;
@property(nonatomic, assign) long parentId;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, assign) int listOrder;

//@property(nonatomic, assign) int checked;

//配置游客权限
+ (NSArray *) visitorAuthModuls;
@end

@interface TPAuthManagement : NSObject
+ (BOOL) hasAuth:(NSString *)url;
@end
