//
//  HYNotificationList.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYNotificationList.h"
#import "HYNotification.h"

@implementation HYNotificationList

+ (instancetype)objectWithKeyValues:(id)keyValues {
    
    [self setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"data" : @"HYNotification",
                 };
    }];
    
    // How to map
    [HYNotification mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"notification_id" : @"id",
                 @"notification_cid" : @"cid",
                 @"notification_title" : @"title",
                 @"notification_message" : @"message",
                 @"notification_mmsi" : @"mmsi",
                 @"notification_longitude" : @"longitude",
                 @"notification_latitude" : @"latitude",
                 };
    }];
    
    return [self objectWithKeyValues:keyValues error:nil];
}

@end
