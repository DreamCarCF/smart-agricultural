//
//  ContectServer.m
//  CoolTalk
//
//  Created by BreazeMago on 15/4/2.
//  Copyright (c) 2015年 BreazeMago. All rights reserved.
//

#import "ConnectServer.h"
#import "ASIHTTPRequest.h"

static ConnectServer *_ConnectServer = nil;

@implementation ConnectServer
@synthesize PhoneNum;
@synthesize user_info;
@synthesize queue = _queue;

+(ConnectServer *)shareInstance
{
    @synchronized(self)
    {
        if (nil == _ConnectServer)
        {
            _ConnectServer = [[ConnectServer alloc] init];
        
        }else{
        
        }
        _ConnectServer.queue = [[NSOperationQueue alloc] init];
        _ConnectServer.queue.maxConcurrentOperationCount = 4;
        return _ConnectServer;
    }
}


//清除表格多余的空格
+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


//Post 请求
-(void)sendJsonData:(NSDictionary*)user baseURLWithString:(NSString *)str FromViewController:(id)baseViewController
{
    NSURL *url = [NSURL URLWithString:str];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    [request setRequestMethod:@"POST"];

    if(user != nil && [NSJSONSerialization isValidJSONObject:user]){
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        [request setPostBody:tempJsonData];
    }
    [request setDelegate:baseViewController];
    if(user_info != nil){
        request.userInfo = user_info;
    }
    [self.queue addOperation:request];
    //[request startAsynchronous];
}

//Put 请求
-(void)sendJsonDataPut:(NSDictionary*)user baseURLWithString:(NSString *)str FromViewController:(UIViewController *)baseViewController
{
    NSURL *url = [NSURL URLWithString:str];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];

    if(user != nil && [NSJSONSerialization isValidJSONObject:user]){
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        [request setPostBody:tempJsonData];
    }
    [request setDelegate:baseViewController];
    [request startAsynchronous];
    /*
    error = [request error];
    if (!error){
        NSString *response = [request responseString];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        dict = [parser objectWithString:response error:&error];
        NSLog(@"sendJsonData,dict is %@",dict);
        baseViewController.resultFromServer = dict;
    }
    */
}
@end
