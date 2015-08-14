//
//  UITextField+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-3-1.
//
//

#import <UIKit/UIKit.h>


/*---------------------------------------------------------------------------------------*
 配置属性说明：
 
 1、设置背景颜色
 关键字：backgroundcolor或backcolor
 值：字符串类型，可以是0xffffff形式，或clearColor，blackColor，darkGrayColor，lightGrayColor，
 whiteColor，grayColor，redColor，greenColor，blueColor，cyanColor，yellowColor，
 magentaColor，orangeColor，purpleColor，brownColor
 2、设置文字颜色
 关键字：textcolor，值：同背景色
 3、设置文字大小
 关键字：fontsize，值：正整数型
 4、设置文字对齐方式
 关键字：textalignment或alignment，值：正整数型，值域范围（0～4）
 5、设置输入框内提示语
 关键字：placeholder，值：字符串类型
 6、设置输入框提示语颜色
 关键字：placeholderColor，值同背景色
 7、设置输入框背景图片
 关键字：backgroundimage或backimage，值：字符串类型，图片文件存放路径
 8、设置输入框不可输入状态背景图片
 关键字：disabledBackground或disbackground，值：字符串类型，图片文件存放路径
 9、设置输入框内清除按钮模式
 关键字：clearButtonMode，值：正整数型，值域范围（0～3）
 10、设置边框模式
 关键字：borderStyle，值：正整数型，值域范围（0～3）
 11、设置是否密码输入模式
 关键字：isSecure，值：布尔型，值域范围（0或1）
 12、设置输入键盘上完成按钮模式
 关键字：returnKeyType，值：正整数型，值域范围（0～10）
 13、设置输入键盘展示样式
 关键字：keyboardAppearance，值：正整数型，值域范围（0～2）
 14、设置输入键盘输入样式
 关键字：keyboardType，值：正整数型，值域范围（0～10）
 15、设置正则表达式以检测输入是否合法
 关键字：validate，值：字符串
 *---------------------------------------------------------------------------------------*/

typedef void (^UITextFieldTextChangeBlock)(NSString *newText);
@interface UITextField (ThemeKit)
@property(nonatomic, strong)UIColor *placeholderColor;
//正则表达式用以验证输入的是否满足要求
@property(nonatomic, strong)NSString *validate;


- (void)textChanged:(UITextFieldTextChangeBlock)block;
//设置最大长度限制，如果当输入超过所设长度时不需要提示，可以用属性设置，
//如果需要提示，可以用block函数，注意，当两个都用的时候，属性设置
//不起作用
@property(nonatomic, assign)NSInteger maxInputLength;
- (void)maxInputLength:(NSInteger (^)(UITextField* textField))maxLen
               tipShow:(void (^)(UITextField* textField))tipShow;
@end
