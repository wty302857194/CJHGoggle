//
//  HYHTTPClient.h
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ZJReachabilityStatusUnknown,//未识别网络
    ZJReachabilityStatusNo,//未连接网络
    ZJReachabilityStatus3G4G,//3G/4G网络
    ZJReachabilityStatusWiFi,//Wifi网络
} ZJNetworkReachabilityStatus;

@interface HYHTTPClient : NSObject

//post请求
+(void)asynchronousPostRequest:(NSString*)url parameters:(NSDictionary *)parameters successBlock:(void (^)(BOOL success,id data,NSString* msg))successBlock failureBlock:(void (^)(NSString* description))failureBlock;

//get请求
+(void)asynchronousGetRequest:(NSString*)url parameters:(NSDictionary *)parameters successBlock:(void (^)(BOOL success,NSDictionary *data,NSString* msg))successBlock failureBlock:(void (^)(NSString* description))failureBlock;

/**
 *  上传文件
 *
 *  @param paramDic   传参
 *  @param requestURL 链接
 *  @param dataArray  图片date数组
 *  @param dataName   图片名字
 *  @param dataKey    图片key
 *  @param success    失败回调
 *  @param failure    失败回调
 *  @param progress   上传进度
 */
+ (void)uploadFileWithOption:(NSDictionary *)paramDic
              withRequestURL:(NSString*)requestURL
                   dataArray:(NSMutableArray *)dataArray
                    dataName:(NSMutableArray *)dataName
                     dataKey:(NSMutableArray *)dataKey
             downloadSuccess:(void (^)(id responseObject))success
             downloadFailure:(void (^)(NSError *error))failure
                    progress:(void (^)(float progress))progress;


+ (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(id responseObject))success
               downloadFailure:(void (^)(NSError *error))failure
                      progress:(void (^)(float progress))progress;

@end
