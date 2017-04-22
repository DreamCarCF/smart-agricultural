//
//  MyView.h
//  testViewFromXib
//
//  Created by Fang Jian on 14-9-13.
//  Copyright (c) 2014年 Jian Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginAccountHeadDelegate <NSObject>
@required //必须实现的方法
-(void)gotoLoginView;
-(void)gotoSettingView;
@end


@interface LoginAccountHead:UIView
//未登录
@property (weak, nonatomic) IBOutlet UIView *non_loginView;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

//已登录
@property (weak, nonatomic) IBOutlet UIView *loginedView;

//@property (weak, nonatomic) IBOutlet UIButton *headIcon;

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *userLevel;

//@property (weak, nonatomic) IBOutlet UILabel *userScore;


@property (nonatomic,retain) id<LoginAccountHeadDelegate> delegate;

-(void)ShowPanelByLogin:(NSString *)token;

+(LoginAccountHead *)instanceView;
@end
