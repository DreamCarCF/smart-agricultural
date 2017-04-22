//
//  DetialView.h
//  YPReusableController
//
//  Created by zhiai on 16/2/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetialView : UIView
@property (nonatomic,strong) UILabel *detailTitleLabel;
@property (nonatomic,strong) UILabel *detailPubdateLabel;
@property (nonatomic,strong) UILabel *detailWriterLabel;
@property (nonatomic,strong) UILabel *detailTypeNameLabel;
@property (nonatomic,strong) UIWebView *detailContentWebView;
- (void)setWithArry:(NSMutableArray *)mutbArry;
@end
