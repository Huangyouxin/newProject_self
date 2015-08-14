//
//  TPDBNoticeBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14/10/30.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

@interface TPDBNoticeBO : LKModelBase

@property (nonatomic,strong) NSString *NOTICE_TYPE;//1  个人信息   2  广播信息
@property (nonatomic,strong) NSString *NOTICE_ID;
@property (nonatomic,strong) NSString *NOTICE_CATE;
@property (nonatomic,strong) NSString *NOTICE_SOURCE;
@property (nonatomic,strong) NSString *NOTICE_TITLE;
@property (nonatomic,strong) NSString *NOTICE_CONTENT;
@property (nonatomic,strong) NSString *NOTICE_DESC;//消息说明
@property (nonatomic,strong) NSString *BGN_TIME;
@property (nonatomic,strong) NSString *END_TIME;
@property (nonatomic,strong) NSString *SEND_USER;
@property (nonatomic,strong) NSString *SEND_TIME;
@property (nonatomic,strong) NSString *RECV_ORGAN;
@property (nonatomic,strong) NSString *RECV_BRANCH;
@property (nonatomic,strong) NSString *RECV_CHANNEL;
@property (nonatomic,strong) NSString *NOTICE_STATUS; //1 未阅读  2 已读
@property (nonatomic,strong) NSString *RECV_USER;//:接收人员
@property (nonatomic,strong) NSString *RECV_TIME;//接收时间

//OPERATE_TYPE  请求类型 1-新建;2-撤销;3-阅读
@property (nonatomic,strong) NSString *OPERATE_TYPE;
//RAW_SEQ_ID 发送流水
@property (nonatomic,strong) NSString *RAW_SEQ_ID;   //营销平台前缀带有YX
//RECV_USER_CATE 接收人类型
@property (nonatomic,strong) NSString *RECV_USER_CATE;
//SCHEDULE_SEND_TIME  指定接收时间
@property (nonatomic,strong) NSString *SCHEDULE_SEND_TIME;
//REMARK  备注
@property (nonatomic,strong) NSString *REMARK;
//SEND_USER_CATE 发送人类型
@property (nonatomic,strong) NSString *SEND_USER_CATE;
@property (nonatomic,strong) NSString *RECV_USER_NAME;
@property (nonatomic,strong) NSString *SEND_USER_NAME;

@end
