//
//  TPErrorManager.m
//  Pension
//
//  Created by 崔玉国 on 14-4-22.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//


#import "TPErrorManager.h"

@implementation TPErrorManager


+ (NSString*) parseErrorMsg:(int)errorcode {
    switch (errorcode) {
        case 10001:
            return @"不允许该设备登录！";
        case 20001:
            return @"当前版本不是最新，请升级APP！";
        case 20002:
            return @"版本信息不合法！";
        case 30001:
            return @"客户管理平台对用户验证请求无响应！";
        case 30002:
            return @"对不起，您没有跨站访问权限！";
        case 30003:
            return @"对不起，用户名或密码缺失。请重新登录！";
        case 30004:
            return @"对不起，您的账号已经失效，该账户被锁定,请找管理员解锁！";
        case 30005:
            return @"对不起，您的密码输错次数超过系统允许的出错次数，账号被锁定！";
        case 30006: {
            NotificationPost(NotificationMsg_POPUP_MODIFY_PASSWORD, @"Y", nil);
            return @"对不起，您需要修改初始密码！";
        }
        case 30007: {
            NotificationPost(NotificationMsg_POPUP_MODIFY_PASSWORD, @"N", nil);
            return @"对不起，您需要修改密码！";
        }
        case 30008:
            return @"对不起，您的密码已重置，请登录奔驰系统修改密码后登录！";
        case 30009:
            return @"对不起，用户名或密码错误。请重新登录！";
        case 30010:
            return @"对不起，您没有登录或登录信息丢失。请重新登录！";
        case 30011:
            return @"对不起，您没有访问权限！";
        case 30012:
            return @"对不起，权限验证异常！";
        case 30021:
            return @"没有此用户！";
        case 30022:
            return @"原密码输入错误！";
        case 30023:
            return @"新密码不能与原密码一样！";
        case 30024:
            return @"密码修改失败！";
        case 30025:
            return @"密码长度错误！";
        case 30026:
            return @"密码必须包含大写字母，小写字母，数字，特殊字符四项中的三项！";
        case 40001: {
            NSString* message = @"您的账号已在另一处登录，此处登录信息强制退出！";
            NotificationPost(NotificationMsg_POPUP_LOGIN, message, nil);
            return nil;
        }
        case 40002: {
            NSString* message = @"连接超时，请重新登录！";
            NotificationPost(NotificationMsg_POPUP_LOGIN, message, nil);
            return nil;
        }
        case 88888:
            return @"后台接口无应答！";
        default://99999
            return @"网络异常";//nil
    }
}

+ (BOOL) parseRemoteBOErrorMsg:(TPErrors*)error {
    if (error.errCode == 1) {
        ShowMessage(error.message, nil);
    }
    return YES;
}
@end
