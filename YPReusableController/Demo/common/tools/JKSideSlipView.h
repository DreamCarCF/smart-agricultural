//
//  JKSideSlipView.h
//  JKSideSlipView
//
//  Created by Jakey on 15/1/10.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKSideSlipView : UIView
{
    BOOL isOpen;
    UITapGestureRecognizer *_tap;
    UISwipeGestureRecognizer *_leftSwipe, *_rightSwipe;
    //UIImageView *_blurImageView;
    UIViewController *_sender;
    UIView *_contentView;
}

@property (nonatomic)  UIImageView *blurImageView;

- (instancetype)initWithSender:(UIViewController*)sender;
-(void)show;
-(void)hide;
//显示侧滑菜单
-(void)switchMenu;
-(void)setContentView:(UIView*)contentView;

-(void)clear;

@end

