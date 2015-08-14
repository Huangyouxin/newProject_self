//
//  TPDBGestureBO.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-13.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPDBGestureBO.h"
#import "TPUserDefaults.h"

@implementation TPDBGestureBO
@synthesize userid;
@synthesize password;

+ (void)insertObjID:(NSString *)userid {
    TPDBGestureBO *obj = [TPDBGestureBO new];
    obj.userid = userid;
    obj.password = @"0124678";
    obj.transStyle = TransactionStyleInsert;
    [DB transactionToDB:@[obj]];
}

+ (void)updateOBJID:(NSString *)userid password:(NSString *)gestore {
    TPDBGestureBO *obj = [TPDBGestureBO new];
    obj.userid = userid;
    obj.password = gestore;
    obj.transStyle = TransactionStyleUpdate;
    [DB transactionToDB:@[obj]];
}

@end
