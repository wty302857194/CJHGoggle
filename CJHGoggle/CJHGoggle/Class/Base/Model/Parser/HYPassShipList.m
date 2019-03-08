//
//  HYPassShipList.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYPassShipList.h"

@implementation HYPassShipList

+ (instancetype)objectWithKeyValues:(id)keyValues {
    
    [self setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"rows" : @"HYPassShipInfo",
                 };
    }];
    
    [self setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"hasnext" : @"data.hasnext",
                 @"rows" : @"data.rows",
                 };
    }];
    
    return [self objectWithKeyValues:keyValues error:nil];
}

@end