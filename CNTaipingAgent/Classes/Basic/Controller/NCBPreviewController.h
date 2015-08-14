//
//  NCBPreviewController.h
//  NCBPadApp
//
//  Created by 崔玉国 on 13-9-16.
//  Copyright (c) 2013年 NCB. All rights reserved.
//

#import <QuickLook/QuickLook.h>

@interface NCBPreviewController : QLPreviewController

- (id)initWithPath:(NSString*)filePath title:(NSString *)title;

@end
