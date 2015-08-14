//
//  TPLRemoteInterfaceURL.h
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-4-23.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

//@{接口地址URL定义
//登录接口
UIKIT_EXTERN NSString *const URL_sqliteSynch;

//登录接口
UIKIT_EXTERN NSString *const URL_login;
//心跳检测接口
UIKIT_EXTERN NSString *const URL_heartRate;
//客户判断
UIKIT_EXTERN NSString *const URL_isAgentAgent;

// 修改密码
UIKIT_EXTERN NSString *const URL_modifyPwd;

//@{报表
// 报表查询
UIKIT_EXTERN NSString *const URL_report;
//@}

//@{
// 会议信息查询
UIKIT_EXTERN NSString *const URL_meetingList;

// 会议详情
UIKIT_EXTERN NSString *const URL_meetingDetail;

// 下载头像附件
UIKIT_EXTERN NSString *const URL_downFile;

// 主持人/组织人信息
UIKIT_EXTERN NSString *const URL_moderatorInfo;

// 会议报名
UIKIT_EXTERN NSString *const URL_meetRegist;

// 会议签到
UIKIT_EXTERN NSString *const URL_meetSign;

// 查询审批会议列表
UIKIT_EXTERN NSString *const URL_meetingApprove;

// 会议审批
UIKIT_EXTERN NSString *const URL_approvalInfo;

// 会议材料列表
UIKIT_EXTERN NSString *const URL_meetingRecource;

// 下载PDF附件
UIKIT_EXTERN NSString *const URL_resourceFile;

// 机构部组
UIKIT_EXTERN NSString *const URL_orgPath;

// 大小类字典查询
UIKIT_EXTERN NSString *const URL_categories;

// 机构访问权限
UIKIT_EXTERN NSString *const URL_validSmpkey;
//@}

/////////////////////////////////////////////////////////////
// 获取广播消息
UIKIT_EXTERN NSString *const URL_getNotificationMessages;
// 获取个人消息
UIKIT_EXTERN NSString *const URL_getSelfMessage;
// 获取所有消息
UIKIT_EXTERN NSString *const URL_getAllMessages;
// 更新个人消息表中的消息接收时间
UIKIT_EXTERN NSString *const URL_refreshSelfMessageTime;
//删除单个消息
UIKIT_EXTERN NSString *const URL_delOneMsg;
//批量删除消息
UIKIT_EXTERN NSString *const URL_delAllMsg;
//@}

