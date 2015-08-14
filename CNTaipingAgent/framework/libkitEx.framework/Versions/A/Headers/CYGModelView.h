//
//  CYGModelView.h
//  framework
//
//  Created by 崔玉国 on 14-5-5.
//
//

#import <UIKit/UIKit.h>


//CYGModelView消息
UIKIT_EXTERN NSString *const NotificationMsg_ModelViewConfirmed;
UIKIT_EXTERN NSString *const NotificationMsg_ModelViewRelayoutView;


typedef void (^ModelViewBlock)(id data);
@interface CYGModelView : UIView

+ (void) setContentViewBackground:(UIImage*)image;
+ (void) setContentViewContentInset:(UIEdgeInsets)inset;

+ (void) dismissModelView:(void (^)(void))completion;

/**
 *	@brief	弹出模态窗口
 * 特别说明：关闭模态窗口通过调用：
 *         NotificationPost(NotificationMsg_ModelWindowConfirmed, nil, data);
 * 如果需要迁入下级页面，只需要页面push即可，如下级页面需要不同于上级页面的高度，那么下级
 * 页面需实现//-(NSNumber*)asModelViewHeight函数
 *
 *	@param 	modelView 	模态view
 *	@param 	topView 	此模态view显示在topView之下
 *	@param 	size 	此模态view显示在宽度和高度
 *	@param 	confirmBlock 	确定状态的回调Block
 */
+ (void) showModelView:(UIView*)modelView
               topView:(UIView*)topView
                  size:(CGSize)showSize
            confirmBlock:(ModelViewBlock)confirmBlock;
@end
