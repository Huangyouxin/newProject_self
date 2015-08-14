//
//  TPItemBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-20.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <HessianKit/HessianKit.h>

@interface TPItemBO : CWValueObject

// 自定义字段code
@property (nonatomic, strong) NSString *field;
// 自定义字段名称
@property (nonatomic, strong) NSString *fieldName;
// 是否被选中 0－未选中；1-已选中
@property (nonatomic, strong) NSString *isSelected;
@end
