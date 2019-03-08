//
//  NSDictionary+safeObjectForKey.m
//  cjh
//
//  Created by user_lzz on 15/10/28.
//  Copyright © 2015年 njcjh. All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"

#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

#define boolNull(__Y__)         (__Y__) == [NSNull null] || (__Y__) == nil ? @"0" : [NSString stringWithFormat:@"%@", (__Y__)]

@implementation NSDictionary (safeObjectForKey)

- (id)safeObjectForKey:(id)key
{
    return checkNull([self objectForKey:key]);
}

- (BOOL)safeBoolForKey:(id)key
{
    return [boolNull([self objectForKey:key]) boolValue];
}


#pragma mark - 私有方法

// 将NSDictionary中的Null类型的项目转化成@""
+ (NSDictionary *)nullDic:(NSDictionary *)sourceDic
{
    NSArray *keyArr = [sourceDic allKeys];
    NSMutableDictionary *goalDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [sourceDic objectForKey:keyArr[i]];
        obj = [self changeType:obj];
        [goalDic setObject:obj forKey:keyArr[i]];
    }
    return goalDic;
}

// 将NSDictionary中的Null类型的项目转化成@""
+ (NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

// 将NSString类型的原路返回
+ (NSString *)stringToString:(NSString *)string
{
    return string;
}

// 将Null类型的项目转化成@""
+ (NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法

// 类型识别:将所有的NSNull类型转化成@""
+ (id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}


@end
