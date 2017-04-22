//
//  TopModel.m
//  YPReusableController
//
//  Created by zhiai on 16/2/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel
- (NSString *)description
{
    return [NSString stringWithFormat:@"toptitle=%@,topid=%@",_toptitleString,_toptitleid];
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.toptitleString forKey:@"toptitle"];
    [aCoder encodeObject:self.toptitleid forKey:@"topid"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.toptitleString = [coder decodeObjectForKey:@"toptitle"];
        self.toptitleid = [coder decodeObjectForKey:@"topid"];
    }
    return self;
}
@end
