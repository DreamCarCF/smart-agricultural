//
//  DetialView.m
//  YPReusableController
//
//  Created by zhiai on 16/2/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//


#import "DetialView.h"
#import "DetailModel.h"
#define TITLE_LABEL_FRAME CGRectMake(0,64,self.frame.size.width,20)
#define PUBDATE_LABEL_FRAME CGRectMake(0,84,self.frame.size.width,20)
#define TYPENAME_LABEL_FRAME CGRectMake(0,104,self.frame.size.width,20)
#define WRITER_LABEL_FRAME CGRectMake(0,124,self.frame.size.width,20)
#define CONTENT_WEBVIEW_FRAME CGRectMake(0,64,self.frame.size.width,self.frame.size.height-80)

@implementation DetialView


- (void)setWithArry:(NSMutableArray *)mutbArry
{
    self.backgroundColor = [UIColor whiteColor];
    self.detailTitleLabel = [[UILabel alloc]initWithFrame:TITLE_LABEL_FRAME];
    self.detailPubdateLabel = [[UILabel alloc]initWithFrame:PUBDATE_LABEL_FRAME];
    self.detailTypeNameLabel = [[UILabel alloc]initWithFrame:TYPENAME_LABEL_FRAME];
    self.detailWriterLabel = [[UILabel alloc]initWithFrame:WRITER_LABEL_FRAME];
    self.detailContentWebView = [[UIWebView alloc]initWithFrame:CONTENT_WEBVIEW_FRAME];
    self.detailContentWebView.backgroundColor = [UIColor whiteColor];
    DetailModel *model = mutbArry[0];
    self.detailTitleLabel.text = model.detailTitleStr;
    self.detailTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.detailPubdateLabel.text = model.detailPubdateStr;
    self.detailPubdateLabel.textAlignment = NSTextAlignmentCenter;
    self.detailTypeNameLabel.text = model.detailTypeNameStr;
    self.detailTypeNameLabel.textAlignment = NSTextAlignmentCenter;
    self.detailWriterLabel.text = model.detailWriterStr;
    self.detailWriterLabel.textAlignment = NSTextAlignmentCenter;
    [self.detailContentWebView loadHTMLString:model.detailContentStr baseURL:nil];

    
//    [self addSubview:self.detailTitleLabel];
//    [self addSubview:self.detailPubdateLabel];
//    [self addSubview:self.detailTypeNameLabel];
//    [self addSubview:self.detailWriterLabel];
    [self addSubview:self.detailContentWebView];
    
}



@end
