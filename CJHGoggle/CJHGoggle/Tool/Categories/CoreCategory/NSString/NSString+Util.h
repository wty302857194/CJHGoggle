//
//  NSString+Util.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

+ (BOOL)dp_isEmptyString:(NSString *)string;

+ (NSString *)dp_hexStringFromData:(NSData *)data;

+ (NSData *)dp_stringFromHex:(NSString *)hex;

+ (NSString *)dp_uniqueString;

+ (NSString *)dp_stringWithDictionary:(NSDictionary *)dictionary key:(NSString *)key;

// 计算字符串的宽度
- (CGFloat)dp_widthWith:(UIFont *)font;

/**
 *  计算字符串的高度
 *
 *  @param font   字体
 *  @param width  宽度限定
 *
 *  @return 返回的高度
 */
- (CGFloat)dp_sizeWithFont:(UIFont *)font width:(CGFloat)width;

- (NSString *)dp_URLEncodedString;

- (NSString *)dp_URLDecodedString;

// 32位 小写
- (NSString *)MD5ForLower32Bate;

// 32位 大写
- (NSString *)MD5ForUpper32Bate;

// 16位 大写
- (NSString *)MD5ForUpper16Bate;

// 16位 小写
- (NSString *)MD5ForLower16Bate;

- (NSString *)md5HexDigest;

// 取指定长度的随机数
+ (NSString *)randomStr:(NSInteger)count;

// 随机文件名
+ (NSString *)randomUploadFileName;

// 阿拉伯数字转为中文数字
- (NSString *)chineseNumber;

//传给app用于加签的hexstring
+ (NSString *)dpOriginalData:(NSDictionary *)dic;

@end
