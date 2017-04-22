//
//  ListModel.h
//  YPReusableController
//
//  Created by zhiai on 16/2/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property (nonatomic,copy) NSString * contextidStr;
@property (nonatomic,copy) NSString * contextpicStr;
@property (nonatomic,copy) NSString * contexttimeStr;
@property (nonatomic,copy) NSString * contexttitleStr;
@property (nonatomic,copy) NSString * contextfcnumberStr;
@property (nonatomic,copy) NSString * contextlessInforStr;
@property (nonatomic,retain) NSMutableArray * contextimgArry;
@property (nonatomic,copy) NSString * contextPanDuanStr;
@property (nonatomic,copy) NSString * contextImgCount;

@end
