//
//  AppDelegate.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "AppDelegate.h"
#import "YPSideController.h"
#import "YPLeftMenuController.h"
#import "YPReusableControllerConst.h"
#import "ViewController.h"
#import "YPBaseNavigationController.h"
#import "ChangyanSDK.h"
#import "LoginViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TopModel.h"
#import "ConnectServer.h"
#import "PaiXuViewController.h"
@interface AppDelegate () <YPSideControllerDelegate,UINavigationControllerDelegate>
{
    NSString *QRUrl;
    NSMutableArray *titleArray;
}
@end

@implementation AppDelegate
- (instancetype)init
{
    self = [super init];
    if (self) {
        titleArray = [NSMutableArray new];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialWechatHandler setWXAppId:@"wxf9a9b07b4882c095" appSecret:@"f9f2820835b3b2b601539da146534d1f" url:@"http://www.nyxdt.com"];
    [UMSocialData setAppKey:@"56d4f773e0f55a790b001aad"];
    [ChangyanSDK registerApp:@"cysgJpf9N"
                      appKey:@"da9b7df4468b691e28dadcdbe5eac30b"
                 redirectUrl:@"http://10.2.58.251:8081/login-success.html"
        anonymousAccessToken:@"lRTU3LghBcOtwGzEapYEsKt69Us55p8xBPbvxZ8EhW0"];
    
    [ChangyanSDK setAllowSelfLogin:YES];
    [ChangyanSDK setLoginViewController:[[LoginViewController alloc] init]];
    
    [ChangyanSDK setAllowAnonymous:NO];
    [ChangyanSDK setAllowRate:NO];
    [ChangyanSDK setAllowUpload:YES];
    [ChangyanSDK setAllowWeiboLogin:NO];
    [ChangyanSDK setAllowQQLogin:YES];
    [ChangyanSDK setAllowSohuLogin:NO];
    
    [ChangyanSDK setNavigationBackgroundColor:[UIColor blackColor]];
    [ChangyanSDK setNavigationTintColor:[UIColor whiteColor]];


    

    self.window = [[UIWindow alloc] initWithFrame:YPScreenBounds];
    [self.window makeKeyAndVisible];
    YPBaseNavigationController *navVc = [[YPBaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    YPLeftMenuController *leftVc = [[YPLeftMenuController alloc] init];
    YPSideController *sideVc = [[YPSideController alloc] initWithContentViewController:navVc leftMenuViewController:leftVc];
    sideVc.backgroundImage = [UIImage imageNamed:@"mine_sidebar_background"];
    sideVc.myDelegate = self;
    PaiXuViewController * vc = [PaiXuViewController new];
    self.window.rootViewController = sideVc;
    
    return YES;
}



- (void)sideVc:(YPSideController *)sideVc willShowMenuViewController:(UIViewController *)menuViewController
{
    [UIView animateWithDuration:0.35f animations:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

- (void)sideVc:(YPSideController *)sideVc willHideMenuViewController:(UIViewController *)menuViewController
{
    [UIView animateWithDuration:0.35f animations:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
@end
