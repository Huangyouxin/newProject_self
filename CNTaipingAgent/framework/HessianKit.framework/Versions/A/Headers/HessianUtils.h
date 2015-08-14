
#import <Foundation/Foundation.h>



@interface HessianUtils : NSObject

//解析和组装对应的对象
+(Protocol *) receiveProtocol;
+(SEL) receiveMethodSelector:(NSString *) type;
//获取配置文件中本接口方法的所有配置信息。
+(NSDictionary*) receiveMethodSettings:(NSString *) type;
+(void) registEntityToRemoteMap:(NSString*)configFilePath
                defaultProtocol:(Protocol *)protc;

//判断是否含有表情字符
+(BOOL) isContainEmoji:(NSString*)text;
//将表情字符替换成转义字符
+ (NSString*) replaceEmoji:(NSString*)text;
//将转义的表情等文字反转
+ (NSString*) replaceEmojiEncoderString:(NSString*)text;
@end
