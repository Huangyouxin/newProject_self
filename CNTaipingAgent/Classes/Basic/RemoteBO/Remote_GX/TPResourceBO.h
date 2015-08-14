//
//  TPResourceBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-10.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPRemoteBO.h"

@interface TPResourceBO : TPRemoteBO

// 资源ID
@property (nonatomic, strong) NSNumber *resourceId;
// 所关联会议议程ID
@property (nonatomic, strong) NSNumber *meetAgendaId;
// 资源名称
@property (nonatomic, copy) NSString *resourceName;
@end
