//
//  HYStationList.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYStationList.h"

@implementation HYStationList

+ (instancetype)objectWithKeyValues:(id)keyValues {
    
    [self setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"data" : @"HYStation",
                 };
    }];
    
    return [self objectWithKeyValues:keyValues error:nil];
}

@end
