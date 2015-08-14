//
//  TPViewController.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (ANAdvancedNavigationControllerNormal)
- (UIViewController*)vcNormal;
@end

/**
 *	@brief	工程级页面基类，整个工程内页面都是由此派生
 *   提供最基类的一些公用方法
 */
@interface TPViewController : UIViewController
@property(nonatomic, strong)UIViewController* rootViewController;
@property(nonatomic, strong, readonly)UIButton *backButton;
//不需要提示
@property(nonatomic, assign)BOOL  noneTipShow;


@property(nonatomic, strong, readonly)NSString*     msgKey;
@property(nonatomic, strong) NSString*     superMsgKey;
@property(nonatomic, strong, readonly)UIImageView*  backgroundView;

//@{如页面需要在左侧有搜索，则必须重写这两个属性的方法
@property(nonatomic, readonly)BOOL  userParentSearchView;
@property(nonatomic, readonly)NSString*  searchViewControllerClassName;
@property(nonatomic, readonly)NSString*  searchViewMsgKey;
//- (void) onSearchKeyMessage:(NSNotification *)notification;
//@}

//本页面自己监听的消息，其他页面可以针对于此key来发消息给本页面
- (id) initWithMsgKey:(NSString*)msgKey;
//本页面不监听此消息，但是本页面有可能通过此key回传消息给上级页面
- (id) initWithSuperMsgKey:(NSString*)superMsgKey;



//@{子页面需要实现的相应函数
//- (void) onInterfaceKeyMessage:(NSNotification *)notification;
//@}
@end
