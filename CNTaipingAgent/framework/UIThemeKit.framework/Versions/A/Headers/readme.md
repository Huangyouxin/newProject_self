/*---------------------------------------------------------------------------------------*
 UIView配置属性说明：
 
 设置背景颜色
 关键字：backgroundcolor或backcolor
 值：字符串类型，可以是0xffffff形式，或clearColor，blackColor，darkGrayColor，lightGrayColor，
 whiteColor，grayColor，redColor，greenColor，blueColor，cyanColor，yellowColor，
 magentaColor，orangeColor，purpleColor，brownColor
 *---------------------------------------------------------------------------------------*/
 UILabel配置属性说明：
 
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
5、设置阴影颜色
 关键字：shadowcolor，值：同背景色
6、设置阴影区域
 关键字：shadowoffset，值：字符串类型，{x,y}形式
7、设置最大行数
 关键字：numberoflines，值：正整数型
8、设置行间距
 关键字：linespace，值：正整数型
 *---------------------------------------------------------------------------------------*/
 UIImageView配置属性说明：
 
 1、设置背景颜色
 关键字：backgroundcolor或backcolor
 值：字符串类型，可以是0xffffff形式，或clearColor，blackColor，darkGrayColor，lightGrayColor，
 whiteColor，grayColor，redColor，greenColor，blueColor，cyanColor，yellowColor，
 magentaColor，orangeColor，purpleColor，brownColor
 2、设置image
 关键字：image，值：字符串类型，图片文件存放路径
 3、设置image显示边角曲率
 关键字：radius，值：正浮点数
 4、设置图片下载链接
 关键字：imageUrl，值：字符串类型，图片文件网络全路径
 5、设置相框图片
 关键字：frameImage，值：字符串类型，相框image文件存放路径
 6、设置内容image与相框间间隙
 关键字：frameImagePadding，值：正浮点数
 7、设置正常图片加载前或加载失败时显示的备份图片
 关键字：dummyImage，值：字符串类型，图片文件网络全路径
 8、设置图片表层mask图片
 关键字：maskImage，值：字符串类型，图片文件网络全路径
 *---------------------------------------------------------------------------------------*/
 UIButton配置属性说明：
 
 1、设置背景颜色
 关键字：backgroundcolor或backcolor
 值：字符串类型，可以是0xffffff形式，或clearColor，blackColor，darkGrayColor，lightGrayColor，
 whiteColor，grayColor，redColor，greenColor，blueColor，cyanColor，yellowColor，
 magentaColor，orangeColor，purpleColor，brownColor
 2、设置正常状态背景图片
 关键字：backgroundImage或backImage，值：字符串类型，图片文件存放路径
 3、设置高亮状态背景图片
 关键字：backgroundHighlitedImage或backhighlitedImage，值：字符串类型，图片文件存放路径
 3、设置选中/不可选状态背景图片
 关键字：backgroundSelectedImage或backSelectedImage，值：字符串类型，图片文件存放路径
 4、设置正常状态字体颜色
 关键字：textColor，值：同背景色
 5、设置高亮状态字体颜色
 关键字：texthighlitedColor，值：同背景色
 6、设置选中状态字体颜色
 关键字：textSelectedColor，值：同背景色
 7、设置字体大小
 关键字：fontSize，值：正整数
 *---------------------------------------------------------------------------------------*/
 UITableViewCell配置属性说明：
 
 1、设置textLabel、detailTextLabel同UILabel的默认属性
 2、设置backgroundColor和contentView.backgroundColor为透明色
 
 3、设置style类型
 关键字：style，值：正整数，值域氛围（0～3）
 4、设置附属类型
 关键字：accessoryType，值：正整数，值域氛围（0～4）
 5、设置选择背景类型
 关键字：selectionStyle，值：正整数，值域氛围（0～3）
 6、设置分割线区域
 关键字：separatorInset，值：字符串类型，{top,left,bottom,right}
 *---------------------------------------------------------------------------------------*/
 UITextField配置属性说明：
 
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
 UITextView配置属性说明：
 
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
 7、设置输入键盘上完成按钮模式
 关键字：returnKeyType，值：正整数型，值域范围（0～10）
 8、设置输入键盘展示样式
 关键字：keyboardAppearance，值：正整数型，值域范围（0～2）
 9、设置输入键盘输入样式
 关键字：keyboardType，值：正整数型，值域范围（0～10）
 *---------------------------------------------------------------------------------------*/
 
 
 
 
 
 
 
 