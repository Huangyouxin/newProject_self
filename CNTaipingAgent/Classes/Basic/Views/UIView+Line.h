//
//  UIView+Line.h
//  CNTaiPingAgent
//
//  Created by Eric on 13-11-22.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define linecolor       TEXTCOLOR(@"0xc3c3c3")
#define linecolor_T     TEXTCOLOR(@"0xc8c7cc")

//not fix layoutSubviews function
//can use in the view where view.frame is sure 
@interface UIView (Line)

//增加一个水平实线
+ (UIView *)addHLinePoint:(CGPoint)point
                   inView:(UIView *)ptview
                   length:(float)length;

+ (void)addHTLinePoint:(CGPoint)point
               inView:(UIView *)ptview
               length:(float)length;

//增加一个垂直实线
+ (UIView *)addVLinePoint:(CGPoint)point
                   inView:(UIView *)ptview
                   length:(float)length;

//增加一个水平虚线
+ (UIView *)addHXLinePoint:(CGPoint)point
                    inView:(UIView *)ptview
                    length:(float)length;
//增加一个垂直虚线
+ (void)addVXLinePoint:(CGPoint)point
               inView:(UIView *)ptview
               length:(float)length;

//自定义转角
//ptview  线条加到某一个view
//length  线条长度
//slength 实线的长度
//xlength 虚线的长度
//angle   转的角度
//sxcolor 实线的颜色
//xcolor  虚线的颜色
//linewidth  线宽
+ (UIView *)addLinePoint:(CGPoint)point
                  inView:(UIView *)ptview
                  length:(float)length
                 slength:(float)slength
                 xlength:(int)xlength//线长
                andAngle:(float)angle
              slineColor:(UIColor *)sxcolor //default is 0xaeaeae ...
              xlineColor:(UIColor *)xcolor//default is whiteColor ...
               lineWidth:(float)linewidth;

+ (UIView *)viewLinePoint:(CGPoint)point
              inView:(UIView *)ptview
              length:(float)length
             slength:(float)slength
             xlength:(int)xlength//线长
            andAngle:(float)angle
          slineColor:(UIColor *)sxcolor //default is grayColor ...
          xlineColor:(UIColor *)xcolor//default is whiteColor ...
           lineWidth:(float)linewidth;

@end
