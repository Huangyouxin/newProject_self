//
//  TPPDFReaderUtil.m
//  CNTaipingAgent
//
//  Created by Stone on 14/10/30.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPPDFReaderUtil.h"
#import "NCBPreviewController.h"
#import <PDFReader/PDFReader.h>

@implementation TPPDFReaderUtil

+ (void)openPDFWithUIView:(UIView *)view withFilePath:(NSString *)filePath withTitle:(NSString *)title {
    NCBPreviewController *previewController = [[NCBPreviewController alloc]initWithPath:filePath title:title];
    [((TPViewController*)view.viewController).rootViewController presentViewController:previewController animated:YES completion:nil];
}
@end
