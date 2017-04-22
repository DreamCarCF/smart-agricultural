//
//  SearchViewController.m
//  beloved999
//
//  Created by zhiai on 15/12/17.
//  Copyright © 2015年 beloved999. All rights reserved.
//

#import "SearchViewController.h"
#import "TestViewController_10.h"
#import "detailViewController.h"
#import "JSTextFiled.h"
#import "ConnectServer.h"
#import "newTabelViewController.h"
#define CancelButtonWidth 44
#define CancelButtonHeight 44
@interface SearchViewController ()
{
    NSString *QRUrl;
    NSString *keyword;
    NSString *cat_id;
    NSString *brand_id;
    NSMutableArray *dataArry;
}
@property (nonatomic,strong) JSTextFiled *searchField;
@property (nonatomic,strong) UIView *SecondView;
@end

@implementation SearchViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        dataArry = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    [self setTopView];
    [self setSearchView];

}


#pragma mark-----ASIHTTPdelegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}

//网络请求并加载数据
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    
    if([requestType isEqualToString:@"defaultContent"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            [SVProgressHUD dismiss];
            [dataArry removeAllObjects];
            dataArry = resultDict[@"data"];
//            [self setTuiJian];
        }else{
            [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"]];
        }
    }
}



-(void)jumpTo:(UIButton *)button;
{
    
    
    keyword = button.titleLabel.text;
    self.navigationController.navigationBar.hidden=NO;
    [self performSegueWithIdentifier:@"gotoListFromfirst" sender:self];
    
    
}

#pragma mark ---------顶部窗口的设置
- (void)setTopView
{
    UILabel*topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    topLabel.text = @"关键搜索";
    topLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64,self.view.frame.size.width , 2)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, CancelButtonWidth, CancelButtonHeight)];
    [CancelButton setTitle:@"返回" forState:UIControlStateNormal];
    [CancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [CancelButton addTarget:self action:@selector(backToNewHome) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:topLabel];
    [self.view addSubview:CancelButton];
    [self.view addSubview:lineLabel];
}

#pragma mark-------设置搜索框
- (void)setSearchView
{
    
    
    UIImage *usernameImage = [UIImage imageNamed:@"nav_magnifier_d.png"];
    UIImageView *usernameIcon = [[UIImageView alloc] initWithImage:usernameImage];
    usernameIcon.frame = CGRectMake(0, 0, 40, 40);
    //    usernameIcon.userInteractionEnabled=YES;
    self.searchField = [[JSTextFiled alloc] initWithFrame:CGRectMake(20,120,self.view.frame.size.width-40, 40) drawingLeft:usernameIcon];
    self.searchField.placeholder = @"搜索新闻";
    self.searchField.font= [UIFont systemFontOfSize:14];
    self.searchField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchField.layer.borderWidth = 3;
    self.searchField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchField setReturnKeyType:UIReturnKeySearch];
    [self.searchField addTarget:self action:@selector(gotoSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.searchField];
    
    
    
    
    
    
}




- (void)gotoSearch:(JSTextFiled *)sender
{
    keyword = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    TestViewController_10 *testVC = [TestViewController_10 new];
    testVC.idNewStr = keyword;
    [self.navigationController pushViewController:testVC animated:NO];
    
    
    
}





#pragma mark----------取消按钮
- (void)backToNewHome
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
