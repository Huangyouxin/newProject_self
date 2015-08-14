//
//  CenterModelWindow.h
//  CNTaipingAgent
//
//  Created by Stone on 14-10-16.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ModelWinowBlock)(id data);
@interface CenterModelWindow : UIView

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
+ (void) showModelWindow:(UIViewController *)viewController
          touchedDismiss:(BOOL)isTouchedDismiss
            confirmBlock:(ModelWindowBlock)confirmBlock
             cancelBlock:(ModelWindowBlock)cancelBlock;
@end
