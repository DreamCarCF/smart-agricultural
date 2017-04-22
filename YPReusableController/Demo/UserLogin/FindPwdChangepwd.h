//
//  FindPwdChangepwd.h
//  beloved999
//
//  Created by Sam Feng on 15/8/28.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPwdChangepwd : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@property (weak, nonatomic) IBOutlet UITextField *theNewPwd;

@property (weak, nonatomic) IBOutlet UITextField *theRptPwd;

@property (strong,nonatomic) NSString *phone;

@property (strong,nonatomic) NSString *code_token;

@property (strong,nonatomic) NSString *member_id;


@end
