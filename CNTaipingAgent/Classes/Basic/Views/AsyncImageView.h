//
//  AsyncImageView.h
//  CNTaiPingRenewal
//
//  Created by cuiyuguo on 11-9-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>




@class AsyncImageView;
@protocol AsyncImageViewDelegate<NSObject>
@optional
- (void) asyncImageView:(AsyncImageView*)imageView downloadSucceed:(id)fileData;
- (void) asyncImageView:(AsyncImageView*)imageView downloadFailed:(NSString*)failedMsg;
- (void) asyncImageViewOnTouched:(AsyncImageView*)imageView;
@end




@interface AsyncImageView : UIView<TPRemoteDelegate>
@property(nonatomic, strong)UIImage*       defaultImage;
@property(nonatomic, weak)id<AsyncImageViewDelegate> delegate;

//数据模型内的数据字段
+ (void)setImageDataField:(NSString*)fieldName;

- (void)setImage:(NSString*)fileName
            type:(NSString*)requestType
   interfaceType:(RemoteInterfaceType)interfaceType
      requestUrl:(NSString*)requestUrl
       parameter:(id)parameter,...;
@end
