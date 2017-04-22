//
//  DetailModel.h
//  YPReusableController
//
//  Created by zhiai on 16/2/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property (nonatomic,copy) NSString *detailPageViewStr;//浏览量
@property (nonatomic,copy) NSString *detailPubdateStr;//发布时间
@property (nonatomic,copy) NSString *detailTitleStr;//标题
@property (nonatomic,copy) NSString *detailTypeidStr;//分类id
@property (nonatomic,copy) NSString *detailTypeNameStr;//分类名称
@property (nonatomic,copy) NSString *detailWriterStr;//作者
@property (nonatomic,copy) NSString *detailContentStr;//html文件
@end
