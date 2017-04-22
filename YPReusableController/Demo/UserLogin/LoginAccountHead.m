//
//  MyView.m
//  testViewFromXib
//
//  Created by Fang Jian on 14-9-13.
//  Copyright (c) 2014年 Jian Fang. All rights reserved.
//

#import "LoginAccountHead.h"

@interface LoginAccountHead()

@end


@implementation LoginAccountHead

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)ShowPanelByLogin:(NSString *)token{
    if(token == nil || [token isEqualToString:@""]){
        self.non_loginView.hidden = NO;
        self.loginedView.hidden = YES;
    }else{
        self.non_loginView.hidden = YES;
        self.loginedView.hidden = NO;
    }
}

- (IBAction)clickedloginBtn:(UIButton *)sender {
    [self.delegate gotoLoginView];
}

//- (IBAction)gotoSetting:(UIButton *)sender {
//    [self.delegate gotoSettingView];
//}

+(LoginAccountHead *)instanceView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"LoginAccountHead" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (IBAction)gotoSettingView:(UIButton *)sender {
    [_delegate gotoSettingView];

}



@end
