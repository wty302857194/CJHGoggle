//
//  Global.h
//  CJHLogistics
//
//  Created by wbb on 2017/11/22.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

// 根据文字大小和控件宽度计算控件高度
+ (CGFloat)heightForText:(NSString *)text textFont:(CGFloat)fontSize standardWidth:(CGFloat)controlWidth;
// 根据文字大小和控件高度计算控件宽度
+ (CGFloat)widthForText:(NSString *)text textFont:(CGFloat)fontSize  standardHeight:(CGFloat)controlHeight;

// 如果String转换Json合法，则返回NSDictionary
+ (id)transformDictionaryByString:(NSString *)jsonString;

// 随机生成36位字符串，中间有4位“－”
+ (NSString *)uuidString;
//时间戳转时间,
+ (NSString *)timechangeWithTimeInterval:(NSString *)beginTime setDateFormat:(NSString *)format;

// 校验输入内容--只能输入数字
+ (BOOL)validateNumber:(NSString *)number;


+ (void)promptMessage:(NSString *)message inView:(UIView *)view;
//获取手机版本号
+ (NSString *)getAppVersion;

@end
