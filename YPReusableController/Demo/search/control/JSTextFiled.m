//
//  JSTextFiled.m
//  test1
//
//  Created by Sam Feng on 15/9/18.
//  Copyright (c) 2015年 beloved999. All rights reserved.
//

#import "JSTextFiled.h"

@implementation JSTextFiled


-(id)initWithFrame:(CGRect)frame drawingLeft:(UIImageView *)icon{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    return iconRect;
}



@end
