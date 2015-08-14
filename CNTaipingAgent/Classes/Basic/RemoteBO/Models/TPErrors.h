//
//  TPErrors.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-12.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <HessianKit/HessianKit.h>

/**
 *	@brief	错误信息BO
 errCode前后台定义的错误编码
 1、	值为0时，无错误，正常使用resultObj
 2、	值为-1时，无错误，正常使用resultObj，但客户端需要展示message信息，比如“保存成功”
 3、	值为<-1的数，此为一些前后台定义的一些错误情况，客户端需按照约定的来做相应处理。
 4、	值为>0的数，此为服务器端非约定的异常错误，客户端和服务器端可以通过此信息进行调试。
 */
//错误收集BO
@interface TPErrors : CWValueObject
//错误代码
@property(nonatomic, assign) int errCode;
//异常信息
@property(nonatomic, strong) NSString *errDesc;
//错误信息
@property(nonatomic, strong) NSString *message;
@end
