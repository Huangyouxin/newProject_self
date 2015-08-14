//
//  CYGModelWindow.h
//  NCBPadApp
//
//  Created by cuiyuguo on 13-9-1.
//  Copyright 2013 NCB. All rights reserved.
//


//CYGModelWindow消息
UIKIT_EXTERN NSString *const NotificationMsg_ModelWindowConfirmed;
UIKIT_EXTERN NSString *const NotificationMsg_ModelWindowConceled;


@interface ModelWindowConfig : NSObject
@property(nonatomic, assign)CGFloat transHeight;
@property(nonatomic, assign)CGFloat headerHeight;
@property(nonatomic, assign)CGFloat footerHeight;
@property(nonatomic, assign)CGFloat contentWidth;
@property(nonatomic, strong)UIImage *contentBKImage;
@property(nonatomic, strong)UIColor *contentBlankBKColor;
@property(nonatomic, assign)CGFloat cornerRadius;
@property(nonatomic, assign)CGFloat rightStep;
@end
typedef void (^ModelWindowBlock)(id data);
@interface CYGModelWindow : UIView

/**
 *	@brief	CYGModelWindow通用配置
 *
 *	@param 	config 	配置信息
 */
+ (void) setConstantConfig:(ModelWindowConfig*)config;



/**
 *	@brief	弹出模态窗口
 * 特别说明：关闭模态窗口通过调用：
 *         NotificationPost(NotificationMsg_ModelWindowConfirmed, nil, data);
 *         NotificationPost(NotificationMsg_ModelWindowConceled, nil, data);
 *	@param 	viewController 	模态窗口
 *	@param 	isTouchedDismiss 	是否点击空白处时销毁
 *	@param 	confirmBlock 	确定状态的回调Block
 *	@param 	cancelBlock 	取消状态的回调Block
 */
+ (void) showModelWindow:(UIViewController*)viewController
          touchedDismiss:(BOOL)isTouchedDismiss
            confirmBlock:(ModelWindowBlock)confirmBlock
             cancelBlock:(ModelWindowBlock)cancelBlock;
@end
