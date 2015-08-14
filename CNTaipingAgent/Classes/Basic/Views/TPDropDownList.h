//
//  TPDropDownList.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-19.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

typedef enum {
    DropSelectOne,
    DropSelectMore
}DropSelectType;

#import "TPViewController.h"

@interface TPDropData : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isSelected;
@end

@interface TPDropDownList : UIView 

@property (nonatomic, assign) DropSelectType selectType;

@property (nonatomic, strong) NSArray *datas;
@end
