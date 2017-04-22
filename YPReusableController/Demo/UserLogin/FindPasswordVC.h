//
//  findPasswordVC.h
//  beloved999
//
//  Created by Sam Feng on 15/8/27.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPasswordVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userPhone;

@property (weak, nonatomic) IBOutlet UITextField *inputCode;

@property (weak, nonatomic) IBOutlet UIButton *BtnNext;

@property (weak, nonatomic) IBOutlet UIButton *getCheckCode;

@property (weak, nonatomic) IBOutlet UILabel *ResendText;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UITextField *checkImgCode;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnNextTop;


@end
