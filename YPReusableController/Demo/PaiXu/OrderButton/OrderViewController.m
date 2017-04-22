//
//  OrderViewController.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "OrderViewController.h"
#import "TouchViewModel.h"
#import "TouchView.h"
#import "TopModel.h"


@interface OrderViewController ()
{
    int abc;
    CGFloat KfinalWidth;
    CGFloat KLabelOringX;
}
@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    abc= 0;
	// Do any additional setup after loading the view.
    
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
    NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
    NSMutableArray * modelArr = [NSMutableArray new];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray * channelListArr = self.titleArr;
        NSArray * channelUrlStringListArr = self.urlStringArr;
        NSMutableArray * mutArr = [NSMutableArray array];
        for (int i = 0; i < [channelListArr count]; i++) {
            TopModel * model = channelListArr[i];
            
            NSLog(@"%@",model.toptitleString);
            
            
            NSString * title = model.toptitleString;
            NSString * urlString = model.toptitleid;
            TouchViewModel * touchViewModel = [[TouchViewModel alloc] initWithTitle:title urlString:urlString];
            [mutArr addObject:touchViewModel];

            if (i == KDefaultCountOfUpsideList - 1) {
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
                [data writeToFile:filePath atomically:YES];
                [mutArr removeAllObjects];
            }
            else if(i == [channelListArr count] - 1){
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
                [data writeToFile:filePath1 atomically:YES];
            }
            
        }
    }else
    {
//        if ([[NSFileManager defaultManager] removeItemAtPath:filePath1 error:nil]) {
//          
//        }
        NSMutableArray * addArry = [NSMutableArray new];
        NSArray *newarray = [YPCacheTool channelTitleArray];
        NSMutableArray * newDataArr = [NSMutableArray new];
//        NSMutableArray * newnewArr = [NSMutableArray new];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        for (int i = 0; i<newarray.count; i++) {
            TopModel *ccc = (TopModel *)[NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:[NSString stringWithFormat:@"person%d",i]]];
            
            NSLog(@"ccc=%@",ccc.toptitleString);
            TopModel *newMoedel = [TopModel new];
            newMoedel.toptitleString = ccc.toptitleString;
            newMoedel.toptitleid = ccc.toptitleid;
            [newDataArr addObject:newMoedel];
        }
        
          NSData * data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
        _modelArr1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        
        NSLog(@"%@",newDataArr);
        NSLog(@"%@",_modelArr1);
        
        NSUInteger newDatacount = newDataArr.count;
        NSMutableArray * needRemoveArr = [NSMutableArray new];
        for (int i = 0 ; i<newDatacount; i++) {
            if(i < newDataArr.count){
                NSLog(@"%lu",(unsigned long)newDataArr.count);
                TopModel * Topmodel = newDataArr[i];
                for (TouchViewModel *toumodel in _modelArr1) {
                    NSLog(@"%@",toumodel.title);
                    if ([Topmodel.toptitleString isEqualToString:toumodel.title]) {
                        
                        [needRemoveArr addObject:Topmodel];
                        NSLog(@"%@",Topmodel.toptitleString);
                    }
                }
            }
        }
        [newDataArr removeObjectsInArray:needRemoveArr];
        
        
        [modelArr removeAllObjects];
        
        for (int i = 0; i<newDataArr.count; i++) {
            TopModel * tpmodel = newDataArr[i];
            TouchViewModel * tmodel= [TouchViewModel new];
            
           tmodel.title = tpmodel.toptitleString;
           tmodel.urlString = tpmodel.toptitleid;
            [modelArr addObject:tmodel];
        }
        
        data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
        [data writeToFile:filePath1 atomically:YES];
    }

    
    _modelArr1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSArray * modelArr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    _viewArr1 = [[NSMutableArray alloc] init];
    _viewArr2 = [[NSMutableArray alloc] init];
    
    
    if (iPHone6) {
        KfinalWidth= 64;
        KLabelOringX = 140;
    }else if (iPHone5)
    {
        KfinalWidth = 54;
    }else if (iPHone4)
    {
        KfinalWidth = 44;
    }else if (iPHone6Plus)
    {
        KfinalWidth = 70;
    }

    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 40)];
    _titleLabel.text = @"频道定制";
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
    [self.view addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    _titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + KMoreChannelDeltaHeight, self.view.frame.size.width,30)];
    _titleLabel2.text = @"更多频道";
    [_titleLabel2 setFont:[UIFont boldSystemFontOfSize:15]];
    [_titleLabel2 setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel2 setTextColor:[UIColor whiteColor]];
    _titleLabel2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_titleLabel2];
//    [_titleLabel2 makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.top.mas_equalTo(@(KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + KMoreChannelDeltaHeight));
//        make.height.mas_equalTo(20);
//    }];
    
    
    for (int i = 0; i < _modelArr1.count; i++) {
        TouchView * touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + (4+KfinalWidth) * (i%5), KTableStartPointY + KButtonHeight * (i/5), KfinalWidth, KButtonHeight)];

        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [_viewArr1 addObject:touchView];
//        [touchView release];
        touchView->_array = _viewArr1;
        if (i == 0) {
            [touchView.label setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
        }
        else{
            
            [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        }
        touchView.label.text = [[_modelArr1 objectAtIndex:i] title];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        [touchView setMoreChannelsLabel:_titleLabel2];
        touchView->_viewArr11 = _viewArr1;
        touchView->_viewArr22 = _viewArr2;
        [touchView setTouchViewModel:[_modelArr1 objectAtIndex:i]];
        
        [self.view addSubview:touchView];
        
        
//        [touchView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(@(KTableStartPointX + KfinalWidth * (i%5)));
//            
//            
//        }];
    }
    
    for (int i = 0; i < modelArr2.count; i++) {
        TouchView * touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + (KfinalWidth+4) * (i%5), KTableStartPointY + KDeltaHeight + [self array2StartY] * KButtonHeight + KButtonHeight * (i/5)+20  , KfinalWidth, KButtonHeight)];
        
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [_viewArr2 addObject:touchView];
        touchView->_array = _viewArr2;
        
        touchView.label.text = [[modelArr2 objectAtIndex:i] title];
        [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        [touchView setMoreChannelsLabel:_titleLabel2];
        touchView->_viewArr11 = _viewArr1;
        touchView->_viewArr22 = _viewArr2;
        [touchView setTouchViewModel:[modelArr2 objectAtIndex:i]];
        
        [self.view addSubview:touchView];
        
        
        
        
//        [touchView release];
        
    }
    
    

    

    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setFrame:CGRectMake(self.view.bounds.size.width - 56, self.view.bounds.size.height - 108, 56, 44)];
    
    [self.backButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    [self.backButton setImage:[UIImage imageNamed:@"order_back.png"] forState:UIControlStateNormal];
//    [self.backButton setImage:[UIImage imageNamed:@"order_back_select.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.backButton];
}

- (void)dealloc{
//    [_backButton release];
//    [_titleArr release];
//    [_urlStringArr release];
//    [_titleLabel2 release];
//    [_titleLabel release];
//    [_viewArr1 release];
//    [_viewArr2 release];
//    [super dealloc];
}


- (unsigned long )array2StartY{
    unsigned long y = 0;

    y = _modelArr1.count/5 + 2;
    if (_modelArr1.count%5 == 0) {
        y -= 1;
    }
    return y;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
