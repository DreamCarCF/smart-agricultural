//
//  PaiXuViewController.m
//  YPReusableController
//
//  Created by zhiai on 16/3/9.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "PaiXuViewController.h"
#import "OrderViewController.h"
#import "OrderButton.h"
#import "TouchView.h"
#import "YPCacheTool.h"
#import "TopModel.h"
#import "ConnectServer.h"
@interface PaiXuViewController ()
{
    NSString *QRUrl;
    NSMutableArray * eArray;
    int countnum;
}
@property (nonatomic,retain) NSMutableArray *dataArr;
@end


@implementation PaiXuViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray new];
        eArray = [NSMutableArray new];
        countnum = 0 ;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self setDataWithNet];
   
}


- (void)setDataWithNet
{
    countnum = 0;
    QRUrl = knewApi;
    ConnectServer * cs = [ConnectServer shareInstance];
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_info",@"requestType", nil];
    [cs sendJsonData:nil baseURLWithString:QRUrl FromViewController:self];
    [SVProgressHUD show];
}
#pragma make - ASIhttp delegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    [eArray removeAllObjects];
    NSArray *channelTitleArray = [YPCacheTool channelTitleArray];
    
    if (!channelTitleArray) {
        [YPCacheTool removeChannelTitleArray];
    }
    
    
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    if([requestType isEqualToString:@"get_info"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            
            [SVProgressHUD dismiss];
            NSMutableArray *dataArry = resultDict[@"data"];
            for (NSDictionary *newdic in dataArry) {
                TopModel * model = [TopModel new];
                model.toptitleString = newdic[@"typename"];
                model.toptitleid = newdic[@"id"];
                NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                
                [userd setObject:data forKey:[NSString stringWithFormat:@"person%d",countnum++]];
                [userd synchronize];
                [eArray addObject:data];
                
            }
            [self gosetUserDeualt];
            NSLog(@"%@",eArray);
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            for (int i = 0; i<eArray.count; i++) {
                TopModel *ccc = (TopModel *)[NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"person%d",i]]];
                
                NSLog(@"ccc=%@",ccc.toptitleString);
                
            }
            
            
            
        }else{
            NSLog(@"未知错误");
        }
    }else
    {
        NSLog(@"网络错误");
    }
    
    
}
- (void)gosetUserDeualt
{
    NSArray *channelTitleArray = [YPCacheTool channelTitleArray];
    
    if (!channelTitleArray) {
        [YPCacheTool saveChannelTitleArray:eArray];
    }
    [self gosetVC];
}
- (void)gosetVC
{
    NSArray *newarray = [YPCacheTool channelTitleArray];
    NSMutableArray * newDataArr = [NSMutableArray new];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i<newarray.count; i++) {
        TopModel *ccc = (TopModel *)[NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"person%d",i]]];
        
        NSLog(@"ccc=%@",ccc.toptitleString);
        TopModel *newMoedel = [TopModel new];
        newMoedel.toptitleString = ccc.toptitleString;
        newMoedel.toptitleid = ccc.toptitleid;
        [newDataArr addObject:newMoedel];
    }
    
    
    if (!newDataArr) return;
    
    self.dataArr = [newDataArr mutableCopy];
    
    
    OrderButton * orderButton = [OrderButton orderButtonWithViewController:self titleArr:[NSArray arrayWithArray:self.dataArr] urlStringArr:[NSArray arrayWithArray:self.dataArr]];
    [self.view addSubview:orderButton];
    [self orderViewOut:orderButton];
    
    
    
    
}


- (void)orderViewOut:(id)sender{
    
    OrderButton * orderButton = (OrderButton *)sender;
    if([[orderButton.vc.view subviews] count]>1){
        //        [[[orderButton.vc.view subviews]objectAtIndex:1] removeFromSuperview];
        NSLog(@"%@",[orderButton.vc.view subviews]);
    }
    OrderViewController * orderVC =[[OrderViewController alloc] init];
    orderVC.titleArr = orderButton.titleArr;
    orderVC.urlStringArr = orderButton.urlStringArr;
    UIView * orderView = [orderVC view];
    [orderView setFrame:CGRectMake(0, - orderButton.vc.view.bounds.size.height, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)];
    [orderView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [orderVC.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderView];
    [self addChildViewController:orderVC];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [orderView setFrame:CGRectMake(0, 64, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
    
}


- (void)backAction{
    OrderViewController *  orderVC = [self.childViewControllers objectAtIndex:0];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//        [orderVC.view setFrame:CGRectMake(0, - self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
        
    } completion:^(BOOL finished){
        NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
        NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
        NSMutableArray * modelArr = [NSMutableArray array];
        
        
        for (TouchView * touchView in orderVC->_viewArr1) {
            [modelArr addObject:touchView.touchViewModel];
        }
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
        [data writeToFile:filePath atomically:YES];
        [modelArr removeAllObjects];
        for (TouchView * touchView in orderVC->_viewArr2) {
            [modelArr addObject:touchView.touchViewModel];
        }
        data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
        [data writeToFile:filePath1 atomically:YES];
//        [[[self.childViewControllers  objectAtIndex:0] view] removeFromSuperview];
//        [orderVC removeFromParentViewController];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
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
