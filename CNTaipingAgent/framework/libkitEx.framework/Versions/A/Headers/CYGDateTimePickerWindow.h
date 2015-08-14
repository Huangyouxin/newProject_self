//
//  CYGDateTimePickerWindow.h
//
//  Created by cuiyuguo on 13-11-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^CYGDateTimePickerBlock)(id data);
@interface CYGDateTimePickerWindow : UIView


/**
 *	@brief	集成系统的日期选择控件
 *
 *	@param 	mode 	日期控件显示模式
 *	@param 	view 	要显示到哪个视图层上，如果传nil则将被显示到整个window上
 *	@param 	minDate 最小日期（该日期前的日期不能选择）,如传nil则不做最小限制
 *	@param 	maxDate 最大日期（该日期后的日期不能选择）,如传nil则不做最大限制
 *	@param 	date 	初始日期，如此传nil则默认为当前日期时间
 *	@param 	confirmBl 	选择完毕后的返回参数
 *	@param 	cancelBl 	取消选择的返回参数
 *
 *	@return	无
 */
+ (void) showWithMode:(UIDatePickerMode)mode
               toView:(UIView*)view
              minDate:(NSDate*)minDate
              maxDate:(NSDate*)maxDate
                 date:(NSDate*)date
     withConfirmBlock:(CYGDateTimePickerBlock)confirmBl
      withCancelBlock:(CYGDateTimePickerBlock)cancelBl;

@end
