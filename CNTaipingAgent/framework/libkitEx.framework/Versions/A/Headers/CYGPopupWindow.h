//
//  CYGPopupWindow.h
//
//  Created by 崔玉国 on 13-11-17.
//  Copyright (c) 2013年 cuiyuguo. All rights reserved.
//




typedef enum {
	CYGPointDirectionUp = 0,
	CYGPointDirectionDown,
    CYGPointDirectionLeft,
    CYGPointDirectionRight
} CYGPointDirection;

/** 说明：本类是用了CYGPopTipView,所以如需改变弹出框样式，请如下调用修改
 1、设置弹出框背景色
 [[CYGPopTipView appearance] setPopoverColor:[UIColor BlueColor]];
 2、设置圆角弧度值
 [[CYGPopTipView appearance] setRadius:10.0f];
 3、设置内容偏移量
 [[CYGPopTipView appearance] setPadding:10.0f];
 4、设置所指剪头大小
 [[CYGPopTipView appearance] setArrowSize:CGSizeMake(6,6)];
**/
 
 
//CYGPopupWindow消息
UIKIT_EXTERN NSString *const NotificationMsg_PopTipWindowConfirmed;
//@}
typedef void (^PopupWindowBlock)(id data);
@interface CYGPopupWindow : NSObject


/**
 *	@brief	弹出Tip窗口<窗口外围不变暗，点了外围区域窗口消失>
 * 弹出窗口颜色和contentView背景颜色同
 * 特别说明：主动关闭Tip窗口通过调用：
 *         NotificationPost(NotificationMsg_PopTipWindowConfirmed, nil, data);
 *	@param 	contentView 	任何形式view，窗口尺寸根据contentView的frame.size而定，所以设好再传进来
 *	@param 	targetView 	    在哪个view上弹<箭头指向>
 *	@param 	direction 	    箭头从哪个方向指向目标view
 *	@param 	completion      确定状态的回调Block
 */
+ (void) showPopupTipWindow:(UIView*)contentView
                     atView:(UIView *)targetView
                  direction:(CYGPointDirection)direction
                 completion:(PopupWindowBlock)completion;

/**
 *	@brief	弹出Tip窗口<窗口外围不变暗，点了外围区域窗口消失>
 * 弹出窗口颜色和contentView背景颜色同
 * 特别说明：主动关闭Tip窗口通过调用：
 *         NotificationPost(NotificationMsg_PopTipWindowConfirmed, nil, data);
 *	@param 	contentView 	任何形式view，窗口尺寸根据contentView的frame.size而定，所以设好再传进来
 *	@param 	barButtonItem 	在哪个BarButtonItem上弹<箭头指向>
 *	@param 	direction 	    箭头从哪个方向指向目标view
 *	@param 	completion      确定状态的回调Block
 */
+ (void) showPopupTipWindow:(UIView*)contentView
            atBarButtonItem:(UIBarButtonItem *)barButtonItem
                  direction:(CYGPointDirection)direction
                 completion:(PopupWindowBlock)completionBlock;
@end
