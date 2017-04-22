//
//  UserLogin.h
//  beloved999
//
//  Created by Sam Feng on 15/8/14.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLogin : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIButton *quickRegister;
@property (nonatomic,copy) NSString * panduanString;

@end
