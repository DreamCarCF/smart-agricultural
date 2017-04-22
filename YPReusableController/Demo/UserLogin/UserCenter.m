////
////  ViewControllerTwo.m
////  TestUserCenter
////
////  Created by Sam Feng on 15/12/14.
////  Copyright © 2015年 beloved999. All rights reserved.
////
//
//#import "UserCenter.h"
//#import "LoginAccountHead.h"
////#import "GuessYouLikeView.h"
//#import "UserLogin.h"
//#import "OrderListViewController.h"
//#import "MJoldRefresh.h"
//#import "settingUIViewController.h"
//#import "ConnectServer.h"
//#import "UserInfo.h" //用户信息单例类，信息共享
//#import "CGRectMakeRedefine.h"
//#import "UserFeedBack.h" //意见反馈
//#import "InvitationCode.h" //推广码（邀请码）
//#import "FavoriteList.h" //收藏列表
//#import "ReturnShopViewController.h"
//#import "ReceivingAddressList.h"
//#import "PrePaidCardRecharge.h"
//#import "MyRedEnvelope.h"
//#import "UserAssets.h"
//#import "FMDBManager.h"
//#import "cartModel.h"
//#import "SignIn.h"
//#import "MJRefresh.h"
//#import "MJRefreshAutoNormalFooter.h"
//
//@interface UserCenter ()<LoginAccountHeadDelegate,UIAlertViewDelegate>{//,MJRefreshBaseViewDelegate
//    NSString * QRUrl;
//    LoginAccountHead* loginAccountHead;
//    NSArray * messageArr;
//    BOOL _isDragDown;
//    BOOL isfootprint;
//    SignIn *signIn;
//    NSMutableArray *dataArry;
//}
//@end
//
//@implementation UserCenter
//
//NSDictionary* tableData;
//NSArray* stories;
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        dataArry = [NSMutableArray new];
//    }
//    return self;
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = NO;
//    self.navigationController.navigationBarHidden = YES;
//
//    if(loginAccountHead == nil){
//        loginAccountHead = [LoginAccountHead instanceView];
//        CGRect rect = CGRectMake(0, 0, _bannerView.frame.size.width, loginAccountHead.frame.size.height);
//        loginAccountHead.frame = rect;
//        
//        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//        loginAccountHead.delegate = self;
//        [loginAccountHead ShowPanelByLogin:token];
//        [_bannerView addSubview:loginAccountHead];
//    }
//    [self readUserInfo];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    tableData = [NSDictionary dictionaryWithObjectsAndKeys:
//                     [NSArray arrayWithObjects:@"我的钱包" ,nil] , @"1",
//                     [NSArray arrayWithObjects:@"全部订单",@"我的红包", @"我的评价"
//                      , @"我的收藏",@"我的足迹",@"我的推广",@"返修/退换", nil], @"2",
//                     [NSArray arrayWithObjects:@"地址管理", @"意见反馈",nil] , @"3",
//                     [NSArray arrayWithObjects:@"注销登录", nil] , @"4", nil];
//    
//    // 获取tableData的所有key排序后组成的数组
//    stories = [[tableData allKeys] sortedArrayUsingSelector:@selector(compare:)];
//
//    //messageIndex = 0;
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)){
//        //self.edgesForExtendedLayout = UIRectEdgeNone;
//        //自动滚动(VIEW视图下移)调整，默认为YES
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(readUserInfo)];
//    // 设置颜色
//    header.lastUpdatedTimeLabel.textColor = [UIColor clearColor];
//    //[header beginRefreshing];
//    // 设置刷新控件
//    self.tableView.header = header;
//    
//   
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return tableData.allKeys.count;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return  10;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//   NSString* story = [stories objectAtIndex:section];
//   NSArray * arr = [tableData objectForKey:story];
//   return arr.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 获取分区号
//    NSUInteger sectionNo = indexPath.section;
//    // 获取表格行的行号
//    NSUInteger rowNo = indexPath.row;
//    NSString* story = [stories objectAtIndex:sectionNo];
//    static NSString* cellId = @"cellId";
//    UITableViewCell* cell; //= [tableView dequeueReusableCellWithIdentifier:cellId];
//
//    if(indexPath.section == 0){
//          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//          cell.detailTextLabel.text = @"查看我的钱包";
//          cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//    }else if (indexPath.section == 1){
//         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//        if(rowNo == 0){
//            cell.detailTextLabel.text = @"查看订单";
//            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//        }
//        if(rowNo == 2){
//            cell.detailTextLabel.text = @"查看评价";
//            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//        }
//    }else{
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
//
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //cell的右边有一个小箭头
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = [[tableData objectForKey:story]
//                           objectAtIndex:rowNo];
//    NSString * imgName = [NSString stringWithFormat:@"user%lu_%ld.png",(unsigned long)sectionNo,(long)(indexPath.row+1)];
//    cell.imageView.image = [UIImage imageNamed:imgName];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    if(checkUserLogin(token)){
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"self" bundle:nil];
//        
//        if(indexPath.section == 0){
//            if(indexPath.row == 0){
//                UserAssets *userAssets = [storyBoard instantiateViewControllerWithIdentifier:@"UserAssets"];
//                self.navigationItem.backBarButtonItem = item;
//                self.navigationController.navigationBarHidden = NO;
//                [self.navigationController pushViewController:userAssets animated:YES];
//            }
//        }else if (indexPath.section == 1){
//            if(indexPath.row == 0){
//                [self gotoOrderList:nil];
//            }else if(indexPath.row == 1){
//                [self gotoMyRedEnvelope];
//            }else if (indexPath.row == 2){
//                 [self performSegueWithIdentifier:@"gotoCommitList" sender:nil];
//            }else if(indexPath.row == 3){
//                isfootprint = NO;
//                [self performSegueWithIdentifier:@"gotoFavoriteView" sender:nil];
//            }else if(indexPath.row == 4){
//                isfootprint = YES;
//                [self performSegueWithIdentifier:@"gotoFavoriteView" sender:nil];
//            }else if (indexPath.row == 5){
//                [self performSegueWithIdentifier:@"promotionQrcode" sender:nil];
//            }else if (indexPath.row == 6){
//                [self performSegueWithIdentifier:@"gotoReturnShpList" sender:nil];
//            }
//        }else if (indexPath.section == 2){
//            if(indexPath.row == 0){
//                ReceivingAddressList *receivingAddressList = [storyBoard instantiateViewControllerWithIdentifier:@"ReceivingAddress"];
//                self.navigationItem.backBarButtonItem = item;
//                self.navigationController.navigationBarHidden = NO;
//                [self.navigationController pushViewController:receivingAddressList animated:YES];
//            }else if (indexPath.row == 1){
//                UserFeedBack * userfeedBack = [[UserFeedBack alloc] initWithNibName:@"UserFeedBack" bundle:nil];
//                self.navigationItem.backBarButtonItem = item;
//                self.navigationController.navigationBarHidden = NO;
//                [self.navigationController pushViewController:userfeedBack animated:YES];
//                
//            }
//        }else if (indexPath.section == 3){
//            if(indexPath.row == 0){
//                [self loginOut];
//            }
//        }
//    }else{
//        [self gotoLoginView];
//    }
//}
//
//-(void)loginOut{
//    QRUrl = kLoginUrl;
//    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
//    [mulDic setValue:@"user/center/logout" forKey:@"method"];
//    [mulDic setValue:[LoginSession returnLoginSession] forKey:@"session"];
//    ConnectServer * cs = [ConnectServer shareInstance];
//    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"exitLogin",@"requestType", nil];
//    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
//}
//
//
//
//-(void)readUserInfo{
//    QRUrl = kLoginUrl;
//    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
//    [mulDic setValue:@"user/info" forKey:@"method"];
//    [mulDic setValue:[LoginSession returnLoginSession] forKey:@"session"];
//    ConnectServer * cs = [ConnectServer shareInstance];
//    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_user_info",@"requestType", nil];
//    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
//    [SVProgressHUD show];
//    
//}
//
//
//-(void)clearUIdata{
//    _OrderNum.text = @"0";
//    _collectionNum.text = @"0"; //收藏数量
//    _belovedCoin.text = @"0";
//    _MyOrderPrice.text = @"￥0.00元";
//    _redPackage.text = @"0"; //红包
//    _Integral.text = @"0"; //积分
//}
//
//-(void)loadFMDB
//{
//    FMDBManager * manager = [FMDBManager shareInstance];
//    //将product中所有记录都读出来
//    FMResultSet *rs =  [manager.dataBase executeQuery:@"select * from product"];
//    while ([rs next])
//    {
//        cartModel *model = [[cartModel alloc]init];
//        model.countnum = [rs stringForColumn:@"countnum"];
//        model.productid = [rs stringForColumn:@"goods_id"];
//        model.fmdbid =[rs intForColumn:@"id"];
//        
//        QRUrl = [NSString stringWithFormat:@"%@",knewApi];
//        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
//        NSString *token =  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//        NSString *member_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
//        NSMutableDictionary *session = [[NSMutableDictionary alloc]init];
//        
//        
//        [mulDic setValue:@"/cart/create" forKey:@"method"];
//        [session setValue:member_id forKey:@"uid"];
//        [session setValue:token forKey:@"sid"];
//        [mulDic setValue:session forKey:@"session"];
//        [mulDic setValue:[NSString stringWithFormat:@"%d",[model.countnum intValue]] forKey:@"number"];
//        [mulDic setValue:model.productid forKey:@"goods_id"];
//        //            [mulDic setValue:idArry forKey:@"spec"];
//        ConnectServer * cs = [ConnectServer shareInstance];
//        cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"edit_cart",@"requestType", nil];
//        [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
//        [SVProgressHUD show];
//    
//        
//        //删除
//        if (![manager.dataBase executeUpdate:@"delete from product where id = ?",@(model.fmdbid)])
//        {
//            NSLog(@"数据库删除失败");
//        }
//    }
// 
// 
//}
//
//-(void)gocart
//{
//    if ([self.panString isEqualToString:@"1"]) {
//        NSArray * viewControllerArr = self.navigationController.viewControllers;
//        UIViewController * root = [viewControllerArr objectAtIndex:0];
//        //切换回用户中心
//        [root.tabBarController setSelectedIndex:2];
//        [self.navigationController popToViewController:root animated:NO];
//        self.tabBarController.tabBar.hidden= NO;
//    }
//   
//}
//#pragma make - ASIhttp delegate
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
//}
//
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
//    NSString *response = [request responseString];
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSError *error;
//    NSDictionary * resultDict = [parser objectWithString:response error:&error];
//    
//    if ([requestType isEqualToString:@"get_user_info"]){
//        [SVProgressHUD dismiss];
//        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
//            NSDictionary * userInfodict = [resultDict objectForKey:@"data"];
//
//            _OrderNum.text = [userInfodict objectForKey:@"order_count"];
//            _collectionNum.text = [userInfodict objectForKey:@"collection_num"];
//            _MyOrderPrice.text = [NSString stringWithFormat:@"￥%@",[userInfodict objectForKey:@"user_money"]] ;
//            _redPackage.text = [userInfodict objectForKey:@"bonus_count"];
//            _Integral.text = [userInfodict objectForKey:@"user_points"];
//            _belovedCoin.text =  [userInfodict objectForKey:@"beloved_coin"]; //至爱币
//            
//            if(loginAccountHead != nil){
//                loginAccountHead.username.text = [userInfodict objectForKey:@"name"];
//                loginAccountHead.userLevel.text = [NSString stringWithFormat:@"等级：%@",[userInfodict objectForKey:@"rank_name"]];
//            }
//            //给单例赋值，全局共享属性
//            [UserInfo sharedManager].userName = [userInfodict objectForKey:@"name"];
//            [UserInfo sharedManager].bpoint = [userInfodict objectForKey:@"user_points"];
//            
//        }else{
//            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
//            [loginAccountHead ShowPanelByLogin:@""];
//        }
//        [self.tableView.header endRefreshing];
//    
//    }else if([requestType isEqualToString:@"member_sign"]){
//        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
//            [SVProgressHUD showSuccessWithStatus:[resultDict objectForKey:@"msg"]];
//        }else{
//            [SVProgressHUD showSuccessWithStatus:[resultDict objectForKey:@"msg"]];
//        }
//    }else if ([requestType isEqualToString:@"exitLogin"]){
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"member_id"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [self updateLoginAccountHead];
//        [self clearUIdata];
//        [SVProgressHUD showSuccessWithStatus:@"退出成功！"];
//    }
//}
//
//
//-(void)gotoOrderList:(NSString *)type{
//    OrderListViewController * orderList = [[OrderListViewController alloc] initWithNibName:@"OrderListViewController" bundle:nil];
//    orderList.orderType = type;
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
//    [self.navigationController pushViewController:orderList animated:YES];
//}
//
//
//-(void)updateLoginAccountHead{
//    if(loginAccountHead != nil){
//        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//        [loginAccountHead ShowPanelByLogin:token];
//    }
//}
//
//-(void)gotoSettingView{
//    settingUIViewController * settingVC = [[settingUIViewController alloc] initWithNibName:@"settingUIViewController" bundle:nil];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
//    [self.navigationController pushViewController:settingVC animated:YES];
//}
//
//-(void)gotoLoginView{
//    UserLogin * userlogin = [[UserLogin alloc] initWithNibName:@"UserLogin" bundle:nil];
//    [self.navigationController pushViewController:userlogin animated:YES];
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
//    
//    if ([segue.identifier isEqualToString:@"gotoFavoriteView"]){
//        FavoriteList *favoriteList = segue.destinationViewController;
//        if(isfootprint == YES){
//            favoriteList.PageType = @"footprint";
//        }else{
//            favoriteList.PageType = @"";
//        }
//    }else if([segue.identifier isEqualToString:@"gotoReturnShpList"]){
//        ReturnShopViewController *returnShopVC = segue.destinationViewController;
//        returnShopVC.hidesBottomBarWhenPushed = YES;
//    
//    }
//}
//
//
//- (IBAction)userSign:(id)sender {
//    UpdateUserIntegral updateUserIntegral = ^(NSUInteger Integral) {
//        NSUInteger Integral_textValue = [_Integral.text integerValue];
//        Integral_textValue += 5;
//        
//        _Integral.text = [NSString stringWithFormat:@"%lu",(unsigned long)Integral_textValue];
//    };
//    signIn = [[SignIn alloc] init:updateUserIntegral];
//    [signIn userSignIn];
//}
//
//
//- (IBAction)gotoOtherView:(UIButton *)sender {
//    switch (sender.tag) {
//        case 11:
//            [self gotoOrderList:nil]; //我的订单
//            break;
//        case 12:
//            isfootprint = NO;
//            [self performSegueWithIdentifier:@"gotoFavoriteView" sender:nil];
//            break;
//        case 13:
//            [self gotoMyRedEnvelope];
//            break;
//        default:
//            break;
//    }
//}
//
//-(void)gotoMyRedEnvelope{
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"self" bundle:nil];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    MyRedEnvelope *myRedEnvelope = [storyBoard instantiateViewControllerWithIdentifier:@"MyRedEnvelope"];
//    self.navigationItem.backBarButtonItem = item;
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController pushViewController:myRedEnvelope animated:YES];
//}
//@end
