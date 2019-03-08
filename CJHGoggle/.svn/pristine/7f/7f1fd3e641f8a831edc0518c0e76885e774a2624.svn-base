//
//  HYUserModel.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/9.
//  Copyright © 2018年 CJH. All rights reserved.
//
/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */

#import "HYUserModel.h"
#import "DPOpenSSLRSA.h"

#import "SXRSA.h"

#import <AFNetworking.h>

@implementation HYUserModel

+(void)postRequest:(NSString*)url parameters:(NSDictionary *)parameters successBlock:(void (^)(BOOL success,NSDictionary *data,NSString* msg))successBlock failureBlock:(void (^)(NSString* description))failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSString *privateKey = [DPOpenSSLRSA shareInstance].clientPrivateKey;// 客户端生成的私钥
    
    NSString *orignalString = [NSString dpOriginalData:parameters];//传给app用于加签的hexstring
    
    NSData *signData = [[DPOpenSSLRSA shareInstance] sign:orignalString withPrivateKey:privateKey];// 私钥加签
    
    NSString *signString = [signData base64EncodedString];
    
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [mutableParams setObject:signString?:@"" forKey:@"sign"];

    [manager POST:url parameters:mutableParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            // 开始验签
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            [dict removeObjectForKey:@"sign"];
            
            NSString *signString = [NSString dp_stringWithDictionary:responseObject key:@"sign"];
            
            BOOL bRe = [SXRSA verify:[NSString dpOriginalData:dict] sign:signString publicKey:[DPOpenSSLRSA shareInstance].serverPublicKey];
            
            if (bRe) {
                // 验签通过
             
                HYResponseStatus *status = [HYResponseStatus mj_objectWithKeyValues:responseObject];
                
                if ([status stateIsSuccess]) {
                    
                    [[DPOpenSSLRSA shareInstance] saveClientRSAKey];
                    
                    successBlock(YES, [responseObject objectForKey:@"data"], [responseObject objectForKey:@"msg"]);
                }
                else {
                    
                    failureBlock([responseObject objectForKey:@"msg"]);
                }
            }
            else {
                
                NSLog(@"验签失败");
                
                failureBlock(@"验签失败");
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        failureBlock(error.localizedDescription);
        
    }];
    
}

@end
