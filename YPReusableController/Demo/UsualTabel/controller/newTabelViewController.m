//
//  newTabelViewController.m
//  YPReusableController
//
//  Created by zhiai on 16/2/23.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT 260

#import "newTabelViewController.h"
#import "CustomTableViewCell.h"
#import "detailViewController.h"
#import "ConnectServer.h"
#import "ListModel.h"
#import "MJRefresh.h"
#import "CFUITapGestureRecognizer.h"
#import "AutoSlideScrollView.h"
#import "AFNetworking.h"
#import "NewData.h"
#import "MJExtension.h"
#import "TopData.h"
#import "NewDataFrame.h"
#import "MJRefresh.h"
#import "SDCycleScrollView.h"
#import "TopViewController.h"
#import "MBProgressHUD+MJ.h"
#import "JSTextFiled.h"
#import "TestViewController_10.h"
#import "SearchViewController.h"

@interface newTabelViewController ()<SDCycleScrollViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    NSString *QRUrl;
NSString *keyword;
    NSMutableArray*dataArry;
    int number;
    BOOL _isDrog;
    NSMutableArray *bannerArry;
}
@property (nonatomic , strong) AutoSlideScrollView *mainScorllView;
@property (nonatomic,strong) JSTextFiled *searchField;
@property (nonatomic , strong) NSMutableArray *totalArray;
@property (nonatomic , strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic , strong) NSMutableArray *topArray;
@property (nonatomic , strong) NSMutableArray *titleArray;
@property (nonatomic , strong) NSMutableArray *imagesArray;

@property (nonatomic , strong) UITableView *tableview;
@property (nonatomic , assign) int page;
@end

@implementation newTabelViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isDrog = YES;
        dataArry = [NSMutableArray new];
        bannerArry = [NSMutableArray new];
        number =1;
    }
    return self;
}


-(NSMutableArray *)totalArray
{
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}
-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
-(NSMutableArray *)topArray
{
    if (!_topArray) {
        
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}



- (void)logTheKeyword:(NSString *)theWord
{
    
    QRUrl = [NSString stringWithFormat:@"%@",knewListApi];
    NSLog(@"QRUrl==%@",QRUrl);
    ConnectServer * cs = [ConnectServer shareInstance];
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"theKeyWord",@"requestType", nil];
    NSMutableDictionary * newdic = [[NSMutableDictionary alloc]init];
    [newdic setValue:theWord forKey:@"keyword"];
    [cs sendJsonData:newdic baseURLWithString:QRUrl FromViewController:self];
    [SVProgressHUD show];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.searchField endEditing:YES];
}

- (void)logThetid:(NSString *)tid
{
    self.currentString =tid;
    [self readList];
    [self readBanner];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchField endEditing:YES];
    
    
//    [self initTopNet];
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"CustomTableViewCell"];
    
   
 self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(readList)];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)loadMoreData
{
    _isDrog = NO;
    number ++;
    [self readList];
    
    
}

- (void)readList
{
    QRUrl = knewListApi;
    ConnectServer * cs = [ConnectServer shareInstance];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    if (self.theKeyWord) {
        [mulDic setValue:self.theKeyWord forKey:@"keyword"];
    }else{
    [mulDic setValue:self.currentString forKey:@"tid"];
    }
    NSLog(@"self.currentString====%@",self.currentString);
    [mulDic setValue:[NSString stringWithFormat:@"%d",number] forKey:@"page"];
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_list",@"requestType", nil];
    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
    [SVProgressHUD show];
}

-(void)readBanner
{
    QRUrl = knewListApi;
    ConnectServer * cs = [ConnectServer shareInstance];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setValue:self.currentString forKey:@"tid"];
    [mulDic setValue:@"i" forKey:@"flag"];
    NSLog(@"self.currentString====%@",self.currentString);
//    [mulDic setValue:[NSString stringWithFormat:@"%d",number] forKey:@"page"];
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_banner",@"requestType", nil];
    [cs sendJsonData:mulDic baseURLWithString:QRUrl FromViewController:self];
}


