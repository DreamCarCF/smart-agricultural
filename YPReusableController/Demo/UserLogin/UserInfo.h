    //
//  UserInfo.h
//  beloved999
//
//  Created by Sam Feng on 15/9/12.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *belovedCoin;
@property(strong,nonatomic) NSString *bpoint;

+ (UserInfo *)sharedManager;
@end
