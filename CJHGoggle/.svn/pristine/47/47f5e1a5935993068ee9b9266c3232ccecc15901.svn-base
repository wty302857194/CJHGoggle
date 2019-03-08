//
//  NSData+AES256.m
//  AES
//
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "NSData+DPAES256.h"
#import "NSData+DPBase64.h"

#define DPPASSWORD @"Per vallum duces Labant"

//static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES256;
const NSUInteger kPBKDFRounds = 10000;  // ~80ms on an iPhone 4

static Byte saltBuff[] = {0,1,2,3,4,5,6,7,8,9,0xA,0xB,0xC,0xD,0xE,0xF};

static Byte ivBuff[]   = {0xA,1,0xB,5,4,0xF,7,9,0x17,3,1,6,8,0xC,0xD,91};

@implementation NSData (DPAES256)

+ (NSData *)AESKeyForPassword:(NSString *)password{                  //Derive a key from a text password/passphrase
    
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    NSData *salt = [NSData dataWithBytes:saltBuff length:kCCKeySizeAES128];
    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                  password.UTF8String,  // password密码
                                  password.length,      // passwordLength密码的长度
                                  salt.bytes,           // salt内容
                                  salt.length,          // saltLen长度
                                  kCCPRFHmacAlgSHA1,    // PRF
                                  kPBKDFRounds,         // rounds循环次数
                                  derivedKey.mutableBytes, // derivedKey
                                  derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for spassword: %d", result);
    return derivedKey;
}

/*加密方法*/
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain {

    return [self DP_AES256EncryptWithPlainText:plain encrypKey:DPPASSWORD];
}

/*加密方法，加密因子传递*/
+ (NSString *)DP_AES256EncryptWithPlainText:(NSString *)plain encrypKey:(NSString *)key {
    
    if (!plain || [plain isEqualToString:@""]) {
        
        return @"";
    }
    
    if (!key || [key isEqualToString:@""]) {
        
        NSLog(@"===加密因子异常\n");
        return nil;
    }
    
    NSData *plainText = [plain dataUsingEncoding:NSUTF8StringEncoding];
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256 + 1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSUInteger dataLength = [plainText length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          [[self AESKeyForPassword:key] bytes], kCCKeySizeAES256,
                                          ivBuff /* initialization vector (optional) */,
                                          [plainText bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [encryptData base64EncodedString];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

/*解密方法*/
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts{
    
    return [self DP_AES256DecryptWithCiphertext:ciphertexts decrypKey:DPPASSWORD];
}

+ (NSString *)DP_AES256DecryptWithCiphertext:(NSString *)ciphertexts decrypKey:(NSString *)key {
    
    if (!ciphertexts || [ciphertexts isEqualToString:@""]) {
        
        return @"";
    }
    
    if (!key || [key isEqualToString:@""]) {
        
        NSLog(@"===解密因子异常\n");
        return nil;
    }
    
    NSData *cipherData = [self dataFromBase64String:ciphertexts];
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256 + 1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          [[self AESKeyForPassword:key] bytes], kCCKeySizeAES256,
                                          ivBuff ,/* initialization vector (optional) */
                                          [cipherData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return [[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding];
    }
    
    free(buffer); //free the buffer;
    return nil;
}


@end
