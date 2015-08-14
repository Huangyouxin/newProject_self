//
//  CYGComboBox.h
//
//  Created by cuiyuguo on 13-11-15.
//  Copyright 2013年 cuiyuguo. All rights reserved.
//



#import "CYGPopupWindow.h"


@class CYGComboBoxContentView;


@interface CYGComboBox : UITextField
//列表下拉时选中项的数据
@property(nonatomic, strong)NSArray*  comboDatas;
@property(nonatomic, assign)CGSize    comboSize;
//列表下拉时选中项的序号
@property(nonatomic, assign)int  selectedIndex;
//箭头从哪个方向指向目标view
@property(nonatomic, assign)CYGPointDirection  direction;

//是否可编辑
@property(nonatomic, assign)BOOL editable;
//下拉按钮
@property(nonatomic, strong, readonly)UIButton* detailButton;
@end
