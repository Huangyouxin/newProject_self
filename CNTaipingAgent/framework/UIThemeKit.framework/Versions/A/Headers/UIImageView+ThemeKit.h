//
//  UIImageView+ThemeKit.h
//  framework
//
//  Created by 崔玉国 on 14-2-28.
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

typedef UIImage* (^ImageLoadedBlock)(UIImage* originImage, NSString* url, NSString* filePath);
@interface UIImageView (ThemeKit)
//图片网络下载地址
@property(nonatomic, strong)NSString *imageUrl;
//图片显示圆角比率，默认为0
@property(nonatomic, assign)CGFloat radius;

//文件被加载完毕的回调函数
- (void) addLoadedBlock:(ImageLoadedBlock)block;
@end




@interface UIImageViewEx : UIView
@property(nonatomic, strong)UIImage *image;
@property(nonatomic)UIViewContentMode contentMode;
@property(nonatomic,assign)BOOL highlighted;
//图片显示圆角比率，默认为0
@property(nonatomic, assign)CGFloat radius;
//图片网络下载地址
@property(nonatomic, strong)NSString *imageUrl;
@property(nonatomic, assign)BOOL noPathExtension;
//图片边框，必须需要把图片显示在边框内，设置边框图片
@property(nonatomic, strong)UIImage *frameImage;
@property(nonatomic, assign)CGFloat  frameImagePadding;
//图片被加载前或加载失败是显示的默认图片
@property(nonatomic, strong)UIImage *dummyImage;
//图片被蒙上一层膜图片
@property(nonatomic, strong)UIImage *maskImage;
//文件被加载完毕的回调函数
- (void) addLoadedBlock:(ImageLoadedBlock)block;
@end
