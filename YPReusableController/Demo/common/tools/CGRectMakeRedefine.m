//
//  CGRectMakeRedefine.m
//  CoolTalk
//
//  Created by Sam on 15/5/12.
//  Copyright (c) 2015年 BreazeMago. All rights reserved.
//

#import "CGRectMakeRedefine.h"
//#import "BelovedAppDelegate.h"

@implementation CGRectMakeRedefine

//storyBoard view自动适配
+(void)storyBoradAutoLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        //NSLog(@"temp.frame.size.width = %f",temp.frame.size.width);
        CGRect rect = CGRectMake1(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        // NSLog(@"rect.size.width = %f",rect.size.width);
        temp.frame = rect;
        
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = CGRectMake1(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
        }
    }
}

//修改CGRectMake
CG_INLINE CGRect CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    BelovedAppDelegate *myDelegate = (BelovedAppDelegate*)[UIApplication sharedApplication].delegate;
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}

+(CGRect) CGRectMakeDefine:(CGRect)originRect
{
    CGFloat x = originRect.origin.x;
    CGFloat y = originRect.origin.y;
    CGFloat width = originRect.size.width;
    CGFloat height = originRect.size.height;
    
    BelovedAppDelegate *myDelegate = (BelovedAppDelegate*)[UIApplication sharedApplication].delegate;
    x = (x * myDelegate.autoSizeScaleX);
    y = (y * myDelegate.autoSizeScaleY);
    width = (width * myDelegate.autoSizeScaleX);
    height = (height * myDelegate.autoSizeScaleY);
    return CGRectMake(x, y, width, height);
}

+(CGSize) CGSizeMakeDefine:(CGSize)originSize
{
    CGFloat width = originSize.width;
    CGFloat height = originSize.height;
    
    BelovedAppDelegate *myDelegate = (BelovedAppDelegate*)[UIApplication sharedApplication].delegate;
    width = (width * myDelegate.autoSizeScaleX);
    height = (height * myDelegate.autoSizeScaleY);
    return CGSizeMake(width, height);
}



@end
