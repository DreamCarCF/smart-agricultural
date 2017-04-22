//
//  LoginSession.m
//  beloved999
//
//  Created by Sam Feng on 15/12/18.
//  Copyright © 2015年 beloved999. All rights reserved.
//
#define checkUserLogin(token) ( (token) == NULL || [(token) isEqualToString:@""] ? NO:YES)
#import "LoginSession.h"

@implementation LoginSession

+(NSDictionary *)returnLoginSession{
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSDictionary * sessionDict;
    if(checkUserLogin(token)){
        sessionDict = @{@"sid":token,@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"]};
    }else{
        sessionDict = @{@"sid":@"",@"uid":@""};
    }
    return sessionDict;
}

@end
