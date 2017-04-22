//
//  TopViewController.m
//  新闻
//
//  Created by gyh on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

#import "TopViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TopData.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "ConnectServer.h"
#import "ChangyanSDK.h"

@interface TopViewController ()<UIScrollViewDelegate>
{
    NSString *QRUrl;

}
@property (nonatomic , weak) UIScrollView *scroll;
@property (nonatomic , weak) UILabel *titleLabel;
@property (nonatomic , weak) UILabel *countLabel;
@property (nonatomic , weak) UITextView *textview;
@property (nonatomic , strong) TopData *topdata;

@property (nonatomic , assign) int count;
@property (nonatomic , copy) NSString *setname;
@property (nonatomic , strong) NSMutableArray *totalArray;

@property (nonatomic , weak) UIImageView *imageV;




@end

@implementation TopViewController

-(NSMutableArray *)totalArray
{
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initUI];
    
    [self readNetWork];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)initUI
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 20)];
    scroll.backgroundColor = [UIColor blackColor];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    self.scroll = scroll;
    
    //返回按钮
    UIButton *backbtn = [[UIButton alloc]init];
    backbtn.frame = CGRectMake(5, 25, 30, 30);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    //下载按钮
    UIButton *downbtn = [[UIButton alloc]init];
    downbtn.frame = CGRectMake(SCREEN_WIDTH - 5 - 40, backbtn.frame.origin.y, 40, 40);
    [downbtn setBackgroundImage:[UIImage imageNamed:@"arrow237"] forState:UIControlStateNormal];
    [downbtn addTarget:self action:@selector(downClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downbtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(5, SCREEN_HEIGHT - 70 - 49-40, SCREEN_WIDTH - 55, 20);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    self.titleLabel.hidden= YES;
    //数量
//    CGRectGetMaxX(titleLabel.frame)+5
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.frame.origin.y, 50, 15)];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.text = @"16/50";
    [self.view addSubview:countLabel];
    self.countLabel = countLabel;
    
    //内容
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH - 15, 60)];
    textview.editable = NO;
    textview.font = [UIFont systemFontOfSize:14];
    textview.textAlignment = NSTextAlignmentLeft;
    textview.textColor = [UIColor whiteColor];
    textview.backgroundColor = [UIColor clearColor];
    textview.textColor = [UIColor whiteColor];
    [self.view addSubview:textview];
    self.textview = textview;
    
    
    UIView *defaultBar = [ChangyanSDK getDefaultCommentBar:CGRectMake(10,self.view.frame.size.height-60,self.view.frame.size.width-20, 40)
                                            postButtonRect:CGRectMake(5, 5,self.view.frame.size.width-60, 35)
                                            listButtonRect:CGRectMake(self.view.frame.size.width-55, 5, 35, 35)
                                                  topicUrl:@""
                                             topicSourceID:self.url
                                                   topicID:nil
                                                categoryID:self.url
                                                topicTitle:nil
                                                    target:self];
    [self.view addSubview:defaultBar];
    
}

- (void)readNetWork
{
    
    QRUrl = knewPhotoApi;
    ConnectServer * cs = [ConnectServer shareInstance];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    NSLog(@"%@",self.url);
        [mulDic setValue:self.url forKey:@"aid"];
   

    
    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_photo",@"requestType", nil];
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
    [self.totalArray removeAllObjects];
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    if([requestType isEqualToString:@"get_photo"]){
        if([[resultDict objectForKey:@"status"] isEqualToString:@"success"]){
            
            [SVProgressHUD dismiss];
            NSDictionary *dic = resultDict[@"data"];
            NSMutableArray *newarry = dic[@"imgs"];
            //总数
            self.count = [dic[@"img_cnt"]intValue];
            NSLog(@"%d",self.count);
            self.setname = newarry[0][@"title"];
            NSLog(@"%@",self.setname);
//            NSArray *dataarray = [TopData objectArrayWithKeyValuesArray:dic[@"imgs"]];
            NSMutableArray * dataarray = dic[@"imgs"];
            // 创建frame模型对象
            NSMutableArray *statusFrameArray = [NSMutableArray array];
            
            for (TopData *data in dataarray) {
                
               
                
                [statusFrameArray addObject:data];
            }
            [self.totalArray addObjectsFromArray:statusFrameArray];
            
            [self setLabel];
            [self setImageView];
            
            
        }else{
            NSLog(@"未知错误");
        }
    }else
    {
        NSLog(@"网络错误");
    }
    
    
}


-(void)initNetWork
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:_url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //总数
        self.count = [responseObject[@"imgsum"]intValue];
        self.setname = responseObject[@"setname"];
        
        NSArray *dataarray = [TopData objectArrayWithKeyValuesArray:responseObject[@"photos"]];
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        
        for (TopData *data in dataarray) {
            [statusFrameArray addObject:data];
        }
        [self.totalArray addObjectsFromArray:statusFrameArray];
        
        [self setLabel];
        [self setImageView];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


-(void)setLabel
{
    //标题
    self.titleLabel.text = self.setname;
    //数量
    NSString *countNum = [NSString stringWithFormat:@"1/%d",self.count];
    self.countLabel.text = countNum;
    //内容
    [self setContentWithIndex:0];
    
}

/** 添加内容 */
- (void)setContentWithIndex:(int)index
{
    NSString *content = self.totalArray[index][@"title"];
    NSString *contentTitle = self.totalArray[index][@"title"];
    if (content.length != 0) {
        self.textview.text = content;
    }else{
        self.textview.text = contentTitle;
    }
}


-(void)setImageView
{
    NSUInteger count = self.count;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat imageH = self.scroll.frame.size.height - 100;
        CGFloat imageW = self.scroll.frame.size.width;
        CGFloat imageY = 0;
        CGFloat imageX = i * imageW;
        UIImageView *imaV = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        // 图片的显示格式为合适大小
        imaV.contentMode= UIViewContentModeCenter;
        imaV.contentMode= UIViewContentModeScaleAspectFit;
        [self.scroll addSubview:imaV];
    }
    
    [self setImgWithIndex:0];
    
    self.scroll.contentOffset = CGPointZero;
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * count, 0);
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.pagingEnabled = YES;
}

/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.scroll.contentOffset.x / self.scroll.frame.size.width;
    NSLog(@"%d",index);
    // 添加图片
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%d",index+1,self.count];
    self.countLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}


- (void)setImgWithIndex:(int)i
{
    UIImageView *photoImgView = nil;
    if (i == 0) {
        photoImgView = self.scroll.subviews[i+2];
    }else{
        photoImgView = self.scroll.subviews[i];
    }
    
    NSURL *purl = [NSURL URLWithString:self.totalArray[i][@"url"]];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
        [photoImgView sd_setImageWithURL:purl placeholderImage:nil];
        self.imageV = photoImgView;
    }
    
}

-(void)downClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error != NULL){
        [MBProgressHUD showError:@"下载失败"];
    }else{
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}


-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}



@end
