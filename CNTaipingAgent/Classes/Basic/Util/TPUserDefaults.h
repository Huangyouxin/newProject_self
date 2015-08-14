//
//  TPUserDefaults.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright 2014 CNTaiping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPPrecustomerBO.h"
#import "TPIPISUserExt.h"
#import "TPISAgentAgnetBO.h"
#import "TPIPISUserBO.h"

@interface TPUserDefaults : NSObject

//应用的名称
@property(strong, nonatomic, readonly)NSString*     appName;
@property(strong, nonatomic, readonly)NSString*     appVersion;

//换肤相关属性
//当前皮肤所在bundle名称
@property(nonatomic, strong) NSString*    skinBundle;
//导航栏、工具条的tintcolor
@property(strong, nonatomic, readonly) UIColor*   tintColor;
//用户登录时间戳
@property(nonatomic, assign)NSTimeInterval   loginTimestamp;
@property(nonatomic, assign)BOOL   newVersionCancel;
//用户名称，登录动作时保存
@property(nonatomic, strong)NSString*  userName;
//用户密码，登录动作时保存
@property(nonatomic, strong)NSString*  password;
//AUTH_TOKEN
@property(nonatomic, strong)NSString*  authToken;
//INTSERV_TOKEN
@property(strong, nonatomic)NSString*  intservToken;
//设备编码
@property(strong, nonatomic, readonly)NSString*  deviceIdentifier;
@property(strong, nonatomic, readonly)NSString*  macAddress;
@property(strong, nonatomic, readonly)NSString*  uuid;

//有新消息来了
@property(assign, nonatomic)BOOL  hasNewMsg;

@property(assign, nonatomic)BOOL  isFirstLogin;//登录的业务人员信息
@property (nonatomic, assign) int status_login;//登陆验证
@property (nonatomic, strong) TPIPISUserExt *loginUserBO;//登陆的客户信息
@property (nonatomic, strong) TPISAgentAgnetBO * isAgentBO;//登陆的客户判断

@property (nonatomic, strong) TPPrecustomerBO *selMsgCustomer;//从消息页面中选中的客户
@property (nonatomic, assign) BOOL selMessage;// 是否时从消息来得

@property (nonatomic, strong) NSMutableDictionary *filePath;   // 个人头像路径

@property (nonatomic, strong) TPOrgInfoBO * smpOrgInfoBO ;//访问权限
@property (nonatomic, strong) TPOrgInfoBO * userOrgInfoBO ;//用户机构信息

@property (nonatomic, strong) NSArray *orgArray;//能够访问的上级机构数组
@property (nonatomic, strong) NSArray *orgIdArray;//能够访问的上级机构数组

//应用间跳转，临时会话令牌
@property(nonatomic, copy)NSString* deviceToken;
//建议书pdf文件名
@property(nonatomic, copy)NSString* prodFileName;

@property(nonatomic, assign)BOOL onlyNote;

//对是否已经打开过APP
@property(nonatomic, assign)BOOL isHasInApp;

@property(nonatomic, strong)NSNumber* pdfLength;
@property(nonatomic, strong)NSNumber* wxpdfLength;

// 六张报表详细页面左侧查询是否需要展示主打产品
@property(nonatomic, copy)NSString *canShowProduct;

// 静态全局的改对象实例
+ (TPUserDefaults *)instance;

- (UIColor*) getColorByColorKey:(NSString*) colorKey;


@end
