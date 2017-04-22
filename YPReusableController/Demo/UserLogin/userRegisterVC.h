//
//  userRegister.h
//  beloved999
//
//  Created by Sam Feng on 15/8/15.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userRegisterVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *goNextPage;

@property (weak, nonatomic) IBOutlet UITextField *InviteCode;

@property (weak, nonatomic) IBOutlet UIButton *acceptProtocol;

@property (weak, nonatomic) IBOutlet UITextField *userPhone;

@property (weak, nonatomic) IBOutlet UITextField *TFPassword;

@property (weak, nonatomic) IBOutlet UITextField *TFRePassword;

@property (weak, nonatomic) IBOutlet UITextField *verificationCode;

@property (weak, nonatomic) IBOutlet UIButton *btnVerificationCode;

@property (weak, nonatomic) IBOutlet UIView *registerSuccessView;

@end
