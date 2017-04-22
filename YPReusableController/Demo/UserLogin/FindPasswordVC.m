//
//  findPasswordVC.m
//  beloved999
//
//  Created by Sam Feng on 15/8/27.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//
#define kLoginUrl @"http://apiv.beloved999.com/newapi/" //登陆
#import "FindPasswordVC.h"
#import "ConnectServer.h"
#import "FindPwdChangepwd.h"

@interface FindPasswordVC (){
    NSString *QRUrl;
    NSString *checkCodeID;
}
@property (assign,nonatomic) NSInteger timeCount;
@property (strong,nonatomic) NSString *findpw_sid;
@end

@implementation FindPasswordVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup{
    _checkImgCode.hidden = YES;
    self.ResendText.hidden = YES;
    _secondView.hidden = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.title = @"找回密码";
}

- (IBAction)getMessageCode:(UIButton *)sender {
    QRUrl = kLoginUrl;
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];

    [mulDic setValue:_userPhone.text forKey:@"mobile_phone"];
    [mulDic setValue:@"/sms/app_validate" forKey:@"method"];
   
    ConnectServer * cs = [ConnectServer shareInstance];
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"sendCheckCode",@"requestType", nil];
    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
    
    
    self.getCheckCode.hidden = YES;
    self.ResendText.hidden = NO;
    self.ResendText.text = @"重新发送(60)";
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(timeCount:)
                                   userInfo:nil
                                    repeats: YES];
    
    
    [SVProgressHUD show];
}

- (void)timeCount:(NSTimer*) timer
{
    self.timeCount++;
    self.ResendText.text = [NSString stringWithFormat:@"重新发送(%ld)",(60 - self.timeCount)];
    if(self.timeCount >= 60)
    {
        self.getCheckCode.hidden = NO;
        self.ResendText.hidden = YES;
        [timer invalidate];
        self.timeCount = 0;
    }
}


- (IBAction)nextStep:(id)sender {
        QRUrl = kLoginUrl;
        ConnectServer * cs = [ConnectServer shareInstance];
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    
    if(_findpw_sid == nil){
        [mulDic setValue:@"findPwd/check_username" forKey:@"method"];
        [mulDic setValue:_userPhone.text forKey:@"u_name"];
        cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"check_username",@"requestType", nil];
    }else{
        [mulDic setValue:@"findPwd/validate" forKey:@"method"];
        [mulDic setValue:_findpw_sid forKey:@"findpw_sid"];
        [mulDic setValue:@"mobile_phone" forKey:@"validate_type"];
        [mulDic setValue:_inputCode.text forKey:@"mobile_code"];
        cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"validate",@"requestType", nil];
    }
    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
    [SVProgressHUD show];
}

#pragma make - ASIhttp delegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    
    if([requestType isEqualToString:@"sendCheckCode"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            [SVProgressHUD showSuccessWithStatus:[resultDict objectForKey:@"msg"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"]];
        }
    }else if([requestType isEqualToString:@"check_username"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            [SVProgressHUD dismiss];
            NSDictionary * dataDict = [resultDict objectForKey:@"data"];
            _findpw_sid = [dataDict objectForKey:@"findpw_sid"];
            _secondView.hidden = NO;
            //_userPhone.text = [dataDict objectForKey:@"value"];
            _userPhone.enabled = NO;
            //添加约束高度
            _BtnNextTop.constant = 78;
            
         }else{
            [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"]];
        }
    }else if([requestType isEqualToString:@"validate"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            [SVProgressHUD dismiss];
            FindPwdChangepwd * findpwdchangeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FindPwdChangepwd"];
            findpwdchangeVC.phone = _userPhone.text;
            findpwdchangeVC.code_token = _findpw_sid;
            [self.navigationController pushViewController:findpwdchangeVC animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"]];
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.userPhone resignFirstResponder];
    [self.inputCode resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
