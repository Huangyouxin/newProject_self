//
//  DetailLabel.m
//  
//
//  Created by Mac Pro on 4/27/12.
//  Copyright (c) 2012 Dawn. All rights reserved.
//

#import "DetailLabel.h"
#import <CoreText/CoreText.h>


@implementation TPRange
@synthesize location, length;

+(id)range:(int)location length:(int)length {
    TPRange* range = [[TPRange alloc] init];
    range.location = location;
    range.length = length;
    return range;
}
- (NSRange) range {
    return NSMakeRange(self.location, self.length);
}
@end

@implementation DetailLabel
@synthesize lineSpace;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        resultAttributedString = [[NSMutableAttributedString alloc]init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    resultAttributedString = [[NSMutableAttributedString alloc]init];
    self.backgroundColor = [UIColor clearColor];
}
- (void) addLineAttributed {
    //创建文本对齐方式
    CTTextAlignment alignment = kCTJustifiedTextAlignment;//这种对齐方式会自动调整，使左右始终对齐
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    //创建文本行间距
//    lineSpace=14.1f;//间距数据
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
    lineSpaceStyle.valueSize=sizeof(lineSpace);
    lineSpaceStyle.value=&lineSpace;
    
    //创建样式数组
    CTParagraphStyleSetting settings[]={
        alignmentStyle,lineSpaceStyle
    };
    
    //设置样式
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings,
                            sizeof(settings)/sizeof(CTParagraphStyleSetting));
    //给字符串添加样式attribute
    [resultAttributedString addAttribute:(id)kCTParagraphStyleAttributeName
                                   value:(__bridge id)paragraphStyle
                                   range:NSMakeRange(0, [resultAttributedString length])];
}
- (void) setText:(NSString *)text {
    if (nil == text) return ;
    super.text = text;
    int len = [text length];
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc]initWithString:text];
    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)self.textColor.CGColor range:NSMakeRange(0, len)];
    UIFont* font = FontOfSize(FontNormalSize);
    CTFontRef ctFont2 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
    [mutaString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont2 range:NSMakeRange(0, len)];
    CFRelease(ctFont2);
    resultAttributedString = mutaString;
    [self addLineAttributed];
}
-(void)setText:(NSString *)text WithFont:(UIFont *)font AndColor:(UIColor *)color{
    super.text = text;
    int len = [text length];
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc]initWithString:text];
    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)color.CGColor range:NSMakeRange(0, len)];
    CTFontRef ctFont2 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
    [mutaString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont2 range:NSMakeRange(0, len)];
    CFRelease(ctFont2);
    resultAttributedString = mutaString;
    [self addLineAttributed];
}
-(void)setKeyWordTextArray:(NSArray *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor{
    NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [keyWordArray count]; i++) {
        NSString *keyString = [keyWordArray objectAtIndex:i];
        NSRange range = [self.text rangeOfString:keyString];
        NSValue *value = [NSValue valueWithRange:range];
        if (range.length > 0) {
            [rangeArray addObject:value];
        }
    }
    for (NSValue *value in rangeArray) {
        NSRange keyRange = [value rangeValue];
        [resultAttributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyWordColor.CGColor range:keyRange];
        CTFontRef ctFont1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
        [resultAttributedString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont1 range:keyRange];
        CFRelease(ctFont1);
    }
}

-(void)addRanges:(NSArray *)rangeArray WithFont:(UIFont *)font AndColor:(UIColor *)rangeColor {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (TPRange* range in rangeArray) {
        NSValue *value = [NSValue valueWithRange:[range range]];
        if (range.length > 0) {
            [array addObject:value];
        }
    }
    for (NSValue *value in array) {
        NSRange keyRange = [value rangeValue];
        [resultAttributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)rangeColor.CGColor range:keyRange];
        CTFontRef ctFont1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
        [resultAttributedString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont1 range:keyRange];
        CFRelease(ctFont1);
    }
}
-(void)addRange:(TPRange *)range WithFont:(UIFont *)font AndColor:(UIColor *)rangeColor {
    if (range) {
        [resultAttributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)rangeColor.CGColor range:[range range]];
        CTFontRef ctFont1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
        [resultAttributedString addAttribute:(NSString *)(kCTFontAttributeName) value:(__bridge id)ctFont1 range:[range range]];
        CFRelease(ctFont1);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.text !=nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, 0.0);//move
        CGContextScaleCTM(context, 1.0, -1.0);
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)resultAttributedString);
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGPathAddRect(pathRef,NULL , rect);//const CGAffineTransform *m
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, resultAttributedString.length), pathRef,NULL );//CFDictionaryRef frameAttributes
        CGContextTranslateCTM(context, 0, -self.height);
        CGContextSetTextPosition(context, 0, 0);
        CTFrameDraw(frame, context);
        CGContextRestoreGState(context);
        CGPathRelease(pathRef);
        CFRelease(framesetter);
        UIGraphicsPushContext(context);
        //
    }
}

- (CGFloat) realHeight:(CGFloat)width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)resultAttributedString);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (__bridge NSArray *) CTFrameGetLines(textFrame);
    if (linesArray.count <= 0) {
        return 0.0;
    }
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}

@end
