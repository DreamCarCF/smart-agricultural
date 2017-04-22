//
//  UserInfo.m
//  beloved999
//
//  Created by Sam Feng on 15/9/12.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//  这是一个单例类，用来在各个视图中读取用户信息

#import "UserInfo.h"

@implementation UserInfo

@synthesize userName = _userName;
@synthesize belovedCoin = _belovedCoin;
@synthesize bpoint = _bpoint;


+ (UserInfo *)sharedManager
{
    static UserInfo *sharedUserInfoInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUserInfoInstance = [[self alloc] init];
    });
    return sharedUserInfoInstance;
}


@end
