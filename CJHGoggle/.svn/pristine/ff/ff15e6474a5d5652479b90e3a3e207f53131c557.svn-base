//
//  DPOpenSSLRSA.m
//  DPPayPlugin
//
//  Created by Hunter Li on 14-3-18.
//
//

#import "DPOpenSSLRSA.h"
#import "NSData+DPBase64.h"
#import "NSData+DPAES256.h"
#import "SXCocoaSecurity.h"

static NSString *DP_BEGIN_PRIVATE_KEY =  @"-----BEGIN RSA PRIVATE KEY-----";
static NSString *DP_END_PRIVATE_KEY  =  @"-----END RSA PRIVATE KEY-----";

static NSString *DP_BEGIN_PUBLIC_KEY =  @"-----BEGIN PUBLIC KEY-----";
static NSString *DP_END_PUBLIC_KEY  =  @"-----END PUBLIC KEY-----";

#define DP_SAFE_RSA_FREE(point) \
if(point != NULL) { \
RSA_free(point); \
point = NULL; \
}

@interface DPOpenSSLRSA ()

@end

@implementation DPOpenSSLRSA

+ (instancetype)shareInstance {
    
    static DPOpenSSLRSA *_openssl = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _openssl = [[self alloc] init];
        
    });
    
    return _openssl;
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        self.serverPublicKey = CJHServerPublickey;
        
        self.clientPublicKey = [self readRSAKey:DP_RSA_CLIENT_PUBLIC_KEY];
        
        self.clientPrivateKey = [self readRSAKey:DP_RSA_CLIENT_PRIVATE_KEY];
        
        if(!self.clientPrivateKey) {
            
            // 清除客户端公私钥
            [self cleanClientRSAKey];
            
            // 创建客户端公私钥
            [self creatClientRSAKey];
            
            // 暂时不存储公私钥，登录成功时才存储
        }
    }
    
    return self;
}

- (void)resetRSAKey {
    
    [self cleanClientRSAKey];
    
    [self creatClientRSAKey];
    
    // 将生成的公私钥对保存
    [self saveClientRSAKey];
}

- (id)readRSAKey:(NSString *)key {
    
    if (!key) {
        
        NSLog(@"key is null");
        return nil;
    }
    
    // token做加密因子

    NSString *token = @"token";
    
    if(!token) {
        
        return nil;
    }
    
    NSString *tempstr = [NSString stringWithFormat:@"%@", token];
    
    if(!tempstr || [tempstr length] == 0) {
        
        return nil;
    }
    
    id content = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([content isKindOfClass:[NSString class]]) {
        
        content = [NSData DP_AES256DecryptWithCiphertext:content decrypKey:tempstr];
        
    }
    else if ([content isKindOfClass:[NSArray class]]) {
        
        if ([(NSArray *)content count] <= 0) {
            
//            NSLog(@"<<<<<<<<数组是空值\n");
            return nil;
        }
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:content];
        
        for (NSInteger i = 0; i < [(NSArray *)content count]; i++) {
            
            NSString *tempcell  = [NSData DP_AES256DecryptWithCiphertext:[content objectAtIndex:i]  decrypKey:tempstr];//AES256 加密
            
            [array replaceObjectAtIndex:i withObject:tempcell];
        }
        
        content = array;
    }
    
    return content;
}

// 存储客户端本地RSA公私钥
- (void)saveClientRSAKey {
    
    if(self.clientPublicKey) {
        
        [self updateRSAKey:self.clientPublicKey key:DP_RSA_CLIENT_PUBLIC_KEY];
    }
    
    if(self.clientPrivateKey) {
        
        [self updateRSAKey:self.clientPrivateKey key:DP_RSA_CLIENT_PRIVATE_KEY];
    }
}