-(void)initTopNet
{
    //网易顶部滚动
    //   http://c.m.163.com/nc/article/headline/T1348647853363/0-1.html
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *dataarray = [TopData objectArrayWithKeyValuesArray:responseObject[@"T1348647853363"][0][@"ads"]];
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        NSMutableArray *titleArray = [NSMutableArray array];
        NSMutableArray *topArray = [NSMutableArray array];
        for (TopData *data in dataarray) {
            
            [topArray addObject:data];
            [statusFrameArray addObject:data.imgsrc];
            [titleArray addObject:data.title];
        }
        [self.topArray addObjectsFromArray:topArray];
        [self.imagesArray addObjectsFromArray:statusFrameArray];
        [self.titleArray addObjectsFromArray:titleArray];
        NSLog(@"%@",self.imagesArray);
        NSLog(@"%@",self.topArray);
        NSLog(@"%@",self.titleArray);
        [self initScrollView];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

-(void)initScrollView
{
    UIView * newView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT+40)];
    UIImage *usernameImage = [UIImage imageNamed:@"nav_magnifier_d.png"];
    UIImageView *usernameIcon = [[UIImageView alloc] initWithImage:usernameImage];
    usernameIcon.frame = CGRectMake(0, 0, 40, 40);
    //    usernameIcon.userInteractionEnabled=YES;
    self.searchField = [[JSTextFiled alloc] initWithFrame:CGRectMake(20,0,self.view.frame.size.width-40, 40) drawingLeft:usernameIcon];
    self.searchField.placeholder = @"搜索新闻";
    self.searchField.delegate = self;
    self.searchField.font= [UIFont systemFontOfSize:14];
    self.searchField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchField.layer.borderWidth = 3;
    self.searchField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchField setReturnKeyType:UIReturnKeySearch];
    [self.searchField addTarget:self action:@selector(gotoSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [newView addSubview:self.searchField];
    
    
    
    // 网络加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT) imageURLStringsGroup:self.imagesArray];
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup = self.titleArray;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.autoScrollTimeInterval = 6.0;
    [newView addSubview:cycleScrollView];
    self.tableView.tableHeaderView = newView;
}




- (void)gotoSearch:(JSTextFiled *)sender
{
    keyword = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    TestViewController_10 *testVC = [TestViewController_10 new];
    testVC.idNewStr = keyword;
    [self.navigationController pushViewController:testVC animated:NO];
    
    
    
}
#pragma mark 图片轮播 delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    //  http://c.3g.163.com/photo/api/set/0096/77789.json
//    TopData *data = self.topArray[index];
//    NSString *url = [data.url substringFromIndex:9];
//    url = [NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/0001/%@.json",url];
    
//    TopViewController *topVC = [[TopViewController alloc]init];
//    topVC.url = url;
    detailViewController *detailVC = [detailViewController new];
    TopData *data = self.topArray[index];
    detailVC.newsdetailidStr = data.idStr;
    [self.searchField endEditing:YES];
    [self.navigationController pushViewController:detailVC animated:YES];

}



