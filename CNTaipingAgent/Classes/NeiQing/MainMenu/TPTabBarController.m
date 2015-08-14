//
//  TPLTabBarController.m
//  CNTaiPingRenewal
//
//  Created by 崔玉国 on 13-8-15.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "TPTabBarController.h"
#import "TPLoginViewController.h"

#define TOPPosy 40

@interface TPTabBarController ()<
CYGToolBarDelegate
>{
    NSMutableArray *items;
    
    UIImageView *statusBar;
    BOOL isShowing;
}
@property(nonatomic, strong)UIView          *contentView;
@property(nonatomic, strong)UIView          *maskView;
@property(nonatomic, strong)NSMutableArray  *viewControllers;
@property(nonatomic, assign)NSInteger       selectedIndex;
@end

@implementation TPTabBarController
@synthesize tabBar;
@synthesize maskView;
@synthesize contentView;
@synthesize viewControllers;
@synthesize selectedIndex;

- (CYGToolBarButtonItem*) item:(NSString*)bkImage  image:(NSString *)highlitedBKImage
{
    CYGToolBarButtonItem *item = [[CYGToolBarButtonItem alloc] init];
    item.bkImage = Image(bkImage);
    item.highlitedBKImage = Image(highlitedBKImage);
    item.dispWidth = 70;
    item.dispHeight = 50;
    item.disableWhileClicked = YES;
    return item;
}

- (CYGToolBarLabelItem*) itemLabel:(NSString*)bk{
    CYGToolBarLabelItem *item = [[CYGToolBarLabelItem alloc] init];
    item.dispWidth = 285;
    return item;
}

- (void) dealloc {
    NotificationRemoveObserver(self, NotificationMsg_setTopButtonStatus);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    statusBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, TOPPosy)];
    statusBar.image = Image(@"toolbar/top.png");
    statusBar.userInteractionEnabled = YES;
    statusBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 2, 70, TOPPosy);
    [button setBackgroundImage:Image(@"toolbar/list.png") forState:UIControlStateNormal];
    [button setBackgroundImage:Image(@"toolbar/list_s.png") forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showItemsButton) forControlEvents:UIControlEventTouchUpInside];
    [statusBar addSubview:button];
    
    /* 登陆用户头像 */
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width-180, 0, TOPPosy, TOPPosy)];
    headImg.backgroundColor = [UIColor redColor];
    [statusBar addSubview:headImg];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(headImg.right+10, 0, TOPPosy, TOPPosy);
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(onButton1Event) forControlEvents:UIControlEventTouchUpInside];
    [statusBar addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(button1.right+10, 0, TOPPosy, TOPPosy);
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(onButton2Event) forControlEvents:UIControlEventTouchUpInside];
    [statusBar addSubview:button2];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    tabBar = [[CYGToolBar alloc] init];
    tabBar.frame = CGRectMake(-69, TOPPosy, 69, self.view.height-TOPPosy);
    tabBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    tabBar.delegate = self;
    tabBar.image = [Image(@"toolbar/itemback.png") stretch];
    
    
    viewControllers = [NSMutableArray array];
    items = [NSMutableArray array];
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        CYGToolBarButtonItem *item = [self item:@"maintabbar/menhu.png" image:@"maintabbar/menhu_s.png"];
        item.disableWhileClicked = NO;
        [items addObject:item];
        [viewControllers addObject:@"TPActivityHomeController"];
    }

    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        [items addObject:[self item:@"maintabbar/fenxi.png"
                              image:@"maintabbar/fenxi_s.png"]];
        [viewControllers addObject:@"TPActivityHomeController"];
    }
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        [items addObject:[self item:@"maintabbar/shujia.png"
                              image:@"maintabbar/shujia_s.png"]];
        [viewControllers addObject:@"TPViewController"];
    }
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        [items addObject:[self item:@"maintabbar/guihua.png"
                              image:@"maintabbar/guihua_s.png"]];
        [viewControllers addObject:@"TPViewController"];
    }
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        [items addObject:[self item:@"maintabbar/jianyishu.png"
                              image:@"maintabbar/jianyishu_s.png"]];
        [viewControllers addObject:@"TPViewController"];
    }
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        CYGToolBarButtonItem *item = [self item:@"maintabbar/toubao.png"
                                          image:@"maintabbar/toubao_s.png"];
        item.disableWhileClicked = NO;
        [items addObject:item];
        [viewControllers addObject:@"TPViewController"];
    }
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        [items addObject:[self item:@"maintabbar/tp.png"
                              image:@"maintabbar/tp_s.png"]];
        [viewControllers addObject:@"TPViewController"];
    }
    
    if ([TPAuthManagement hasAuth:MenuUrl_Message])
    {
        [items addObject:[self item:@"maintabbar/shezhi.png"
                              image:@"maintabbar/shezhi_s.png"]];
        [viewControllers addObject:@"TPViewController"];
    }
    
    tabBar.items = items;
    tabBar.step = 25;
    tabBar.alignment = CYGToolBarAlignmentVerticalTop;
    tabBar.contentInsets = UIEdgeInsetsMake(20, 0, 5, 0);
    
    contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubviewTop:statusBar middleView:contentView bottomView:nil topHeight:TOPPosy bottomHeight:0];
    [self.view addSubview:tabBar];
    
    self.viewControllers = viewControllers;
    self.selectedIndex = self.selectedIndex;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMaskViewTapEvent)];
    tapRecognizer.numberOfTapsRequired = 1;
    self.maskView = [[UIImageView alloc] initWithFrame:CGRectMake(1024, TOPPosy, self.contentView.width-tabBar.width, self.contentView.height)];
    self.maskView.backgroundColor = [UIColor clearColor];
    self.maskView.autoresizingMask = self.contentView.autoresizingMask;
    self.maskView.userInteractionEnabled = YES;
    [self.maskView addGestureRecognizer:tapRecognizer];
    [self.view addSubview:self.maskView];
}

