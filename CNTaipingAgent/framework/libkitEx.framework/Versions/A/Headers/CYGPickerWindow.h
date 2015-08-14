//
//  CYGPickerWindow.h
//
//  Created by cuiyuguo on 13-11-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface CYGPickerItem : NSObject
@property(nonatomic, strong)NSString  *title;
@property(nonatomic, strong)NSArray   *subItems;
@property(nonatomic, strong)id   objTag;
@property(nonatomic, assign)int  tag;
@end

extern CYGPickerItem *createPickerItem(NSString* title, NSArray* subItems);


typedef void (^CYGPickerBlock)(NSArray *items);
@interface CYGPickerWindow : UIView {
@private
	UIPickerView*    _picker;
}

/**
 *	@brief	调用picker进行选择，支持多级，最多支持到5级
 *
 *	@param 	items 	CYGPickerItem元素数组
 *	@param 	view 	要显示到哪个视图层上，如果传nil则将被显示到整个window上
 *	@param 	widths 	每一级要显示的宽度
 *	@param 	selectedItems 	初始选中的项
 *	@param 	confirmBl 	选择完毕后的返回参数
 *	@param 	cancelBl 	取消选择的返回参数
 *
 *	@return	无
 */
+ (void) showWithItems:(NSArray*)items
                toView:(UIView*)view
                widths:(NSArray*)widths
         selectedItems:(NSArray*)selectedItems
     withConfirmBlock:(CYGPickerBlock)confirmBl
      withCancelBlock:(CYGPickerBlock)cancelBl;


@end
