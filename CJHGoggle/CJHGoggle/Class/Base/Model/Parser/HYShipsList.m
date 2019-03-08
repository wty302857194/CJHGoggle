//
//  HYShipsList.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYShipsList.h"

@implementation HYShipsList

+ (instancetype)objectWithKeyValues:(id)keyValues {
    
    [self setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"data" : @"HYShipInfo",
                 };
    }];
    
    return [self objectWithKeyValues:keyValues error:nil];
}

- (BOOL)haveMore {
    
    if((self.count % REQUEST_LIMIT) == 0 && self.data && self.data.count > 0) {
        
        return YES;
    }
    
    return NO;
}

@end
