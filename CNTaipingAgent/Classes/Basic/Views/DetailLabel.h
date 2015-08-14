//
//  DetailTextView.h
//  
//
//  Created by Mac Pro on 4/27/12.
//  Copyright (c) 2012 Dawn. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TPRange : NSObject
@property(nonatomic, assign)int location;
@property(nonatomic, assign)int length;

+ (id)range:(int)location length:(int)length;
- (NSRange) range;
@end


@interface DetailLabel : UILabel {
    NSMutableAttributedString *resultAttributedString;
}
@property(nonatomic, assign)CGFloat lineSpace; //行间距

- (CGFloat) realHeight:(CGFloat)width;

-(void)setKeyWordTextArray:(NSArray *)keyWordArray WithFont:(UIFont *)font AndColor:(UIColor *)keyWordColor;
-(void)addRanges:(NSArray *)rangeArray WithFont:(UIFont *)font AndColor:(UIColor *)rangeColor;
-(void)addRange:(TPRange *)range WithFont:(UIFont *)font AndColor:(UIColor *)rangeColor;

-(void)setText:(NSString *)text WithFont:(UIFont *)font AndColor:(UIColor *)color;

@end
