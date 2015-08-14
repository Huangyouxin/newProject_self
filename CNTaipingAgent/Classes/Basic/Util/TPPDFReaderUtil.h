//
//  TPPDFReaderUtil.h
//  CNTaipingAgent
//
//  Created by Stone on 14/10/30.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPPDFReaderUtil : NSObject

+ (void)openPDFWithUIView:(UIView *)view withFilePath:(NSString *)filePath withTitle:(NSString *)title;
@end
