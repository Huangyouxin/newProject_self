//
//  AsyncImageView.m
//  tourpan
//
//  Created by cuiyuguo on 11-9-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsyncImageView.h"


@interface AsyncImageView() {
    UIImage*      image;
	UIImage*      defaultImage;
	id<AsyncImageViewDelegate> __weak delegate;
	NSString*     filePath;
}
@property(nonatomic, strong)UIImage*       image;
@property(nonatomic, readonly)NSString*    filePath;
@end


#define   ActivityIndicatorViewTag       -1111
static NSString *g_AsyncImageViewDataFieldName = nil;
@implementation AsyncImageView
@synthesize defaultImage, delegate, filePath;




- (UIImage*) image {
	return image;
}
- (void) setImage:(UIImage *)_image {
	image = _image;
    defaultImage = nil;
	[self setNeedsDisplay];
}

- (void) setDefaultImage:(UIImage*)_image {
	defaultImage = _image;
    image = nil;
	[self setNeedsDisplay];
}

- (id) init {
    if (self = [super init]) {
        [self setupComponent];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupComponent];
    }
    return self;
}
- (void) setupComponent {
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                        action:@selector(onTapGestureRecognizer:)];
    recognizer.delaysTouchesBegan = NO;
    [self addGestureRecognizer:recognizer];
    
    filePath = CachePath(nil);
    // Initialization code.
    self.contentMode = UIViewContentModeScaleToFill;
    self.backgroundColor = [UIColor clearColor];
    self.clearsContextBeforeDrawing = YES;
    
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.tag = ActivityIndicatorViewTag;
    [self addSubview:indicatorView];
    [self bringSubviewToFront:indicatorView];
}
- (void) awakeFromNib {
    [super awakeFromNib];
    [self setupComponent];
}

- (void) setDelegate:(id <AsyncImageViewDelegate>)delgat {
	self.userInteractionEnabled = nil != delgat;
	delegate = delgat;
}

+ (void)setImageDataField:(NSString*)fieldName {
    g_AsyncImageViewDataFieldName = fieldName;
}

- (void)setImage:(NSString*)fileName
            type:(NSString*)requestType
   interfaceType:(RemoteInterfaceType)interfaceType
      requestUrl:(NSString*)requestUrl
       parameter:(id)parameter,... {
    NSAssert(nil != g_AsyncImageViewDataFieldName, @"在网络数据请求前，请先调用setImageDataField:进行数据字段设置");
    NSAssert(fileName.length>0, @"文件名不能为空！");
    
    filePath = CachePath(fileName);
    if (ExistAtPath(filePath)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = [UIImage imageWithContentsOfFile:filePath];
        });
        return;
    }
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    if(nil != parameter) {
        [argsArray addObject:parameter];
        id arg;
        va_list argList;
        va_start(argList,parameter);
        while ((arg = va_arg(argList,id))) {
            if (nil != arg) {
                [argsArray addObject:arg];
            }
        }
        va_end(argList);
    }
    [[TPRemote instance] performSelector:@selector(doAction:type:interfaceType:requestUrl:parameter:delegate:)
                               withObject:@0 withObject:requestType withObject:@(interfaceType)
                               withObject:requestUrl withObject:argsArray withObject:self];
    
}



- (void) layoutSubviews {
	[super layoutSubviews];
	//将等待光标居中显示
    [self viewWithTag:ActivityIndicatorViewTag].frame =
    CGRectMake((self.width-24)/2, (self.height-24)/2, 24, 24);
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
    if (self.image) {
        [self.image drawInRect:rect contentMode:self.contentMode];
    } else if (self.defaultImage) {
        [self.defaultImage drawInRect:rect contentMode:self.contentMode];
    }
}

- (void) startWaitCursor:(int)actionTag {
	[((UIActivityIndicatorView*)[self viewWithTag:ActivityIndicatorViewTag]) startAnimating];
}

- (void) stopWaitCursor:(int)actionTag {
	[((UIActivityIndicatorView*)[self viewWithTag:ActivityIndicatorViewTag]) stopAnimating];
}

#pragma mark NetResponsDelegate
- (void) remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData {
    if (g_AsyncImageViewDataFieldName&&[responsData valueForKey:g_AsyncImageViewDataFieldName]) {
        NSData *imageData = [responsData valueForKey:g_AsyncImageViewDataFieldName];
        SaveFile(filePath, imageData);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *head = [[UIImage imageWithData:imageData] scaleToSize:CGSizeMake(self.width, self.height)];
            self.image = head;
        });
    }

    if ([self.delegate conformsToProtocol:@protocol(AsyncImageViewDelegate)] &&
		[self.delegate respondsToSelector:@selector(asyncImageView:downloadSucceed:)]) {
		[self.delegate asyncImageView:self downloadSucceed:responsData];
	}
}

- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message {
    if ([self.delegate conformsToProtocol:@protocol(AsyncImageViewDelegate)] &&
		[self.delegate respondsToSelector:@selector(asyncImageView:downloadFailed:)]) {
		[self.delegate asyncImageView:self downloadFailed:message];
	}
}

- (void) onTapGestureRecognizer:(UITapGestureRecognizer*)recognizer {
    if ([self.delegate conformsToProtocol:@protocol(AsyncImageViewDelegate)] &&
		[self.delegate respondsToSelector:@selector(asyncImageViewOnTouched:)]) {
        self.userInteractionEnabled = NO;
        [UIView animateWithDuration:.65 animations:^{
            self.alpha = .5;
        } completion:^(BOOL finished) {
            self.alpha = 1.0;
            self.userInteractionEnabled = YES;
            [self.delegate asyncImageViewOnTouched:self];
        }];
	}
}

@end
