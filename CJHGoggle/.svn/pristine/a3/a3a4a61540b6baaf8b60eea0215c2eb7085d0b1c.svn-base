//
//  HYShipListModel.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/16.
//  Copyright © 2018年 CJH. All rights reserved.
//
/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */

#import "HYShipListModel.h"

@implementation HYShipListModel

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char* name = ivar_getName(ivar);
        NSString* key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey :key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    
    if (self == [super init]) {
        unsigned int count = 0;
        Ivar* ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char* name = ivar_getName(ivar);
            NSString* key = [NSString stringWithUTF8String:name];
            id value =  [aDecoder decodeObjectForKey:key];//根据key拿到value
            [self setValue:value forKey:key];//KVC赋值
        }
        
        free(ivars);
    }
    return self;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"labelList" : [HYLabelListModel class]};
}

@end

@implementation HYLabelListModel

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    
    //    NSLog(@"归档encodeWithCoder方法调用了");
    
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char* name = ivar_getName(ivar);
        NSString* key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey :key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    
    if (self == [super init]) {
        unsigned int count = 0;
        Ivar* ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char* name = ivar_getName(ivar);
            NSString* key = [NSString stringWithUTF8String:name];
            id value =  [aDecoder decodeObjectForKey:key];//根据key拿到value
            [self setValue:value forKey:key];//KVC赋值
        }
        
        free(ivars);
    }
    return self;
}

@end
