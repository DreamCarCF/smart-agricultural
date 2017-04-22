//
//  FindPwdChangepwd.m
//  beloved999
//
//  Created by Sam Feng on 15/8/28.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//
#define kLoginUrl @"http://apiv.beloved999.com/newapi/" //登陆
#import "FindPwdChangepwd.h"
#import "ConnectServer.h"

@interface FindPwdChangepwd(){
    NSString *QRUrl;
}
@end

@implementation FindPwdChangepwd

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置新密码";
    // Do any additional setup after loading the view.
}

- (IBAction)changeNewpwd:(UIButton *)sender {
    if( [self.theRptPwd.text isEqualToString:self.theRptPwd.text] &&
        (![self.phone isEqualToString:@""])
     ){

        QRUrl = kLoginUrl;
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setValue:@"findPwd/reset_password" forKey:@"method"];
        [mulDic setValue:_theNewPwd.text forKey:@"password"];
        [mulDic setValue:_theRptPwd.text forKey:@"repassword"];
        [mulDic setValue:_code_token forKey:@"findpw_sid"];

        ConnectServer * cs = [ConnectServer shareInstance];
        cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"findPassword",@"requestType", nil];
        [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
        [SVProgressHUD show];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"二次输入的密码不一致！"];
    }
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
    if([requestType isEqualToString:@"findPassword"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功，现在去登录！"];
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:3];
        }else{
            [SVProgressHUD dismiss];
        }
    }
}
-(void)gotoLogin{
    NSArray * arr = self.navigationController.viewControllers;
    if(arr.count > 2){
        [self.navigationController popToViewController:[arr objectAtIndex:arr.count-3] animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
