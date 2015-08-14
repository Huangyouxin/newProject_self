//
//  TPLRemoteInterfaceURL.m
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-4-23.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//
#import "TPRemoteInterfaceURL.h"

//码表同步地址
NSString *const URL_sqliteSynch = @"";

//登录接口
NSString *const URL_login = @"mobile/login";

//心跳检测
NSString *const URL_heartRate = @"mobile/login";

//客户判断
NSString *const URL_isAgentAgent = @"mobile/login";

//修改密码
NSString *const URL_modifyPwd = @"mobile/login";


// 报表查询
NSString *const URL_report = @"mobile/servlet/hessian/com.life.webservice.hessian.HessianService";

// 会议信息查询
NSString *const URL_meetingList = @"mobile/servlet/hessian/meetInfo.service";

// 会议详情
NSString *const URL_meetingDetail = @"mobile/servlet/hessian/meetInfo.service";

// 下载头像附件
NSString *const URL_downFile = @"mobile/servlet/hessian/attachment.service";

// 主持人/组织人信息
NSString *const URL_moderatorInfo = @"mobile/servlet/hessian/person.service";

// 会议报名
NSString *const URL_meetRegist = @"mobile/servlet/hessian/meetPersonRegist.service";

// 会议签到
NSString *const URL_meetSign = @"mobile/servlet/hessian/meetInfo.service";

// 查询审批会议列表
 NSString *const URL_meetingApprove = @"mobile/servlet/hessian/approvalMeeting.service";

// 会议审批
NSString *const URL_approvalInfo = @"mobile/servlet/hessian/meetApprove.service";

// 会议材料列表
NSString *const URL_meetingRecource = @"mobile/servlet/hessian/meetResource.service";

// 下载PDF附件
NSString *const URL_resourceFile = @"mobile/servlet/hessian/meetResourceFile.service";

// 机构部组
NSString *const URL_orgPath = @"mobile/servlet/hessian/orgInfo.service";

// 大小类字典查询
NSString *const URL_categories = @"mobile/servlet/hessian/dictionaryInfo.service";

// 机构访问权限
NSString *const URL_validSmpkey = @"mobile/servlet/hessian/smpValidate.service";



// 获取广播消息
NSString *const URL_getNotificationMessages = @"mobile/servlet/hessian/com.cntaiping.intserv.datasync.NoticeAction";
// 获取个人消息
NSString *const URL_getSelfMessage = @"mobile/servlet/hessian/com.cntaiping.intserv.datasync.NoticeAction";
// 获取所有消息
NSString *const URL_getAllMessages = @"mobile/servlet/hessian/com.cntaiping.intserv.datasync.NoticeAction";
// 更新个人消息表中的消息接收时间
NSString *const URL_refreshSelfMessageTime = @"mobile/servlet/hessian/com.cntaiping.intserv.datasync.NoticeAction";
//删除单个消息
NSString *const URL_delOneMsg = @"mobile/servlet/hessian/com.cntaiping.intserv.datasync.NoticeAction";
//批量删除消息
NSString *const URL_delAllMsg = @"mobile/servlet/hessian/com.cntaiping.intserv.datasync.NoticeAction";
