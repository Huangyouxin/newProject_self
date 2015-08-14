//
//  NSDecimalNumber_TPLExtension.h
//  CNTaiPingLife
//
//  Created by Taiping001 on 13-5-3.
//  Copyright (c) 2013年 CNTaiPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (TPLExtension)
+ (NSDecimalNumber *)decimalWithData:(id)data;
+ (NSDecimalNumber *)decimalWithFloat:(float)data;
+ (NSDecimalNumber *)decimalWithLong:(long)data;
+ (NSDecimalNumber *)decimalWithInt:(int)data;
+ (NSDecimalNumber *)decimalWithDouble:(double)data;
+ (NSDecimalNumber *)decimalWithBool:(BOOL)data;
+ (NSDecimalNumber *)decimalWithChar:(char)value;
+ (NSDecimalNumber *)decimalWithUnsignedChar:(unsigned char)value;
+ (NSDecimalNumber *)decimalWithShort:(short)value;
+ (NSDecimalNumber *)decimalWithUnsignedShort:(unsigned short)value;
+ (NSDecimalNumber *)decimalWithUnsignedInt:(unsigned int)value;
+ (NSDecimalNumber *)decimalWithUnsignedLong:(unsigned long)value;
+ (NSDecimalNumber *)decimalWithLongLong:(long long)value;
+ (NSDecimalNumber *)decimalWithUnsignedLongLong:(unsigned long long)value;
+ (NSDecimalNumber *)decimalWithInteger:(NSInteger)value;
+ (NSDecimalNumber *)decimalWithUnsignedInteger:(NSUInteger)value;
@end
