//
//  NSData+Crypt.h
//  Encryption
//
//  Created by Maxime Lecomte on 29/03/11.
//  Copyright 2011 NA. All rights reserved.
//


#import <CommonCrypto/CommonCryptor.h>

@interface NSData (Crypt)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

- (NSString *)md5;
@end