#pragma make - ASIhttp delegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (_isDrog) {
        [dataArry removeAllObjects];
        [self.imagesArray removeAllObjects];

    }
    
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    if([requestType isEqualToString:@"get_list"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            
            [SVProgressHUD dismiss];
            NSMutableArray *datanewArry = resultDict[@"data"];
            for (NSDictionary *newdic in datanewArry) {
                
                ListModel *model = [ListModel new];
                 model.contexttitleStr = newdic[@"title"];
                 model.contexttimeStr = newdic[@"pubdate"];
                 model.contextpicStr = newdic[@"litpic"];
                 model.contextidStr = newdic[@"id"];
                model.contextfcnumberStr = newdic[@"fc"];
                model.contextlessInforStr = newdic[@"description"];
                  model.contextimgArry = newdic[@"imglist"];
                model.contextPanDuanStr = newdic[@"channel"];
                model.contextImgCount = newdic[@"img_cnt"];
                [dataArry addObject:model];
                
                
            }
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];

            
        }else{
            NSLog(@"未知错误");
        }
    }else if ([requestType isEqualToString:@"get_banner"])
    {
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            
            NSMutableArray *dataarray = resultDict[@"data"];
            NSMutableArray *statusFrameArray = [NSMutableArray array];
            NSMutableArray *titleArray = [NSMutableArray array];
            NSMutableArray *topArray = [NSMutableArray array];
            for (NSDictionary *newdic in dataarray) {
                TopData *data = [TopData new];
                data.idStr = newdic[@"id"];
                [topArray addObject:data];
                [statusFrameArray addObject:newdic[@"litpic"]];
                [titleArray addObject:newdic[@"title"]];
            }
            [self.topArray addObjectsFromArray:topArray];
            [self.imagesArray addObjectsFromArray:statusFrameArray];
            [self.titleArray addObjectsFromArray:titleArray];
            NSLog(@"%@",self.imagesArray);
            NSLog(@"%@",self.topArray);
            NSLog(@"%@",self.titleArray);
            [self initScrollView];

            
        }
    }
    else if ([requestType isEqualToString:@"theKeyWord"])
    {
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
        
        [SVProgressHUD dismiss];
        NSMutableArray *datanewArry = resultDict[@"data"];
        for (NSDictionary *newdic in datanewArry) {
            
            ListModel *model = [ListModel new];
            model.contexttitleStr = newdic[@"title"];
            model.contexttimeStr = newdic[@"pubdate"];
            model.contextpicStr = newdic[@"litpic"];
            model.contextidStr = newdic[@"id"];
            model.contextfcnumberStr = newdic[@"fc"];
            model.contextlessInforStr = newdic[@"description"];
          
            [dataArry addObject:model];
            
            
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
        
        
    }
        
    }
    else
    {
        NSLog(@"网络错误");
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (dataArry.count>0) {
        return dataArry.count;
    }else{
    return 10;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];

    if(dataArry.count>0)
    {
        
        ListModel *model = dataArry[indexPath.row];
       
        if (model.contextimgArry.count==3) {
            cell.titleLabel.hidden= YES;
            cell.listpicimg.hidden = YES;
            cell.lessInforLabel.hidden = YES;
            cell.ThreeimgThirdimg.hidden = NO;
            cell.ThreeimgSecimg.hidden = NO;
            cell.ThreeimgFirstimg.hidden = NO;
            cell.ThreeimgTitleLabel.hidden = NO;
            cell.PhotoCount.hidden = NO;
            cell.ThreeimgTitleLabel.text = model.contexttitleStr;
            [cell.ThreeimgFirstimg sd_setImageWithURL:model.contextimgArry[0]];
            [cell.ThreeimgSecimg sd_setImageWithURL:model.contextimgArry[1]];
            [cell.ThreeimgThirdimg sd_setImageWithURL:model.contextimgArry[2]];
            cell.fcnumberLabel.text = [NSString stringWithFormat:@"%@评", model.contextfcnumberStr];
            cell.PhotoCount.text = [NSString stringWithFormat:@"%@图",model.contextImgCount];
            cell.timeLabel.text = model.contexttimeStr;
        }else
        {
            cell.PhotoCount.hidden = YES;
            cell.ThreeimgThirdimg.hidden = YES;
            cell.ThreeimgSecimg.hidden = YES;
            cell.ThreeimgFirstimg.hidden = YES;
            cell.ThreeimgTitleLabel.hidden = YES;
            cell.titleLabel.hidden= NO;
            cell.listpicimg.hidden = NO;
            cell.lessInforLabel.hidden = NO;
        cell.titleLabel.text = model.contexttitleStr;
        cell.timeLabel.text = model.contexttimeStr;
        cell.fcnumberLabel.text = [NSString stringWithFormat:@"%@评", model.contextfcnumberStr];
        [cell.listpicimg sd_setImageWithURL:[NSURL URLWithString:model.contextpicStr]];
        cell.lessInforLabel.text = model.contextlessInforStr;
        }
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArry.count>0) {
        
    
    
    ListModel *model = dataArry[indexPath.row];
    NSLog(@"%ld",model.contextimgArry.count);
    if (model.contextimgArry.count==3) {
        return 160;
    }else
    {
    return 90;
    }
    }else
    {
        return 90;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld",indexPath.row);
    
    ListModel *model = dataArry[indexPath.row];
    if ([model.contextPanDuanStr isEqualToString:@"2"]) {
        TopViewController * topVC = [TopViewController new];
        topVC.url = model.contextidStr;

        [self.navigationController pushViewController:topVC animated:YES];
    }else{
    detailViewController *detailVC = [[detailViewController alloc]init];
    detailVC.newsdetailidStr = model.contextidStr;
    detailVC.newsdetailPicStr = model.contextpicStr;
        [self.searchField endEditing:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
            SearchViewController *channelCustomVc = [[SearchViewController alloc] init];
           [self.navigationController pushViewController:channelCustomVc animated:YES];
    [self.searchField endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchField endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [self.searchField resignFirstResponder];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
