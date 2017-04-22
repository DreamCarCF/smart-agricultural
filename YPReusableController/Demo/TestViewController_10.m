//
//  TestViewController_10.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/22.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "TestViewController_10.h"
#import "YPReusableControllerConst.h"
#import "newTabelViewController.h"
#import "CustomTableViewCell.h"
@interface TestViewController_10 ()

@end

@implementation TestViewController_10

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden= NO;
    YPLog(@"第十个控制器加载完毕");
    newTabelViewController *tabelView = [[newTabelViewController alloc]init];
    tabelView.view.frame = self.view.frame;
    tabelView.currentString = nil;
    tabelView.theKeyWord = self.idNewStr;
    [self addChildViewController:tabelView];
    [tabelView logTheKeyword:self.idNewStr];
    [self.view addSubview:tabelView.view];
    self.view.backgroundColor = YPRandomColor_RGB;
}

@end
