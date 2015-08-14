//
//  UIViewController+Keyboard.h
//  
//
//  Created by cuiyuguo Amitay on 5/51/13.
//  Copyright (c) 2013 cuiyuguo Amitay. All rights reserved.
//



typedef NS_ENUM(NSInteger, UIViewControllerKeyboard) {
    UIViewControllerKeyboardWillShow = 0,
    UIViewControllerKeyboardDidShow = 1,
    UIViewControllerKeyboardWillHide = 2,
    UIViewControllerKeyboardDidHide = 3
};


typedef void (^KeyboardDidMoveBlock)(CGFloat moveHeight, UIViewControllerKeyboard state);

@interface UIViewController(KeyboardMonitor)


- (void)keyboardMonitor:(KeyboardDidMoveBlock)didMoveBlock;

@end

