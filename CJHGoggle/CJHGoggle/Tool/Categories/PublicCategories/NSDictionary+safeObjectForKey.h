//
//  NSDictionary+safeObjectForKey.h
//  cjh
//
//  Created by user_lzz on 15/10/28.
//  Copyright © 2015年 njcjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safeObjectForKey)

- (id)safeObjectForKey:(id)key;

- (BOOL)safeBoolForKey:(id)key;

// 将NSDictionary中的Null类型的项目转化成@""
+ (NSDictionary *)nullDic:(NSDictionary *)sourceDic;

@end
