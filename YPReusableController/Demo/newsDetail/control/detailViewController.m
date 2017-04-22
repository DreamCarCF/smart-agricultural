
#import "detailViewController.h"
#import "ConnectServer.h"
#import "DetailModel.h"
#import "DetialView.h"
#import "ChangyanSDK.h"
#import "UMSocial.h"
@interface detailViewController ()<UIScrollViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate,UIWebViewDelegate>
{
    DetialView *detailView;
    NSString * QRUrl;
    NSMutableArray *dataArry;
     NSString * shareDetialString;
}


@end

@implementation detailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        dataArry = [NSMutableArray new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor blackColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.text = @"智慧农业";
    
    self.navigationItem.titleView = titleLabel;
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"xq_06.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(share)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    
    
    
    [self readDetail];
    detailView = [[DetialView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40)];

    
    
    
    
    UIView *defaultBar = [ChangyanSDK getDefaultCommentBar:CGRectMake(10,self.view.frame.size.height-60,self.view.frame.size.width-20, 40)
                                            postButtonRect:CGRectMake(5, 5,self.view.frame.size.width-60, 35)
                                            listButtonRect:CGRectMake(self.view.frame.size.width-55, 5, 35, 35)
                                                  topicUrl:@""
                                             topicSourceID:self.newsdetailidStr
                                                   topicID:nil
                                                categoryID:self.newsdetailidStr
                                                topicTitle:nil
                                                    target:self];
    [self.view addSubview:defaultBar];
    
}

-(void)share
{
    
    NSArray * sharetoSNSArr = @[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToYXTimeline,UMShareToYXSession,UMShareToSms];
    UIImageView * newshareimgview = [[UIImageView alloc]init];
    [newshareimgview sd_setImageWithURL:[NSURL URLWithString:self.newsdetailPicStr]];
    UIImage * shareImg = newshareimgview.image;
    

    
    
    NSString *shareProductIDformat = @"http://www.nyxdt.com/m/view.php?aid=%@";
    NSString *shareProductIDStr = [NSString stringWithFormat:shareProductIDformat,self.newsdetailidStr];
    
    
    [self setShareData:@{@"title":shareDetialString,@"url":shareProductIDStr}];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMappKey
                                      shareText:shareDetialString
                                     shareImage:shareImg
                                shareToSnsNames:sharetoSNSArr
                                       delegate:self];
    
    
    
}


-(void)setShareData:(NSDictionary *) dict{
    
    
    //分享到腾讯微博内容
    [UMSocialData defaultData].extConfig.tencentData.title = [dict objectForKey:@"title"];
    //分享到微信好友内容
    [UMSocialData defaultData].extConfig.wechatSessionData.title = [dict objectForKey:@"title"];
    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [dict objectForKey:@"url"];
    //分享到微信朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [dict objectForKey:@"title"];
    [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [dict objectForKey:@"url"];
    //分享到QQ内容
    [UMSocialData defaultData].extConfig.qqData.title = [dict objectForKey:@"title"];
    [UMSocialData defaultData].extConfig.qqData.url = [dict objectForKey:@"url"];
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    //分享到QQ空间
    [UMSocialData defaultData].extConfig.qzoneData.title = [dict objectForKey:@"title"];
    [UMSocialData defaultData].extConfig.qzoneData.url = [dict objectForKey:@"url"];
}


- (void)readDetail
{
    QRUrl = knewDetailApi;
    ConnectServer * cs = [ConnectServer shareInstance];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setValue:self.newsdetailidStr forKey:@"aid"];
    NSLog(@"self.currentString====%@",self.newsdetailidStr);
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_detail",@"requestType", nil];
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
    
    [dataArry removeAllObjects];
    
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    if([requestType isEqualToString:@"get_detail"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            
            [SVProgressHUD dismiss];
            
            NSDictionary *newdic = [NSDictionary new];
                newdic = resultDict[@"data"];
                DetailModel *model = [DetailModel new];
                model.detailPageViewStr = newdic[@"click"];
                model.detailContentStr = newdic[@"content"];
                model.detailPubdateStr = newdic[@"pubdate"];
                shareDetialString=model.detailTitleStr = newdic[@"title"];
                model.detailTypeidStr = newdic[@"typeId"];
                model.detailTypeNameStr = newdic[@"typename"];
                model.detailWriterStr = newdic[@"writer"];
                [dataArry addObject:model];
            
                [detailView setWithArry:dataArry];
            detailView.detailContentWebView.scrollView.delegate = self;
            detailView.detailContentWebView.delegate= self;
                [self.view addSubview:detailView];
            detailView.backgroundColor = [UIColor clearColor];
            
            
        }else{
            NSLog(@"未知错误");
        }
    }else
    {
        NSLog(@"网络错误");
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.y==0) {
//        [UIView animateWithDuration:1.0 animations:^{
//            detailView.detailWriterLabel.hidden = NO;
//            detailView.detailContentWebView.frame = CGRectMake(0,144,self.view.frame.size.width,self.view.frame.size.height-184);
//            
//        } completion:^(BOOL finished) {
//          
//        }];
//
//       
//    }else if(scrollView.contentOffset.y>60)
//    {
//        [UIView animateWithDuration:1.0 animations:^{
//            
//            detailView.detailWriterLabel.hidden = YES;
//            detailView.detailContentWebView.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height-104);
//        } completion:^(BOOL finished) {
//            
//        }];
//       
//    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString * relative_Path = [request.mainDocumentURL absoluteString];
    
    NSLog(@"%@",relative_Path);
    
    NSRange range = [relative_Path rangeOfString:@"="];
    if(range.location != NSNotFound){
        
        NSString *productID = [relative_Path substringFromIndex:range.location+1];
        NSLog(@"%@",productID);
        if ([productID isEqualToString:@"1"]||[productID isEqualToString:@"2"]||[productID isEqualToString:@"3"]) {
            return true;
        }else{
            detailViewController *DetailVC = [detailViewController new];
            DetailVC.newsdetailidStr = productID;


            [self.navigationController pushViewController:DetailVC animated:NO];
            
            
            return false;
        }
    }
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