- (void)cleanClientRSAKey {
    
    self.clientPublicKey = nil;
    
    self.clientPrivateKey = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DP_RSA_CLIENT_PUBLIC_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DP_RSA_CLIENT_PRIVATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 更新RSA秘钥信息
- (void)updateRSAKey:(id)valueStr key:(NSString *)key {
    
    if (!key) {
        
        return;
    }
    
    // token做加密因子

    NSString *token = @"token";
    
    NSString *tempstr = [NSString stringWithFormat:@"%@", token];
    
    if(!tempstr || [tempstr length] == 0) {
        NSLog(@"<<<<<<<<写入数据异常,缺少加密因子");
        return;
    }
    
    if ([valueStr isKindOfClass:[NSString class]]) {
        
        valueStr = [NSData DP_AES256EncryptWithPlainText:valueStr encrypKey:tempstr];
    }
    else if([valueStr isKindOfClass:[NSArray class]]) {
        
        if([(NSArray *)valueStr count] <= 0) {
            
            NSLog(@"<<<<<<<<数组是空值\n");
            return;
        }
        
        for(NSInteger i = 0; i < [(NSArray *)valueStr count]; i++) {
            
            NSString *tempcell  = [NSData DP_AES256EncryptWithPlainText:[valueStr objectAtIndex:i]  encrypKey:tempstr];//AES256 加密
            [valueStr replaceObjectAtIndex:i withObject:tempcell];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:valueStr forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - encrypt method

- (NSString *)encrypt:(NSString *)plainText withPublicKey:(NSString *)publicKey {
    
    RSA *publicRSA = [self rsaObjectForPublicKey:publicKey];

    if(!publicRSA) {
        
        return nil;
    }
    
    size_t cipherTextLen = RSA_size(publicRSA);
    unsigned char cipherText[cipherTextLen + 1];
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    if(RSA_public_encrypt((int)[plainTextBytes length], [plainTextBytes bytes], cipherText, publicRSA, RSA_PKCS1_PADDING)) {
        
        NSData *encrypted = [NSData dataWithBytes:cipherText length:cipherTextLen];
        
        NSString *encryptedStr = [encrypted base64EncodedString];
        
        DP_SAFE_RSA_FREE(publicRSA);
        
        return encryptedStr;
    };
    
    DP_SAFE_RSA_FREE(publicRSA);
    
    return nil;
}

// 私钥加密
- (NSString *)encrypt:(NSString *)plainText withPrivateKey:(NSString *)privateKey {
    
    RSA *privateRSA = [self rsaObjectForPrivateKey:privateKey];
    
    if(!privateRSA) {
        
        return nil;
    }
    
    size_t cipherTextLen = RSA_size(privateRSA);
    unsigned char cipherText[cipherTextLen + 1];
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    if(RSA_private_encrypt((int)[plainTextBytes length], [plainTextBytes bytes], cipherText, privateRSA, RSA_PKCS1_PADDING)) {
        
        NSData *encrypted = [NSData dataWithBytes:cipherText length:cipherTextLen];
        
        NSString *encryptedStr = [encrypted base64EncodedString];
        
        DP_SAFE_RSA_FREE(privateRSA);
        
        return encryptedStr;
    };
    
    DP_SAFE_RSA_FREE(privateRSA);
    
    return nil;
}

#pragma mark - decrypt method

// 公钥解密
- (NSString *)decryptString:(NSString *)cipherString publicKey:(NSString *)publicKey {
    
    if(!cipherString || !publicKey) {
        
        return nil;
    }
    
    int padding = RSA_PKCS1_PADDING;
    
    NSData *cipherData = [NSData dataFromBase64String:cipherString];

    NSData *decryptedData = [self decryptData:cipherData publicKey:publicKey padding:padding];
    
    NSString *decryptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    return decryptedStr;
}

// 公钥解密
- (NSData *)decryptData:(NSData *)cipherData publicKey:(NSString *)publicKey padding:(int)padding {
    
    if(!cipherData || !publicKey) {
        
        return nil;
    }
    
    RSA *publicRSA = [self rsaObjectForPublicKey:publicKey];
    
    if(!publicRSA) {
        
        return nil;
    }
    
    size_t plainTextLen = RSA_size(publicRSA) - 11;
    
    char *plainText =  (char *)malloc(plainTextLen);
    bzero(plainText, plainTextLen);
    
    if(RSA_public_decrypt((int)[cipherData length], [cipherData bytes], (unsigned char *)plainText, publicRSA, padding)){
        
        NSData *decryptedData = [NSData dataWithBytes:plainText length:strlen(plainText)];
        
        DP_SAFE_RSA_FREE(publicRSA);
        
        return decryptedData;
    };
    
    DP_SAFE_RSA_FREE(publicRSA);
    
    return nil;
}

// 私钥解密
- (NSString *)decryptString:(NSString *)cipherString privateKey:(NSString *)privateKey {
    
    NSData *cipherData = [NSData dataFromBase64String:cipherString];
    
    NSData *decryptedData = [self decryptData:cipherData privateKey:privateKey padding:RSA_PKCS1_PADDING];
    
    NSString *decryptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    return decryptedStr;
}

- (NSData *)decryptData:(NSData *)cipherData privateKey:(NSString *)privatekey padding:(int)padding {
    
    RSA *privateRSA = [self rsaObjectForPrivateKey:privatekey];
    
    if(!privateRSA) {
        
        return nil;
    }
    
    size_t plainTextLen = RSA_size(privateRSA) - 11;
    
    char *plainText =  (char *)malloc(plainTextLen);
    bzero(plainText, plainTextLen);
    
    if (RSA_private_decrypt((int)[cipherData length], (unsigned char *)[cipherData bytes], (unsigned char *)plainText, privateRSA, padding)) {
        
        NSData *decryptedData = [NSData dataWithBytes:plainText length:strlen(plainText)];
        
        DP_SAFE_RSA_FREE(privateRSA);
        
        return decryptedData;
    };
    
    DP_SAFE_RSA_FREE(privateRSA);
    
    return nil;
}

#pragma mark - sign and verify method

// 私钥加签
- (NSData *)sign:(NSString *)plainText withPrivateKey:(NSString *)privateKey {
    
    BIO *privateBIO = NULL;
    EVP_PKEY *evp_pKey = NULL;
    
    NSData *privateKeyData = [self preparePrivateKey:privateKey];
    
    if(!privateKeyData) {
        
        NSLog(@"privateKey prepared failed!");
        return nil;
    }
    
    if (!(privateBIO = BIO_new_mem_buf((unsigned char *)[privateKeyData bytes], (int)[privateKeyData length]))) {
        
        NSLog(@"BIO_new_mem_buf() failed!");
        return nil;
    }
    
    if (!PEM_read_bio_PrivateKey(privateBIO, &evp_pKey, NULL, NULL)){
        NSLog(@"PEM_read_bio_RSAPrivateKey() failed!");
        return nil;
    }
    
    unsigned int siglen = EVP_PKEY_size(evp_pKey);
    unsigned char sigret[siglen];
    
    EVP_MD_CTX ctx;
    EVP_MD_CTX_init(&ctx);
    EVP_SignInit_ex(&ctx, EVP_sha1(), NULL);
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    EVP_SignUpdate(&ctx, (void *)[plainTextBytes bytes], [plainTextBytes length]);
    
    EVP_SignFinal(&ctx, sigret, &siglen, evp_pKey);
    
    EVP_MD_CTX_cleanup(&ctx);
    EVP_PKEY_free(evp_pKey);
    
    NSData *encryptedData = [NSData dataWithBytes:(const void *)sigret
                                           length:(NSUInteger)siglen];
    
    return encryptedData;
}

- (BOOL)verify:(NSString *)signString sign:(NSString *)sign publicKey:(NSString *)publicKey {
    
    RSA *publicRSA = [self rsaObjectForPublicKey:publicKey];
    
    const char *pSignString = [signString cStringUsingEncoding:NSUTF8StringEncoding];
    
    SXCocoaSecurityDecoder *decoder = [[SXCocoaSecurityDecoder alloc] init];
    
    NSData *data_sign = [decoder hex:sign];
    
    //签名验证
    int verifyResult = RSA_verify(NID_sha1WithRSA, (unsigned char *)pSignString, (unsigned int)[signString length], (unsigned char *)[data_sign bytes], (int)[data_sign length], publicRSA);
    
    DP_SAFE_RSA_FREE(publicRSA);
    
    return (verifyResult == 1) ? YES : NO;
}

#pragma mark - create object of RSA for the public key
// 将公钥存储到本地，并创建RSA对象
- (RSA *)rsaObjectForPublicKey:(NSString *)publicKey {
    
    RSA *publicRSA = nil;
    
    NSData *publicKeyData = [self preparePublicKey:publicKey];
    
    if(!publicKeyData) {
        
        NSLog(@"publicKey prepared failed!");
        return nil;
    }
    
    BIO *publicBIO = NULL;
    if (!(publicBIO = BIO_new_mem_buf((unsigned char *)[publicKeyData bytes], (int)[publicKeyData length]))) {
        
        NSLog(@"BIO_new_mem_buf() failed!");
        
        return nil;
    }
    
    if (!PEM_read_bio_RSA_PUBKEY(publicBIO, &publicRSA, NULL, NULL)) {
        
        NSLog(@"PEM_read_bio_RSA_PUBKEY() failed!");
        
        DP_SAFE_RSA_FREE(publicRSA);
        
        return nil;
    }
    
//    int status = RSA_check_key(publicRSA);
//    
//    if (status != 1) {
//        
//        NSLog(@"publicRSA状态%i", status);
//        
//        DP_SAFE_RSA_FREE(publicRSA);
//        
//        return nil;
//    }
    
    return publicRSA;
}

// 将公钥装备好begin和end，并每64位添加一个换行符
- (NSData *)preparePublicKey:(NSString *)publicKey {
    
    NSMutableString *tempStr = [NSMutableString stringWithString:publicKey];
    NSInteger qt = publicKey.length / 64;
    
    for (NSInteger i = 1; i <= qt; i++) {
        
        [tempStr insertString:@"\n" atIndex:(i * 64 + (i - 1))];
    }
    NSString *publicStr = [NSString stringWithFormat:@"%@\n%@\n%@", DP_BEGIN_PUBLIC_KEY, tempStr, DP_END_PUBLIC_KEY];
    
    NSData *publicKeyData = [publicStr dataUsingEncoding:NSUTF8StringEncoding];
    
    return publicKeyData;
}

#pragma mark - create object of RSA for the private key
// 将私钥存储到本地，并创建RSA对象
- (RSA *)rsaObjectForPrivateKey:(NSString *)privateKey {
    
    RSA *privateRSA = nil;
    
    NSData *privateKeyData = [self preparePrivateKey:privateKey];
    
    if(!privateKeyData) {
        
        NSLog(@"privateKey prepared failed!");
        return nil;
    }
    
    BIO *privateBIO = NULL;
    if (!(privateBIO = BIO_new_mem_buf((unsigned char *)[privateKeyData bytes], (int)[privateKeyData length]))) {
        
        NSLog(@"BIO_new_mem_buf() failed!");
        return nil;
    }
    
    if (!PEM_read_bio_RSAPrivateKey(privateBIO, &privateRSA, NULL, NULL)) {
        
        NSLog(@"PEM_read_bio_RSAPrivateKey() failed!");
        
        DP_SAFE_RSA_FREE(privateRSA);
        
        return nil;
    }
    
    int status = RSA_check_key(privateRSA);
    
    if (status != 1) {
        
        NSLog(@"publicRSA状态%i", status);
        
        DP_SAFE_RSA_FREE(privateRSA);
        
        return nil;
    }
    
    return privateRSA;
}

// 将私钥装备好begin和end，并每64位添加一个换行符
- (NSData *)preparePrivateKey:(NSString *)privateKey {
    
    NSMutableString *tempStr = [NSMutableString stringWithString:privateKey];
    NSInteger qt = privateKey.length / 64;
    
    for (NSInteger i = 1; i <= qt; i++) {
        
        [tempStr insertString:@"\n" atIndex:(i * 64 + ( i - 1 ))];
    }
    NSString *privateStr = [NSString stringWithFormat:@"%@\n%@\n%@", DP_BEGIN_PRIVATE_KEY, tempStr, DP_END_PRIVATE_KEY];
    
    NSData *privateKeyData = [privateStr dataUsingEncoding:NSUTF8StringEncoding];
    
    return privateKeyData;
}

#pragma mark - private method(create public and private key of client)

// 生成私钥并保存RSA对象用于后续的加解密
- (NSData *)generateRSAPrivateKeyWithLength:(int)length {
    
    RSA *clientPrivateRSA = NULL;
    
    do {
        
        clientPrivateRSA = RSA_generate_key(length, RSA_F4, NULL, NULL);
        
    } while (1 != RSA_check_key(clientPrivateRSA));
    
    BIO *bio = BIO_new(BIO_s_mem());
    
    if (!PEM_write_bio_RSAPrivateKey(bio, clientPrivateRSA, NULL, NULL, 0, NULL, NULL)) {
        
        NSLog(@"write public key failed");
        
        DP_SAFE_RSA_FREE(clientPrivateRSA);
        
        return nil;
    }
    
    char *pbio_data = NULL;
    long data_len = BIO_get_mem_data(bio, &pbio_data);
    NSData *result = [NSData dataWithBytes:pbio_data length:data_len];
    
    if (bio) {
        
        BIO_free(bio);
    }
    
    DP_SAFE_RSA_FREE(clientPrivateRSA);
    
    return result;
}

// 通过私钥生成公钥
- (NSData *)generateRSAPublicKeyFromPrivateKey:(NSData *)privateKey{
    
    BIO *pBIO = NULL;
    RSA *pRSA = NULL;
    
    if (!(pBIO = BIO_new_mem_buf((unsigned char *)[privateKey bytes], (int)[privateKey length]))) {
        
        NSLog(@"BIO_new_mem_buf() failed");
        
        return nil;
    }
    
    if (!PEM_read_bio_RSAPrivateKey(pBIO, &pRSA, NULL, NULL)) {
        
        NSLog(@"PEM_read_bio_RSAPrivateKey() failed");
        
        DP_SAFE_RSA_FREE(pRSA);
        
        return nil;
    }
    
    unsigned long check = RSA_check_key(pRSA);
    
    if (check != 1) {
        
        NSLog(@"RSA_check_key() failed with result %lu!", check);
        
        DP_SAFE_RSA_FREE(pRSA);
        
        return nil;
    }
    
    BIO *bio = BIO_new(BIO_s_mem());
    
    if (!PEM_write_bio_RSA_PUBKEY(bio, pRSA)) {
        
        NSLog(@"write public key failed");
        
        DP_SAFE_RSA_FREE(pRSA);
        
        return nil;
    }
    
    DP_SAFE_RSA_FREE(pRSA);
    
    char *pbio_data = NULL;
    long data_len = BIO_get_mem_data(bio, &pbio_data);
    NSData *result = [NSData dataWithBytes:pbio_data length:data_len];
    
    if (bio) {
        
        BIO_free(bio);
    }
    
    return result;
}

- (NSString *)splitClientPublicKey:(NSString *)publicKey {
    
    NSMutableString *publicKeys = [[NSMutableString alloc] init];
    
    NSInteger length = [publicKey length];
    
    // 分割长度
    NSInteger splitLength = 240;
    
    for (int i = 0; i < length; i += splitLength) {
        
        NSRange range = NSMakeRange(i, splitLength);
        
        if((i + splitLength) >= length) {
            
            range = NSMakeRange(i, length - i);
        }
        
        NSString *key_split = [publicKey substringWithRange:range];
        
        [publicKeys appendFormat:@"%@;", [self encrypt:key_split withPublicKey:self.serverPublicKey]];
    }
    
    if(!publicKeys || [publicKeys length] <= 0) {
        
        return nil;
    }
    
    // 将最后一个分号移除
    return [publicKeys substringWithRange:NSMakeRange(0, [publicKeys length] - 1)];
}

//  生成公私钥对
- (void)creatClientRSAKey {
    
    NSData *privateData = [self generateRSAPrivateKeyWithLength:1024];
    
    NSString *privateStr = [[NSString alloc] initWithData:privateData encoding:NSUTF8StringEncoding];
    
    {
        NSRange beginRange = [privateStr rangeOfString:DP_BEGIN_PRIVATE_KEY];
        
        NSRange endRange = [privateStr rangeOfString:DP_END_PRIVATE_KEY];
        
        privateStr = [privateStr substringWithRange:NSMakeRange((beginRange.location + beginRange.length), endRange.location - (beginRange.location + beginRange.length))];
        
        privateStr = [privateStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        privateStr = [privateStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        privateStr = [privateStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        privateStr = [privateStr stringByReplacingOccurrencesOfString:@" "  withString:@""];
    }

    
    NSData *tempPublic = [self generateRSAPublicKeyFromPrivateKey:privateData];
    
    NSString *publicStr = [[NSString alloc] initWithData:tempPublic encoding:NSUTF8StringEncoding];
    
    {
        NSRange beginRange = [publicStr rangeOfString:DP_BEGIN_PUBLIC_KEY];
        
        NSRange endRange = [publicStr rangeOfString:DP_END_PUBLIC_KEY];
        
        publicStr = [publicStr substringWithRange:NSMakeRange((beginRange.location + beginRange.length), endRange.location - (beginRange.location + beginRange.length))];
        
        publicStr = [publicStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        publicStr = [publicStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        publicStr = [publicStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        publicStr = [publicStr stringByReplacingOccurrencesOfString:@" "  withString:@""];
    }
    
    publicStr = [self splitClientPublicKey:publicStr];
    
    if (publicStr) {
        
        self.clientPrivateKey = privateStr;
        
        self.clientPublicKey = publicStr;
    }
}

@end
