//
//  UIView+Line.m
//  CNTaiPingAgent
//
//  Created by Eric on 13-11-22.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)

+ (UIView *)addHLinePoint:(CGPoint)point inView:(UIView *)ptview length:(float)length{
    return [UIView addLinePoint:point
                         inView:ptview
                         length:length
                        slength:length
                        xlength:0
                       andAngle:0
                     slineColor:linecolor
                     xlineColor:nil
                      lineWidth:1];
}

+ (void)addHTLinePoint:(CGPoint)point inView:(UIView *)ptview length:(float)length{
    [UIView addLinePoint:point
                  inView:ptview
                  length:length
                 slength:length
                 xlength:0
                andAngle:0
              slineColor:linecolor_T
              xlineColor:nil
               lineWidth:1];
}


+ (UIView *)addVLinePoint:(CGPoint)point inView:(UIView *)ptview length:(float)length{
    return [UIView addLinePoint:point
                         inView:ptview
                         length:length
                        slength:length
                        xlength:0
                       andAngle:M_PI_2
                     slineColor:linecolor
                     xlineColor:nil
                      lineWidth:1];
}

+ (UIView *)addHXLinePoint:(CGPoint)point
                    inView:(UIView *)ptview
                    length:(float)length {
    return [UIView addLinePoint:point
                  inView:ptview
                  length:length
                 slength:3
                 xlength:3
                andAngle:0
              slineColor:linecolor
              xlineColor:nil
               lineWidth:1];
}

+ (void)addVXLinePoint:(CGPoint)point
                inView:(UIView *)ptview
                length:(float)length {
    [UIView addLinePoint:point
                  inView:ptview
                  length:length
                 slength:3
                 xlength:3
                andAngle:M_PI_2
              slineColor:linecolor
              xlineColor:nil
               lineWidth:1];
}

+ (UIView *)addLinePoint:(CGPoint)point
                  inView:(UIView *)ptview
                  length:(float)length
                 slength:(float)slength
                 xlength:(int)xlength//线长
                andAngle:(float)angle
              slineColor:(UIColor *)sxcolor
              xlineColor:(UIColor *)xcolor
               lineWidth:(float)linewidth{
    return [UIView viewLinePoint:point
                   inView:ptview
                   length:length
                  slength:slength
                  xlength:xlength
                 andAngle:angle
               slineColor:sxcolor
               xlineColor:xcolor
                lineWidth:linewidth];
}

+ (UIView *)viewLinePoint:(CGPoint)point
                   inView:(UIView *)ptview
                   length:(float)length
                  slength:(float)slength
                  xlength:(int)xlength//线长
                 andAngle:(float)angle
               slineColor:(UIColor *)sxcolor //default is grayColor ...
               xlineColor:(UIColor *)xcolor//default is whiteColor ...
                lineWidth:(float)linewidth{
    if (length == 0) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x-length*0.5, point.y-.5, length, linewidth)];
    [ptview addSubview:line];
    if (sxcolor) {
        line.backgroundColor = sxcolor;
    }else line.backgroundColor = BACKCOLOR(@"0xc3c3c3");
    float indexw = slength;
    int k = 0;
    BOOL isshow = YES;
    while (isshow) {
        if (indexw+xlength <= length) {
            k++;
            UIView *bview = [[UIView alloc] initWithFrame:CGRectMake(indexw, 0, xlength, linewidth)];
            if (xcolor) {
                bview.backgroundColor = xcolor;
            }else bview.backgroundColor = TextBackGroudColor;
            [line addSubview:bview];
            indexw += xlength;
            indexw += slength;
        }else {
            float w = length - indexw - xlength;
            if (w > 0) {
                UIView *bview = [[UIView alloc] initWithFrame:CGRectMake(indexw, 0, w, linewidth)];
                if (xcolor) {
                    bview.backgroundColor = xcolor;
                }else bview.backgroundColor = TextBackGroudColor;
                [line addSubview:bview];
            }
            isshow = NO;
        }
    }
    line.layer.anchorPoint = CGPointMake(0, 0);
    line.transform = CGAffineTransformIdentity;
    line.transform = CGAffineTransformMakeRotation(angle);
    [ptview bringSubviewToFront:line];
    return line;
}

@end
