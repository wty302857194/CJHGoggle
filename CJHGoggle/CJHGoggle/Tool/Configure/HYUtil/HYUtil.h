//
//  HYUtil.h
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYUtil : NSObject

//验证电话格式
+ (BOOL)isValidatePhone:(NSString *)phone;
//验证身份证号是否正确
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;

+ (NSArray *)dp_deepSubViews:(UIView *)view;

+ (BOOL)isNewVersion:(NSString *)appVersion;

@end
