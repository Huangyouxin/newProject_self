//
//  TPResourceFileBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-10.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPRemoteBO.h"

@interface TPResourceFileBO : TPRemoteBO

// 附件ID
@property (nonatomic, strong) NSNumber *sourceFileId;
// 附件完成名称
@property (nonatomic, copy) NSString *name;
// 附件大小
@property (nonatomic, strong) NSNumber *fileSize;
// 下载数据流的开始下标
@property (nonatomic, strong) NSNumber *startIndex;
// 附件内容
@property (nonatomic, strong) NSData *fileContent;
// 下载数据流的大小
@property (nonatomic, strong) NSNumber *downLoadSize;
@end
