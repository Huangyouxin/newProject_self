//
//  TPDBGestureBO.h
//  CNTaipingAgent
//
//  Created by Stone on 14-8-13.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import <FMDatabase/FMDB.h>

@interface TPDBGestureBO : LKModelBase

@property(nonatomic, strong) NSString *userid;
@property(nonatomic, strong) NSString *password;

//+ (NSString *)gestureStringName:(NSString *)userID;

+ (void)insertObjID:(NSString *)userid;

+ (void)updateOBJID:(NSString *)userid password:(NSString *)gestore;

@end
