//
//  TPAttachmentBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-9.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPRemoteBO.h"

@interface TPAttachmentBO : TPRemoteBO
// 附件ID
@property (nonatomic, strong) NSNumber *Id;
// 附件名称
@property (nonatomic, strong) NSString *fileName;
// 附件内容
@property (nonatomic, strong) NSData *fileContent;
@end
