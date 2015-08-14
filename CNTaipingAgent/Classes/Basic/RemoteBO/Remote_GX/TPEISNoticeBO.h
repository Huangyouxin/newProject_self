//
//  GXEISNoticeBO.h
//  CNTaiPingAgent
//
//  Created by Eric on 14-3-20.
//  Copyright (c) 2014年 Tai Ping. All rights reserved.
//

#import <HessianKit/HessianKit.h>

@interface TPEISNoticeBO : CWValueObject

@property (nonatomic,strong) NSNumber* noticeId;// 广播消息ID
@property (nonatomic,strong) NSNumber* noticeCate;// 消息类别
@property (nonatomic,strong) NSNumber* noticeSource;// 目标平台编码 个险124
@property (nonatomic,strong) NSString* noticeTitle;// 消息主题
@property (nonatomic,strong) NSString* noticeContent;// 消息内容
@property (nonatomic,strong) NSString* noticeDesc;// 消息说明
@property (nonatomic,strong) NSDate* bgnTime;// 广播开始时间
@property (nonatomic,strong) NSDate* endTime;// 广播结束时间
@property (nonatomic,strong) NSString* sendUser;// 发送人员
@property (nonatomic,strong) NSDate* sendTime;// 发送时间
@property (nonatomic,strong) NSNumber* recvOrgan;// 接收机构
@property (nonatomic,strong) NSNumber* recvBranch;// 接收下属机构
@property (nonatomic,strong) NSNumber* recvChannel;// 接收渠道
@property (nonatomic,strong) NSString* recvUser;// 接收人员
@property (nonatomic,strong) NSDate* recvTime;// 接收时间
@property (nonatomic,strong) NSString* remark;//备份
@property (nonatomic,strong) NSString* operateType;//请求类型 1-新建;2-撤销;3-阅读
@property (nonatomic,strong) NSString* rawSeqId;//发送流水
@property (nonatomic,strong) NSString* sendUserCate;//发送人类型 104-太平人寿个险代理人、内勤
@property (nonatomic,strong) NSString* recvUserCate;//接收人类型 104-太平人寿个险代理人、内勤
@property (nonatomic,strong) NSDate* scheduleSendTime;//指定接收时间
@property (nonatomic,strong) NSString* sendUserName;
@property (nonatomic,strong) NSString* recvUserName;

@end