- (void)setTopStatus {
    self.tabBar.selectedIndex = self.selectedIndex+3;
}

+ (TPTabBarController *)controller {
	__autoreleasing TPTabBarController *tabBarController = [[TPTabBarController alloc] init];
    
    
	return tabBarController;
}

- (void)showItemsButton
{
    if (!isShowing)
    {
        [UIView animateWithDuration:.3 animations:^{
            CGRect frame = tabBar.frame;
            frame.origin.x = 0;
            tabBar.frame = frame;
            
            CGRect maskFrame = self.maskView.frame;
            maskFrame.origin.x = frame.size.width;
            self.maskView.frame = maskFrame;
            
            CGRect statusFrame = statusBar.frame;
            statusFrame.origin.x = frame.size.width;
            statusBar.frame = statusFrame;
            
            CGRect contentFrame = self.contentView.frame;
            contentFrame.origin.x = frame.size.width;
            self.contentView.frame = contentFrame;
            
        } completion:^(BOOL finished) {
            isShowing = YES;
        }];
    }else {
        [self onMaskViewTapEvent];
    }
}

- (void)onMaskViewTapEvent
{
    [UIView animateWithDuration:.3 animations:^{
        CGRect frame = tabBar.frame;
        frame.origin.x = -frame.size.width;
        tabBar.frame = frame;
        
        CGRect maskFrame = self.maskView.frame;
        maskFrame.origin.x = frame.size.width+maskFrame.size.width;
        self.maskView.frame = maskFrame;
        
        CGRect statusFrame = statusBar.frame;
        statusFrame.origin.x -= frame.size.width;
        statusBar.frame = statusFrame;
        
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.x -= frame.size.width;
        self.contentView.frame = contentFrame;
        
    } completion:^(BOOL finished) {
        isShowing = NO;
    }];
}

- (void) CYGToolBar:(CYGToolBar*)toolbar clickIndex:(int)index {
    
    if (index != selectedIndex) {
        self.selectedIndex = index;
    }
    
    [self onMaskViewTapEvent];
}

- (void) setSelectedIndex:(NSInteger)index {
    selectedIndex = index;
    [self.contentView removeAllSubviews];
    id objVC = self.viewControllers[index];
    if ([objVC isKindOfClass:[NSString class]])
    {
        TPNavigationController *naviController = [[TPNavigationController alloc]
                                                  initWithRootViewController:[[NSClassFromString(objVC) alloc]initWithMsgKey:objVC] dragPopStyle:UINavigationControllerDragPopStyleNone];
        self.viewControllers[index] = naviController;
    }
    
    UIView *newView = ((UIViewController *)self.viewControllers[index]).view;
    newView.frame = self.contentView.bounds;
    newView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:newView];
}

- (void)onButton1Event
{
    
}

- (void)onButton2Event
{
    
}
@end
