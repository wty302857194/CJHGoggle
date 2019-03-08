//
//  DPOpenSSLRSA.h
//  DPPayPlugin
//
//  Created by Hunter Li on 14-3-18.
//
//

#import <Foundation/Foundation.h>
#import <openssl/rsa.h>
#import <openssl/pem.h>

@interface DPOpenSSLRSA : NSObject

// 客户端生成的私钥
@property (nonatomic, copy) NSString *clientPrivateKey;
// 客户端生成的公钥，会上传给服务器用于数据加密
@property (nonatomic, copy) NSString *clientPublicKey;
// 服务器公钥，私钥存储在服务器上
@property (nonatomic, copy) NSString *serverPublicKey;

+ (instancetype)shareInstance;

// 重新生成RSA公私钥
- (void)resetRSAKey;

// 清除生成的RSA公私钥
- (void)cleanClientRSAKey;

// 存储客户端本地RSA公私钥
- (void)saveClientRSAKey;


// 公钥加密
- (NSString *)encrypt:(NSString *)plainText withPublicKey:(NSString *)publickey;
// 私钥加密
- (NSString *)encrypt:(NSString *)plainText withPrivateKey:(NSString *)privatekey;

/**
 快钱公钥解密解密
 @param cipherData 被加密的数据，被base64加密处理过
 @param privatekey 客户端私钥
 @return 解密后的数据
 */
- (NSString *)decryptString:(NSString *)cipherString publicKey:(NSString *)publicKey;

/**
 快钱公钥解密解密
 @param cipherData 被加密的数据，被base64加密处理过
 @param privatekey 客户端私钥
 @param padding 解密算法
 @return 解密后的数据
 */
- (NSData *)decryptData:(NSData *)cipherData publicKey:(NSString *)publicKey padding:(int)padding;


/**
 客户端私钥解密
 @param cipherData 被加密的数据，被base64加密处理过
 @param privatekey 客户端私钥
 @return 解密后的数据
 */
- (NSString *)decryptString:(NSString *)cipherString privateKey:(NSString *)privateKey;

/**
 客户端私钥解密
 @param cipherData 被加密的数据，被base64加密处理过
 @param privatekey 客户端私钥
 @param padding 解密算法
 @return 解密后的数据
 */
- (NSData *)decryptData:(NSData *)cipherData privateKey:(NSString *)privatekey padding:(int)padding;

// 私钥加签
- (NSData *)sign:(NSString *)plainText withPrivateKey:(NSString *)privateKey;

// 公钥验签
- (BOOL)verify:(NSString *)signString sign:(NSString *)sign publicKey:(NSString *)publicKey;

@end
