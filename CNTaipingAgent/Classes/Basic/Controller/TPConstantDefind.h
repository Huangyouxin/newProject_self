//
//  TPConstantDefind.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

//检测是否是iphone5屏幕尺寸
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define isIOS7_1 [[[UIDevice currentDevice] systemVersion] floatValue]*10 >= 71

#define isNotRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)

// 控制台Log输出控制，此确保在release版本下无Log输出
#ifdef  DEBUG
#define TPLLOG          NSLog
#else
#define TPLLOG          TPLLog
#endif

//高德地图KEY
#define MAMAP_KEY @"baede5fd14e319ceeb3c2186111ff16d"

#define NoNetHasCache @"当前网络不可用。本查询为最后一次查询结果"
#define NoNetMsg @"当前网络不可用，请检查您的网络设置"

#define returnNoNet  if ([TPLUserDefaults instance].onlyNote) {return;}

//Servel url
//#define SERVERL_URL @"http://emall.life.cntaiping.com/"
#define SERVERL_URL @"http://intest.life.cntaiping.com/"
//#define SERVERL_URL @"http://10.1.17.181:7001/"
//#define SERVERL_URL @"http://10.7.207.32:8080/"
//#define SERVERL_URL @"http://10.7.197.102:8080/"
//#define SERVERL_URL @"http://10.7.197.24:8080/"
//#define SERVERL_URL @"http://10.7.197.23:8080/"

// 自动调整尺寸控制：full形式
#define  AutoresizingFull   UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight

//屏幕点击事件监控时间周期，超过这个周期则需重新登录，会弹出登录页面
//15分钟
#define   TouchEventMonitorTime            15*60
//输入框左右边距
#define   TextFieldLRPadding               5

#define   PADDING                          15

//消息刷新时间
#define   MessageTime                      2.0*60
//是否需要强制后台是否更新判断
#define   UpdateNetUpdateStatus            1//1   0
//广播消息的接受渠道  目前是1
#define   NoticeReciveCHANNEL              @1

//@{定义字体大小
#define   FontHugeSize                     21
#define   FontLargeSize                    18
#define   FontNormalSize                   16
#define   FontSmallSize                    14
#define   FontSmallThanSmallSize           12
#define   FontSmallSmallSize               8
//@}
//@{定义字体颜色
#define TextGrayColor       TEXTCOLOR(@"0xa6a6a6")
#define TextBlackColor      TEXTCOLOR(@"0x4c4c4c")
#define TextBackGroudColor  TEXTCOLOR(@"0xffffff")

#define ColorTVHeaderText   TEXTCOLOR(@"0xffffff")
#define ColorTVHeader       TEXTCOLOR(@"0xdacaba")
#define ColorTVCellSelect   TEXTCOLOR(@"0xf5ebe0")

#define SwitchColor         TEXTCOLOR(@"0xa87645")
#define FootColor           [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]

#define ButtonHeight        40

// 正则表达式判断字符串是否为数字
#define Regular             @"^-?[0-9]{0,}\\.?[0-9]{1,}?$"
// 正则表达式判断字符串是否为数字，正整数
#define Regex               @"^[0-9]*$"

//@}
//@{定义行高
#define   RowLargeHeight                    60
#define   RowNormalHeight                   44
#define   RowSmallHeight                    32
//@}

#define topMargin           20
#define leftMargin          20
#define seperatorDistance   20

//@}
#define reportTypeZongHe      42
#define reportTypeChengBao    40
#define reportTypeYuShou      39
#define reportTypeRenLi       41
#define reportTypeJGChengBao  44
#define reportTypeJGYuShou    43
#define reportTypeZiDingYi    24
//@{报表

//左边搜索栏隐藏，内容页面全屏显示
UIKIT_EXTERN NSString *const NotificationMsg_EnterFullScreen;
//左边搜索栏显示
UIKIT_EXTERN NSString *const NotificationMsg_ShowLeftView;

//@{消息定义
//有新版本了，弹出提示框去升级
UIKIT_EXTERN NSString *const NotificationMsg_HAS_NEW_VERSION;
//自动更新版本消息
UIKIT_EXTERN NSString *const NotificationMsg_UPDATE_VERSION;
//弹出登录页面
UIKIT_EXTERN NSString *const NotificationMsg_POPUP_LOGIN;
//弹出登录页面登录成功
UIKIT_EXTERN NSString *const NotificationMsg_POPUP_LOGIN_SUCCEED;
//弹出修改密码框
UIKIT_EXTERN NSString *const NotificationMsg_POPUP_MODIFY_PASSWORD;
//新增保单检视后的刷新通知
UIKIT_EXTERN NSString *const NotificationMsg_UpdatePolisyJianshi;
//左侧搜索 点开后 在关闭 右侧顶端按钮变灰的控制
UIKIT_EXTERN NSString *const NotificationMsg_setTopButtonStatus;
//登录的时候对健康险的消息提示
UIKIT_EXTERN NSString *const NotificationMsg_showJianKangMessage;

#define TPLSqlName  @"db.sqlite"
#define TPLMsgName  @"message.sqlite"

#define NQ_PLANTID    @"135"

//密码3天即将过期的状态标志
#define Login_Lost_Status 30013

#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#define string(str) str?str:@""

#define name0(name,age) [NSString stringWithFormat:@"<font color='#196203' size=22>%@</font><font color='#535353' size=18>   %d</font></font><font color='#535353' size=13>岁</font>",string(name),age]

#define name1(name) [NSString stringWithFormat:@"<font color='#196203' size=24>%@</font>",string(name)]

#define ShowError TPLLOG(@"\n================\n--error--\n=%d=\n=%@=\n=%@=\n================\n",__LINE__,[self description],[exception reason])

#define ShowLayer(view)  view.layer.borderColor = RandomColor.CGColor; view.layer.borderWidth = 3



#define kMeetingRightCellHeight        65.0
#define kMeetingTableHeaderHeight      45.0
#define kMeetingTableFooterHeight      65.0

#define kMeetingLeftPartWidth          986/2.0
#define kMeetingRightPartWidth         480
#define kMeetingIntroduceViewHeight    165

#define kMeetingIntroduceLabelWidth    130
#define kMeetingIntroduceLabelHeight   83

#define kMeetingDetailLabelWidth       405
#define kMeetingDetailLabelHeight      112

#define kMeetingBtnInFooterWidth       150
#define kMeetingBtnInFooterHeight      50

#define kMeetingDetailRightPartWidth   480
#define kMeetingDetailLeftPartWidth    475
#define kMeetingDetailTableCellHeight  95

#define kMeetingShowRightDetailWidth   240

#define kCellPading    15