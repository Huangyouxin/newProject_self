//
//  TPRemoteProtocol.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//


#import "TPRemote.h"


@protocol TPRemoteProtocol <NSObject>
- (void)synchSqliteManager:(NSString*)jsonParameter;

//登录接口(login)
- (TPIPISUserExt*) userlogin:(NSString*) userName password:(NSString*)password;

//版本校验
- (NSDictionary*)getLastVersionId:(NSString*)appType isIosApp:(NSString*)isIosApp isIosSevenOne:(NSString*)isIosSevenOne;

//心跳检测接口
- (void) updateUserExtActiveTime:(NSString*)userName heartTime:(NSString*)heartTime activeTime:(NSString*)ativeTime;
//////////////////////////////////////////////////////////////////////////////////////////
/* 报表 */
// 报表查询
- (NSArray *) queryReport:(NSArray *)userId org:(NSString *)orgId time:(NSString *)timeType date:(NSString *)dateTime level:(NSString *)orgLevel;

// 报表详情查询
- (NSArray *) queryReportDetail:(NSString *)reportType org:(NSString *)orgId time:(NSString *)timeType date:(NSString *)dateTime level:(NSString *)orgLevel customer:(NSString *)userId productId:(NSString *)productId;

// 报表下钻查询
- (NSArray *) queryReportDown:(NSString *)reportType org:(NSString *)orgId time:(NSString *)timeType date:(NSString *)dateTime level:(NSString *)orgLevel customer:(NSString *)userId subOrg:(NSString *)orgId2;

// 自定义字段查询
- (NSArray *)getReportFieldList:(NSString *)userId report:(NSString *)reportId time:(NSString *)timeType organ:(NSString *)organId;

// 自定义字段保存
- (NSArray *)saveReportFieldList:(NSString *)uerId list:(NSArray *)list report:(NSString *)reportId time:(NSString *)timeType organ:(NSString *)organId;

// 快速查询
- (NSArray *)quickSearch:(NSString *)userId org:(NSString *)orgId level:(NSString *)orgLevel category:(NSString *)category beingDate:(NSString *)date1 endDate:(NSString *)date2 product:(NSString *)productId;

// 主打产品查询
- (NSArray *)getMainProduct:(NSDate *)date;


//////////////////////////////////////////////////////////////////////////////////////////
// 会议信息查询
- (NSArray *)findMeetInfoListByParams:(NSString *)userName map:(NSDictionary *)dict pageInfo:(TPPageInfoBO *)info;

// 会议详情
- (NSArray *)findMeetInfoDetailByMeetId:(NSString *)userName meetingId:(NSNumber *)Id;

// 下载头像附件
- (NSArray *)getFileByParms:(NSString *)userName fileId:(NSNumber *)fileId;

// 主持人/组织人信息
- (NSArray *)getModeratorInfoByParms:(NSString *)userName userId:(NSNumber *)Id;

// 查询会议列表
- (NSArray *)findMeetInfoListByParams:(NSString *)userName pageInfo:(TPPageInfoBO *)info map:(NSDictionary *)dict;

// 会议报名
- (NSArray *)meetRegistByParams:(NSString *)userName meetingId:(NSNumber *)Id customerId:(NSNumber *)Id2;

// 会议签到
- (NSArray *)updateSignByParams:(NSString *)userName meetId:(NSNumber *)meetId customerId:(NSNumber *)customerId meetType:(NSNumber *)meetType singType:(NSString *)signinType;

// 查询审批会议列表
- (NSArray *)findMeetingApproveByParms:(NSString *)userName dict:(NSDictionary *)dict pageInfo:(TPPageInfoBO *)info;

// 会议审批
- (NSArray *)getApprovalInfo:(NSString *)userName userId:(NSString *)Id dict:(NSDictionary *)dict;

// 会议材料列表
- (NSArray *)findResourceTypeByCode:(NSString *)userName meetingAgendaId:(NSString *)Id sourceType:(NSString *)sourceType;

// 下载PDF附件
- (NSArray *)findResourceFileByCode:(NSString *)userName resourceId:(NSString *)Id startIndex:(NSNumber *)startIndex size:(NSNumber *)size;

// 机构部组
- (NSArray *)findOrgPathPagelist:(NSString *)userName orgId:(NSString *)orgid;

// 大小类字典查询
- (NSArray *)findCategoriesByCode:(NSString *)userName cvalue:(NSString *)cvalue;

// 机构访问权限
- (NSArray *)validSmpkey:(NSString *)userName;

// 获取广播消息
- (id)loadNoticeBoardJSON:(NSNumber *)ptid recvOrgan:(NSNumber *)recvOrgan  recvChannel:(NSNumber *)recvChannel;
// 获取个人消息
- (id)loadNoticeIndividJSON:(NSNumber *)sendTimeIndivid recvUser:(NSString *)recvUser ptid:(NSNumber *)ptid;
// 更新个人消息表中的消息接收时间
- (id)updateRecvTimeJASON:(NSString *)ids;
// 删除单个消息
- (id)deleteNotice:(NSString *)type noticeId:(NSString*)noticeId;
// 批量删除消息
- (id)batchDeleteNoticeJASON:(NSString *)type rowsToUpdate:(NSString*)rowsToUpdate;
@end




































