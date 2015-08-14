//
//  TPUIToolkit.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import <Foundation/Foundation.h>

//删除所有cache文件
extern void RemoveCacheFiels(void);
//config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
extern NSString* ConfigPath(NSString* fileName);
//获取资源全路径
extern NSString* ResourcePath(NSString* fileName);
//用于UIImage的imageNamed函数载入resource.bundle下的图片
extern NSString* Bundle(NSString* fileName);
//弹出消息框来显示消息
typedef void (^ShowMessageBlock)(void);
extern void ShowMessage(NSString* message, ShowMessageBlock completion);
extern void ShowMessageTop(NSString* message, UIView* targetView);
//根据图片路径加载图片
extern UIImage* Image(NSString* imageName);


//@{目录结构
//下载的文件存放路径:返回全路径 
extern NSString* CachePath(NSString* fileName);
//下载文件temp目录：用来下载时临时存储文件，实现断点续传 
extern NSString* DownloadTemporaryPath(NSString* fileName);
//资源文件路径
extern NSString* NibPath(NSString* fileName);
//@}

//删除文件
extern BOOL RemoveFile(NSString* fileName);
//存储文件
extern void SaveFile(NSString* fileName, NSData* data);
//检查文件是否存在
extern BOOL ExistAtPath(NSString* fileFullPath);

//计算文字实际高度
extern float CalcTextHight(UIFont *font, NSString* text, CGFloat width);
extern float CalcTextWidth(UIFont *font, NSString* text, CGFloat hight);

//获得拼音首字母序列
extern NSString* GetChineseSpell(NSString* Chinese);

//时间日期转换
extern NSString* DateStringWithTimeInterval(NSNumber* secs);
extern NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs);
extern NSString* StringFromDate(NSDate* aDate, NSString *aFormat);
extern NSDate*   DateFromString(NSString* string, NSString* aFormat);

//@{设置颜色
extern UIColor* ColorByHexString(NSString* colorKey);
extern UIColor* TEXTCOLOR(NSString* colorHex);
extern UIColor* BACKCOLOR(NSString* colorHex);
extern UIColor* BORDERCOLOR(NSString* colorHex);
//@}

extern void TPLLog(NSString *format, ...);
extern NSString *checkNull(NSString* text);
extern NSString *checkBDXZ(NSString* text);

//@{设置字体大小
extern UIFont * FontOfSize(CGFloat fontSize);
extern UIFont * BoldFontOfSize(CGFloat fontSize);
extern UIFont * ItalicFontOfSize(CGFloat fontSize);
//@}

//@{通知管理
extern void NotificationPost(NSString* name, id object, NSDictionary* uInfo);
extern void NotificationAddObserver(id target, NSString* name, SEL selector);
extern void NotificationRemoveObserver(id target, NSString* name);
//@}

//@{日期
extern NSDate * preYearForDate(NSDate *currentDate);
extern NSDate * preMonthForDate(NSDate *currentDate);
extern NSDate * nextDateForDate(NSDate *currentDate);
extern NSDate * preDayForDate(NSDate *currentDate);
extern NSDate * preYearDayForDate(NSDate *currentDate);

extern NSDate * NOWDATE();

extern NSString *  floatStringFromString(NSString *string , int decimalNum);

extern NSString *  floatWanYuanStringFromYuanString(NSString *string);

// 四舍五入保留两位小数
extern NSString * roundUp(NSString *number);
//@}