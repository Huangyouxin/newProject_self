//
//  TPPageInfo.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

@interface TPPageInfoBO : CWValueObject
// 总数据量
@property(nonatomic,strong)NSNumber *totalCount;
// 总页数,客户端扩展的
@property(nonatomic,readonly)int totlePage;
// 当前页数,从1开始
@property(nonatomic,strong)NSNumber *currentPageIndex;
// 每页大小，默认10条
@property(nonatomic,strong)NSNumber *pageSize;

@end
