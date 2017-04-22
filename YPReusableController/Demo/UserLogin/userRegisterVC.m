//
//  userRegister.m
//  beloved999
//
//  Created by Sam Feng on 15/8/15.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import "userRegisterVC.h"
#import <QuartzCore/QuartzCore.h>
#import "UserLogin.h"
#import "ConnectServer.h"

@interface userRegisterVC ()<UITextFieldDelegate>{
    BOOL isAccept;
    NSString *QRUrl;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@end

@implementation userRegisterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"新用户注册";
    [self setup];
    isAccept = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    _userPhone.delegate = self;
    _InviteCode.delegate = self;
    _nameTextField.delegate = self;
    _mailTextField.delegate = self;
    _PhoneNumberTextField.delegate = self;
    self.goNextPage.layer.masksToBounds = YES;
   
    _registerSuccessView.backgroundColor = [UIColor whiteColor];
    _registerSuccessView.hidden = YES;
}

- (IBAction)goNextSetp:(UIButton *)sender {
    if(isAccept == YES){
        QRUrl =  kNewRegiestApi;
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
//        [mulDic setValue:@"/user/signup" forKey:@"method"];
        [mulDic setValue:_userPhone.text forKey:@"userid"];
        [mulDic setValue:_TFPassword.text forKey:@"userpwd"];
        [mulDic setValue:_TFRePassword.text forKey:@"userpwdok"];
//        [mulDic setValue:_verificationCode.text forKey:@"mobile_code"];
        [mulDic setValue:_nameTextField.text forKey:@"truename"];
        [mulDic setValue:_mailTextField.text forKey:@"email"];
        [mulDic setValue:_PhoneNumberTextField.text forKey:@"mobile"];
     
        ConnectServer * cs = [ConnectServer shareInstance];
        cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"checkUserPhone",@"requestType", nil];
        [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
        [SVProgressHUD show];
    }
}

- (IBAction)changeAcceptProtocol:(id)sender {
    isAccept = !isAccept;
    if(isAccept == YES){
        [self.acceptProtocol setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else{
       [self.acceptProtocol setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
}
//
//-(IBAction)getverificationCode:(UIButton *)sender{
//    QRUrl = kLoginUrl;
//    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
//    [mulDic setValue:@"/sms/app_register" forKey:@"method"];
//    [mulDic setValue:_userPhone.text forKey:@"mobile_phone"];
//    
//    ConnectServer * cs = [ConnectServer shareInstance];
//    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"getverificationCode",@"requestType", nil];
//    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
//    [SVProgressHUD show];
//}


#pragma make - ASIhttp delegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    if([requestType isEqualToString:@"getverificationCode"]){
         if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
             [SVProgressHUD showSuccessWithStatus:[resultDict objectForKey:@"msg"]];
         }
    }else if([requestType isEqualToString:@"checkUserPhone"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
             [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:resultDict[@"msg"]];
            NSString * sessionStr = [[resultDict objectForKey:@"data"] objectForKey:@"mid"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:sessionStr forKey:@"mid"];
           
            [[NSUserDefaults standardUserDefaults] synchronize];
            _registerSuccessView.hidden = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"]];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (textField == _userPhone) {
        if (string.length == 0) return YES;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }else if (textField == _InviteCode){
        if (string.length == 0) return YES;
        if (existedLength - selectedLength + replaceLength > 6) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)gotoLogin:(UIButton *)sender {
    NSArray * arr = self.navigationController.viewControllers;
    for(id obj in arr){
        if([obj isKindOfClass:[UserLogin class]]){
            [self.navigationController popToViewController:obj animated:YES];
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_userPhone resignFirstResponder];
    [_nameTextField resignFirstResponder];
    [_PhoneNumberTextField resignFirstResponder];
    [_mailTextField resignFirstResponder];
    [_TFPassword resignFirstResponder];
    [_TFRePassword resignFirstResponder];
    [_verificationCode resignFirstResponder];
    [_InviteCode resignFirstResponder];
}


@end
