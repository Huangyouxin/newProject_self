//
//  TPResultBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

/**
 *	@brief	所有接口返回的总数据模型，真正的数据在item里，
 *          如果接口返回错误，会放置在error下
 *          如果接口返回的是列表数据，有分页信息会放置在pageinfo下
 */
@interface TPResultBO : CWValueObject
@property(nonatomic, strong) TPErrors *error;
@property(nonatomic, strong) TPPageInfoBO *pageInfo;
@property(nonatomic, strong) NSObject * resultObj;
@end
