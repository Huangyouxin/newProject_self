//
//  TPMeetingAgendaBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

/*
 * 会议议程
 */

#import <UIKit/UIKit.h>

@interface TPMeetingAgendaBO : TPRemoteBO
// 会议议程ID
@property (nonatomic, strong) NSNumber *Id;
// 议程日期
@property (nonatomic, strong) NSDate *agendaDt;
// 开始时间
@property (nonatomic, copy) NSString *startDt;
// 结束时间
@property (nonatomic, copy) NSString *endDt;
// 主讲人
@property (nonatomic, copy) NSString *speakerName;
// 会议板块
@property (nonatomic, copy) NSString *meetEdition;
// 是否主讲
@property (nonatomic, copy) NSString *isSpeaker;
@end





