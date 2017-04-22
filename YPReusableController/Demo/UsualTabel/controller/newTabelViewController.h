//
//  newTabelViewController.h
//  YPReusableController
//
//  Created by zhiai on 16/2/23.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newTabelViewController : UITableViewController
@property(nonatomic,copy)NSString * currentString;
@property(nonatomic,copy)NSString * theKeyWord;
-(void)logThetid:(NSString*)tid;
- (void)logTheKeyword:(NSString *)theWord;
@end
