//
//  UserLogin.m
//  beloved999
//
//  Created by Sam Feng on 15/8/14.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import "UserLogin.h"
#import "ConnectServer.h"
#import "userRegisterVC.h"
#import "FindPasswordVC.h"
#import "UserCenter.h"
#import <QuartzCore/QuartzCore.h>

@interface UserLogin ()<UITextFieldDelegate>{
    NSString * QRUrl;
}
@end

@implementation UserLogin


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登陆";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self config];
    // Do any additional setup after loading the view from its nib.
}

-(void)config{
    _userName.delegate = self;
    _password.delegate = self;
   self.loginBtn.layer.masksToBounds = YES;
   
    NSString* userNameStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if(userNameStr != nil){
        _userName.text = userNameStr;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLogin:(UIButton *)sender {
    NSString * userName = self.userName.text;
    NSString * passWord = self.password.text;
    if([userName isEqualToString:@""] || [passWord isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"账号、密码不能为空！"];
    }else{
        QRUrl = [NSString stringWithFormat:@"%@",kNewLoginApi];
        ConnectServer * cs = [ConnectServer shareInstance];
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
   
        [mulDic setValue:userName forKey:@"userid"];
        [mulDic setValue:passWord forKey:@"pwd"];
        [mulDic setValue:@"login" forKey:@"act"];
        
        cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"userLogin",@"requestType", nil];
        [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
    }
}

#pragma make - ASIhttp delegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    
    if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
        //本地保存token和 member_id

        [SVProgressHUD showErrorWithStatus:resultDict[@"msg"]];
        NSString * sessionStr = [[resultDict objectForKey:@"data"] objectForKey:@"mid"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:sessionStr forKey:@"mid"];
        NSLog(@"sid = %@",sessionStr);
//      [defaults setObject:_userName.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        NSDictionary * sessionDict = [[resultDict objectForKey:@"data"] objectForKey:@"session"];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:[sessionDict objectForKey:@"uid"] forKey:@"member_id"];
//        [defaults setObject:[sessionDict objectForKey:@"sid"] forKey:@"token"];
//        NSLog(@"sid = %@",[sessionDict objectForKey:@"sid"]);
//        [defaults setObject:_userName.text forKey:@"userName"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
      
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"]];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
}

- (IBAction)passwordReturn:(UITextField *)sender{
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
}

- (IBAction)gotoRegister:(UIButton *)sender {
    userRegisterVC * userregister = [[userRegisterVC alloc] initWithNibName:@"userRegisterVC" bundle:nil];
    [self.navigationController pushViewController:userregister animated:YES];
}

- (IBAction)findUserPassword:(UIButton *)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"self" bundle:nil];
    FindPasswordVC * findPasswordVC = [storyBoard instantiateViewControllerWithIdentifier:@"FindPasswordVC"];
    [self.navigationController pushViewController:findPasswordVC animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if((![_userName.text isEqualToString:@""]) && (![_password.text isEqualToString:@""])){
//        _loginBtn.backgroundColor = [UIColor redColor];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end