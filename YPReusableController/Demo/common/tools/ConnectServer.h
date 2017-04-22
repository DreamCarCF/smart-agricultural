//
//  ContectServer.h
//  CoolTalk
//
//  Created by BreazeMago on 15/4/2.
//  Copyright (c) 2015年 BreazeMago. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LoginSession.h"

//连接服务器
@interface ConnectServer : NSObject
{

    NSString *PhoneNum;
    //BOOL isFirstLaunching;
}
@property (nonatomic,strong) NSString *PhoneNum;
@property (nonatomic,strong) NSMutableDictionary *user_info;
@property (nonatomic,strong) NSOperationQueue * queue;

+(ConnectServer *)shareInstance;

//消除多余的表格线
+(void)setExtraCellLineHidden:(UITableView *)tableView;

//发送json数据到服务器
-(void)sendJsonData:(NSDictionary*)user baseURLWithString:(NSString *)str FromViewController:(id)baseViewController;

-(void)sendJsonDataPut:(NSDictionary*)user baseURLWithString:(NSString *)str FromViewController:(id)baseViewController;

@end
