//
//  NCBPreviewController.m
//  NCBPadApp
//
//  Created by 崔玉国 on 13-9-16.
//  Copyright (c) 2013年 NCB. All rights reserved.
//

#import "NCBPreviewController.h"

@interface CustomPreviewItem : NSObject<QLPreviewItem>
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *title;
@end

@implementation CustomPreviewItem

- (NSURL *)previewItemURL {
    return self.URL;
}

- (NSString *)previewItemTitle {
    return self.title;
}

@end



@interface NCBPreviewController ()<QLPreviewControllerDataSource, QLPreviewControllerDelegate>
@property(nonatomic, strong) CustomPreviewItem *previewItem;
@end

@implementation NCBPreviewController

@synthesize previewItem;

- (id)initWithPath:(NSString*)path title:(NSString *)title {
    if (self = [super init]) {
        previewItem = [[CustomPreviewItem alloc] init];
        previewItem.URL = [NSURL fileURLWithPath:path];
        previewItem.title = title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.dataSource = self;
    self.delegate = self;
    
}

//-------iOS6以后已不起作用
- (UINavigationBar*)getNavigationBarFromView:(UIView *)view {
    // Find the QL Navigationbar
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[UINavigationBar class]]) {
            return (UINavigationBar *)v;
        } else {
            UINavigationBar *navigationBar = [self getNavigationBarFromView:v];
            if (navigationBar) {
                return navigationBar;
            }
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar* qlNavigationBar = [self getNavigationBarFromView:self.view];
    
    [qlNavigationBar.items enumerateObjectsUsingBlock:^(UINavigationItem* obj, NSUInteger idx, BOOL *stop) {
        obj.rightBarButtonItem = nil;
    }];
    [[self navigationItem] setRightBarButtonItem:nil];
}
//-----------------------

/**
 *	@brief	是否可以横竖屏切换
 *
 *	@param 	interfaceOrientation 	将要切换到的屏幕状态
 *
 *	@return	YES：可以切换，NO：不可以切换
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [UIApplication sharedApplication].statusBarOrientation;
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}


#pragma mark - QLPreviewControllerDataSource

// Returns the number of items that the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController {
    return 1;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx {
    return previewItem;
}

@end
