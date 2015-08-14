//
//  GXEISNoticeBO.m
//  CNTaiPingAgent
//
//  Created by Eric on 14-3-20.
//  Copyright (c) 2014年 Tai Ping. All rights reserved.
//

#import "TPEISNoticeBO.h"

@implementation TPEISNoticeBO

@synthesize  noticeId;// 广播消息ID
@synthesize  noticeCate;// 消息类别
@synthesize  noticeSource;// 目标平台编码 个险124
@synthesize  noticeTitle;// 消息主题
@synthesize  noticeContent;// 消息内容
@synthesize  noticeDesc;// 消息说明
@synthesize  bgnTime;// 广播开始时间
@synthesize  endTime;// 广播结束时间
@synthesize  sendUser;// 发送人员
@synthesize  sendTime;// 发送时间
@synthesize  recvOrgan;// 接收机构
@synthesize  recvBranch;// 接收下属机构
@synthesize  recvChannel;// 接收渠道
@synthesize  recvUser;// 接收人员
@synthesize  recvTime;// 接收时间
@synthesize  remark;//备份
@synthesize  operateType;//请求类型 1-新建;2-撤销;3-阅读
@synthesize  rawSeqId;//发送流水
@synthesize  sendUserCate;//发送人类型 104-太平人寿个险代理人、内勤
@synthesize  recvUserCate;//接收人类型 104-太平人寿个险代理人、内勤
@synthesize  scheduleSendTime;//指定接收时间
@synthesize  sendUserName;
@synthesize  recvUserName;

@end
