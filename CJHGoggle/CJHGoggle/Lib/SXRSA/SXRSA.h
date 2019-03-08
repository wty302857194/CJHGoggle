/*
 @author: ideawu
 @link: https://github.com/ideawu/Objective-C-RSA
*/

#import <Foundation/Foundation.h>

@interface SXRSA : NSObject

+ (SecKeyRef)addPublicKey:(NSString *)key;

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key;

// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
// enc with private key NOT working YET!
//+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
//+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)

// 公钥解密
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey padding:(SecPadding)padding;

+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey padding:(SecPadding)padding;

+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey padding:(SecPadding)padding;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey padding:(SecPadding)padding;

+ (BOOL)verify:(NSString *)plainString sign:(NSString *)signString publicKey:(NSString *)publicKey;

@end
