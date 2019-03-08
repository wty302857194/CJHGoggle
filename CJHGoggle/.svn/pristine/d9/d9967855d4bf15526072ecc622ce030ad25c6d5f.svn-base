//
//  NSString+Util.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "NSString+Util.h"
#import "SXCocoaSecurity.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Util)

+ (BOOL)dp_isEmptyString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        
        return YES;
    }
    
    return NO;
}

+ (NSString *)dp_hexStringFromData:(NSData *)data {
    
    return [[[[NSString stringWithFormat:@"%@",data]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

+ (NSData *)dp_stringFromHex:(NSString *)hex {
    
    SXCocoaSecurityDecoder *decoder = [[SXCocoaSecurityDecoder alloc] init];
    return [decoder hex:hex];
}

+ (NSString *)dp_uniqueString {
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (NSString *)dp_stringWithDictionary:(NSDictionary *)dictionary key:(NSString *)key {
    
    if(!dictionary || !key) return nil;
    
    if(![dictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    id value = [dictionary objectForKey:key];
    
    if(!value) {
        return nil;
    }
    if([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", value];
    }
    else if([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return nil;
}

// 计算字符串的宽度
- (CGFloat)dp_widthWith:(UIFont *)font {
    
    CGSize size = [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    
    return ceil(size.width);
}

/**
 *  计算字符串的高度
 *
 *  @param font   字体
 *  @param width  宽度限定
 *
 *  @return 返回的高度
 */
- (CGFloat)dp_sizeWithFont:(UIFont *)font width:(CGFloat)width {
    
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil].size;
    
    return ceil(titleSize.height);
}

- (NSString *)dp_URLEncodedString {
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString *)dp_URLDecodedString {
    
    NSString *encodedString = self;
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                    (__bridge CFStringRef)encodedString,
                                                                                                                    CFSTR(""),
                                                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

// 32位 小写
- (NSString *)MD5ForLower32Bate {
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

// 32位 大写
- (NSString *)MD5ForUpper32Bate {
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

// 16位 大写
- (NSString *)MD5ForUpper16Bate {
    
    NSString *md5Str = [self MD5ForUpper32Bate];
    
    NSString *string;
    
    for (NSInteger i = 0; i < 24; i++) {
        
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    
    return string;
}


// 16位 小写
- (NSString *)MD5ForLower16Bate {
    
    NSString *md5Str = [self MD5ForLower32Bate];
    
    NSString *string;
    
    for (NSInteger i = 0; i < 24; i++) {
        
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    
    return string;
}

- (NSString *)md5HexDigest {
    
    const char *pStr = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pStr, (CC_LONG)strlen(pStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

// 取指定长度的随机数
+ (NSString *)randomStr:(NSInteger)count {
    
    NSString *string = @"";
    
    for ( NSInteger index = 0; index < count; index ++ ) {
        
        string = [NSString stringWithFormat:@"%@%d", string, (arc4random() % 10)];
    }
    
    return string;
}

// 随机文件名
+ (NSString *)randomUploadFileName {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *name = [NSString stringWithFormat:@"%.0f%@", timeInterval, [NSString randomStr:10]];
    return [name MD5ForLower32Bate];
}

- (NSString *)chineseNumber {
    
    NSArray *array = [NSArray arrayWithObjects:@"零", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", nil];
    
    NSInteger index = [self integerValue];
    
    return [array objectAtIndex:index];
}

//传给app用于加签的hexstring
+ (NSString *)dpOriginalData:(NSDictionary *)dic {
    
    SXCocoaSecurityResult *md5 = [SXCocoaSecurity md5:[self dp_pureSignStringWithData:dic]];
    return md5.hex;
}

//拼接验签需要字符串
+ (NSString *)dp_pureSignStringWithData:(id)data {
    
    __block NSString *pureSignString = @"";
    
    if ([NSJSONSerialization isValidJSONObject:data]) {
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = (NSDictionary *)data;
            NSArray *keyArray = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
            
            [keyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if ([dic[obj] isKindOfClass:[NSDictionary class]]) {
                    
                    pureSignString = [pureSignString stringByAppendingFormat:@"%@={%@}&",obj,[self dp_pureSignStringWithData:dic[obj]]];
                    
                }
                else if ([dic[obj] isKindOfClass:[NSArray class]]) {
                    
                    pureSignString = [pureSignString stringByAppendingFormat:@"%@=[%@]&",obj,[self dp_pureSignStringWithData:dic[obj]]];
                    
                }
                else {
                    
                    NSString *valueString = [NSString dp_stringWithDictionary:dic key:obj];
                    
                    if (![NSString dp_isEmptyString:valueString]) {
                        
                        pureSignString = [pureSignString stringByAppendingFormat:@"%@=%@&",obj, valueString];
                    }
                }
            }];
            
        }
        else if ([data isKindOfClass:[NSArray class]]) {
            
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                pureSignString = [pureSignString stringByAppendingFormat:@"%@,",[self dp_pureSignStringWithData:obj]];
            }];
        }
        
        if (pureSignString.length > 1) {
            
            pureSignString = [pureSignString substringToIndex:pureSignString.length-1];
        }
        
        
        pureSignString = [pureSignString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        pureSignString = [pureSignString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        pureSignString = [pureSignString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        pureSignString = [pureSignString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        return pureSignString;
    }
    else {
        
        return data;
    }
}

@end
