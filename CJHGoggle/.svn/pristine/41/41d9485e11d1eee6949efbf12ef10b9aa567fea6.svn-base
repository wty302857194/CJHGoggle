//
//  CJHApiTest.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/6/26.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "CJHApiTest.h"

#import "DPOpenSSLRSA.h"

#import "SXRSA.h"

@implementation CJHApiTest

+ (void)testLogin {

    NSString *url = @"http://192.168.1.210:8080/admin/login";
    
    NSDictionary *params = @{
                             @"username" : @"1111",
                             @"password" : @"1111",
                             @"device_sn" : [[HYManager sharedManager] getDeviceId],
                             @"client_public_key" : [DPOpenSSLRSA shareInstance].clientPublicKey,
                             };

    NSString *privateKey = [DPOpenSSLRSA shareInstance].clientPrivateKey;
    
    NSString *orignalString = [NSString dpOriginalData:params];
    
    NSData *signData = [[DPOpenSSLRSA shareInstance] sign:orignalString withPrivateKey:privateKey];
    
    NSString *signString = [signData base64EncodedString];
    
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [mutableParams setObject:HYNONNil(signString) forKey:@"sign"];
    
    
    [HYHttpManager requestWithUrl:url needHttpUrl:NO params:mutableParams httpMedthod:HYREQUEST_POST progressBlock:nil successBlock:^(id response) {
        
        NSLog(@"%@", response);
        
        if(response && [response isKindOfClass:[NSDictionary class]]) {
            
            // 开始验签
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:response];
            [dict removeObjectForKey:@"sign"];
            
            NSString *signString = [NSString dp_stringWithDictionary:response key:@"sign"];
            
            BOOL bRe = [SXRSA verify:[NSString dpOriginalData:dict] sign:signString publicKey:[DPOpenSSLRSA shareInstance].serverPublicKey];
            
            HYResponseStatus *status = [HYResponseStatus objectWithKeyValues:response];
            
            if([status stateIsSuccess]) {
                // 成功
                
                NSDictionary *dictionary_data = [response objectForKey:@"data"];
                
                NSString *userid = [NSString dp_stringWithDictionary:dictionary_data key:@"userid"];
                NSString *token = [NSString dp_stringWithDictionary:dictionary_data key:@"token"];
                token = [[DPOpenSSLRSA shareInstance] decryptString:token privateKey:[DPOpenSSLRSA shareInstance].clientPrivateKey];
                
                
                if(bRe) {
                    
                    [HYFoundationCommon promotDialog:@"登录" message:@"验签通过" cancelTitle:@"取消" commitTitle:@"用户信息接口" cancelHandler:^{
                        
                    } commitHandler:^{
                        
                        [self performSelector:@selector(testFetchUserInfo:) withObject:@{@"userid" : userid, @"token" : token} afterDelay:0.2];
                    }];
                }
                else {
                    
                    [HYFoundationCommon promotDialogWithTitle:@"登录" message:@"验签失败"];
                }
                
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    [self testFetchUserInfo:userid token:token];
//                });
            }
            else if([status stateIsTokenExpired]) {
                
            }
        }
        
    } failBlock:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
    
}

+ (void)testFetchUserInfo:(NSDictionary *)dictionary {
    
    NSString *userid = [NSString dp_stringWithDictionary:dictionary key:@"userid"];
    NSString *token = [NSString dp_stringWithDictionary:dictionary key:@"token"];
    
    NSString *url = @"http://192.168.1.210:8080/admin/userinfo";
    
    NSDictionary *params = @{
                             @"userid" : HYNONNil(userid),
                             };
    
    NSString *privateKey = [DPOpenSSLRSA shareInstance].clientPrivateKey;
    
    NSString *orignalString = [NSString dpOriginalData:params];
    
    NSData *signData = [[DPOpenSSLRSA shareInstance] sign:orignalString withPrivateKey:privateKey];
    
    NSString *signString = [signData base64EncodedString];
    
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [mutableParams setObject:HYNONNil(signString) forKey:@"sign"];
    
    [HYHttpManager configHttpHeaders:@{@"token" : HYNONNil(token)}];
    
    [HYHttpManager requestWithUrl:url needHttpUrl:NO params:mutableParams httpMedthod:HYREQUEST_POST progressBlock:nil successBlock:^(id response) {
        
        NSLog(@"%@", response);
        
        if(response && [response isKindOfClass:[NSDictionary class]]) {
            
            // 开始验签
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:response];
            [dict removeObjectForKey:@"sign"];
            
            NSString *signString = [NSString dp_stringWithDictionary:response key:@"sign"];
            
            BOOL bRe = [SXRSA verify:[NSString dpOriginalData:dict] sign:signString publicKey:[DPOpenSSLRSA shareInstance].serverPublicKey];
            
            [HYFoundationCommon promotDialogWithTitle:@"获取用户信息" message:(bRe ? @"验签通过" : @"验签失败")];
            
            HYResponseStatus *status = [HYResponseStatus objectWithKeyValues:response];
            
            if([status stateIsSuccess]) {
                // 成功
                
                id result = [response objectForKey:@"data"];
                
            }
            else if([status stateIsTokenExpired]) {
                
            }
        }
        
    } failBlock:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
    
}

@end
