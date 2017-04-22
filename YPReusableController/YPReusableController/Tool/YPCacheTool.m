//
//  YPCacheTool.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/3.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPCacheTool.h"

#define kChannelTitleArrayKey @"ChannelTitleArrayKey"
#define kunderTitleArrayKey @"UnderTitleArrayKey"

@implementation YPCacheTool

+ (NSArray *)channelTitleArray
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kChannelTitleArrayKey];
}

+ (NSArray *)underTitleArray
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kunderTitleArrayKey];
}


+ (void)saveChannelTitleArray:(NSArray *)titleArray
{
    [[NSUserDefaults standardUserDefaults] setObject:[titleArray copy] forKey:kChannelTitleArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)saveunderTitleArray:(NSArray *)titleArray
{
    [[NSUserDefaults standardUserDefaults] setObject:[titleArray copy] forKey:kunderTitleArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeunderTitleArray
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kunderTitleArrayKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+ (void)removeChannelTitleArray
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kChannelTitleArrayKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

}
@end
