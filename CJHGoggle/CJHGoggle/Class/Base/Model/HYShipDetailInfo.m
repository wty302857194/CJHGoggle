//
//  HYShipDetailInfo.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYShipDetailInfo.h"

@implementation HYShipMemberRecord

@end

@implementation HYShipOilRecord

@end

@implementation HYShipNoOilRecord

@end

@implementation HYShipDetailInfo

+ (instancetype)objectWithKeyValues:(id)keyValues {
    
    [self setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"labelList" : @"HYUserLabel",
                 @"memberList" : @"HYShipMemberRecord",
                 @"oilRecordList" : @"HYShipOilRecord",
                 @"nonOilRecords" : @"HYShipNoOilRecord",
                 };
    }];
    
    [self setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"shipid" : @"data.shipid",
                 @"distance" : @"data.distance",
                 @"moortime" : @"data.moortime",
                 @"nameandphone" : @"data.nameandphone",
                 @"isstar" : @"data.isstar",
                 @"ismyship" : @"data.ismyship",
                 @"labelList" : @"data.labelList",
                 @"memberList" : @"data.memberList",
                 @"oilRecordList" : @"data.oilRecordList",
                 @"nonOilRecords" : @"data.nonOilRecords",
                 };
    }];
    
    return [self objectWithKeyValues:keyValues error:nil];
}

@end
