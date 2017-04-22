//
//  UpdateVersion.m
//  beloved999
//
//  Created by Sam Feng on 15/11/25.
//  Copyright © 2015年 beloved999. All rights reserved.
//

#import "UpdateVersion.h"
#import "ConnectServer.h"

@implementation UpdateVersion

//-(void)checkCurrentVersion{
//    NSString *url = kLoginUrl;
//    NSDictionary * user = @{@"method":@"/public/update_version",
//                            @"agent":@"iphone"};
//    
//    ConnectServer * cs = [ConnectServer shareInstance];
//    cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"update_version",@"requestType", nil];
//    [cs sendJsonData:user baseURLWithString:url FromViewController:self];
//}

-(NSString *)DocumentDirectory{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    documentPath = [documentPath stringByAppendingPathComponent:@"area.plist"];
    return documentPath;
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * requestType = [request.userInfo objectForKey:@"requestType"];
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSDictionary * resultDict = [parser objectWithString:response error:&error];
    
    if([requestType isEqualToString:@"update_version"]){
        if([[resultDict objectForKey:@"region_reload"] isEqualToString:@"true"]){
            
//            NSString *url = [NSString stringWithFormat:@"%@base.php",kLoginUrl] ;
//            
//            NSDictionary * user = @{@"method":@"region",@"agent":@"iphone"};
//            ConnectServer * cs = [ConnectServer shareInstance];
//            cs.user_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"get_region",@"requestType", nil];
//            [cs sendJsonData:user baseURLWithString:url FromViewController:self];

        }
    }else if ([requestType isEqualToString:@"get_region"]){
        //NSData *responseData = [request responseData];
        NSString *documentPath = [self DocumentDirectory];
        NSFileManager * fm = [NSFileManager defaultManager];
        if([fm fileExistsAtPath:documentPath] == NO){
        [fm createFileAtPath:documentPath contents:nil attributes:nil];
        }
        NSFileHandle *fh2 = [NSFileHandle fileHandleForWritingAtPath:documentPath];
        [fh2 writeData:[response dataUsingEncoding:NSUTF8StringEncoding]];
        [fh2 closeFile];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
}
@end
