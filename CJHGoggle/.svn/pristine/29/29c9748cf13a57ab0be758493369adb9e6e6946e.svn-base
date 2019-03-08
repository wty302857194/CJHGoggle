//
//  NSData+AES256.h
//  AES
//
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
@interface NSData (DPAES256)
{
    
}
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain;        /*加密方法,参数需要加密的内容*/


/**
 加密方法，加密因子传递

 @param plain 需加密数据
 @param key 加密因子
 @return 加密后的数据
 */
+ (NSString *)DP_AES256EncryptWithPlainText:(NSString *)plain encrypKey:(NSString *)key;

+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts; /*解密方法，参数数密文*/

/**
 解密方法，解密因子传递
 
 @param plain 需解密数据
 @param key 解密因子
 @return 解密后的数据
 */
+ (NSString *)DP_AES256DecryptWithCiphertext:(NSString *)ciphertexts decrypKey:(NSString *)key;

@end
