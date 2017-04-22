//
//  TestViewControllerEight.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/22.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "TestViewControllerEight.h"
#import "YPReusableControllerConst.h"
#import "newTabelViewController.h"
#import "CustomTableViewCell.h"
@interface TestViewControllerEight ()

@end

@implementation TestViewControllerEight

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第八个控制器加载完毕");
    newTabelViewController *tabelView = [[newTabelViewController alloc]init];
    tabelView.view.frame = self.view.frame;
    tabelView.currentString = self.newsidStr;
    tabelView.theKeyWord = nil;
    [self addChildViewController:tabelView];
    [tabelView logThetid:tabelView.currentString];
    [self.view addSubview:tabelView.view];
    self.view.backgroundColor = YPRandomColor_RGB;
}
@end
