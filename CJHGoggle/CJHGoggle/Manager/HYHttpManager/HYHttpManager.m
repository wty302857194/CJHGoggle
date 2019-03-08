//
//  HYHttpManager.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYHttpManager.h"
#import "SXCocoaSecurity.h"
#import "DPOpenSSLRSA.h"
#import "SXRSA.h"

NSString * const HttpRequestSignKey = @"d9b1d7db4cd6e70935368a1efb10e377";

NSString * const HttpRequestCache = @"HttpRequestCache";

static NSMutableArray *requestTasks;//管理网络请求的队列

static NSMutableDictionary *headers; //请求头的参数设置

static HYNERWORK_STATUS networkStatus; //网络状态

static NSTimeInterval requestTimeout = 40;//请求超时时间

static NSString * const ERROR_IMFORMATION = @"网络出现错误，请检查网络连接";

#define ERROR [NSError errorWithDomain:@"请求失败" code:-999 userInfo:@{ NSLocalizedDescriptionKey:ERROR_IMFORMATION}]

@implementation HYHttpManager

+ (NSMutableArray *)allTasks {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (requestTasks == nil) {
            
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

+ (void)configHttpHeaders:(NSDictionary *)httpHeaders {
    
    headers = httpHeaders.mutableCopy;
}

+ (void)setupTimeout:(NSTimeInterval)timeout {
    
    requestTimeout = timeout;
}

+ (AFHTTPSessionManager *)manager {
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    
    [HYHttpManager configHttpHeaders:@{
                                       @"token" : [HYManager sharedManager].currentUser ? HYNONNil([HYManager sharedManager].currentUser.token) : @"",
                                       @"device_sn" : HYNONNil([HYManager sharedManager].getDeviceId),
                                       }];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"application/x-www-form-urlencoded",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/png",
                                                                              @"image/jpg",
                                                                              @"image/*"]];
    manager.requestSerializer.timeoutInterval = requestTimeout;
    
    [self detectNetworkStaus];
    
    return manager;
}

#pragma - 请求

+ (HYURLSessionTask *)postRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                             parserClass:(Class)parserClass
                            successBlock:(HYResponseSuccessBlock)successBlock
                               failBlock:(HYResponseFailBlock)failBlock {
    
    NSString *privateKey = [DPOpenSSLRSA shareInstance].clientPrivateKey;
    
    NSString *orignalString = [NSString dpOriginalData:params];
    
    NSData *signData = [[DPOpenSSLRSA shareInstance] sign:orignalString withPrivateKey:privateKey];
    
    NSString *signString = [signData base64EncodedString];
    
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [mutableParams setObject:HYNONNil(signString) forKey:@"sign"];
    
    return [self postRequestWithUrl:url params:mutableParams successBlock:^(id response) {
        
        if(response && [response isKindOfClass:[NSDictionary class]]) {
            
            HYLog(@"%@", response);
            
            // 开始验签
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:response];
            [dict removeObjectForKey:@"sign"];
            
            NSString *signString = [NSString dp_stringWithDictionary:response key:@"sign"];
            
            BOOL bRe = [SXRSA verify:[NSString dpOriginalData:dict] sign:signString publicKey:[DPOpenSSLRSA shareInstance].serverPublicKey];
            
            // 调试状态暂时不验签
            bRe = YES;
            
            if (bRe) {
                // 验签通过
                HYResponseStatus *status = [HYResponseStatus mj_objectWithKeyValues:response];
                
                if([status stateIsSuccess]) {
                    // 成功
                    
                    id obj = nil;
                    
                    id result = [response objectForKey:@"data"];
                    
                    if(result && [result isKindOfClass:[NSString class]]) {
                        
                        obj = [parserClass objectWithStringValue:response];
                    }
                    else if(result && [parserClass isSubclassOfClass:[HYBaseModel class]]) {
                        
                        obj = [parserClass objectWithKeyValues:response];
                    }
                    
                    if(successBlock) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            successBlock(obj);
                        });
                    }
                }
                else if([status stateIsTokenExpired]) {
                    
                    if(failBlock) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            failBlock([status toError]);
                        });
                    }
                    
                    [HYFoundationCommon promotDialogWithTitle:@"系统提示" message:@"登录已过期，请重新登录！"];
                    
                    [[HYManager sharedManager] logout];
                }
                else if(failBlock) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failBlock([status toError]);
                    });
                }
            }
            else {
                
                [[HYManager sharedManager] logout];
                
                // 验签未通过
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    HYResponseStatus *status = [HYResponseStatus verifySignError];
                
                    failBlock([status toError]);
                });
            }
        }
        else if(failBlock) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                HYResponseStatus *status = [HYResponseStatus parserError];
                
                failBlock([status toError]);
            });
        }
        
    } failBlock:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HYResponseStatus *status = [HYResponseStatus networkError];
            status.msg = [error localizedDescription];
            failBlock([status toError]);
        });
    }];
    
}

+ (HYURLSessionTask *)postRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                        successBlock:(HYResponseSuccessBlock)successBlock
                           failBlock:(HYResponseFailBlock)failBlock {
    
    return [self requestWithUrl:url
                         params:params
                    httpMedthod:HYREQUEST_POST
                  progressBlock:nil
                   successBlock:successBlock
                      failBlock:failBlock];
}

+ (HYURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                           successBlock:(HYResponseSuccessBlock)successBlock
                              failBlock:(HYResponseFailBlock)failBlock {
    return [self requestWithUrl:url
                         params:params
                    httpMedthod:HYREQUEST_GET
                  progressBlock:nil
                   successBlock:successBlock
                      failBlock:failBlock];
}

+ (HYURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                            parserClass:(Class)parserClass
                           successBlock:(HYResponseSuccessBlock)successBlock
                              failBlock:(HYResponseFailBlock)failBlock {
    
    
    return [self getRequestWithUrl:url params:params successBlock:^(id response) {
        
        if(response && [response isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"%@", response);
            
            HYResponseStatus *status = [HYResponseStatus objectWithKeyValues:response];
            
            if([status stateIsSuccess]) {
                // 成功
                
                id obj = nil;
                
                id result = [response objectForKey:@"data"];
                
                if(result && [result isKindOfClass:[NSString class]]) {
                    
                    obj = [parserClass objectWithStringValue:result];
                }
                else if(result && [parserClass isSubclassOfClass:[HYBaseModel class]]) {
                    
                    obj = [parserClass objectWithKeyValues:result];
                }
                
                if(successBlock) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        successBlock(obj);
                    });
                }
            }
            else if([status stateIsTokenExpired]) {
                
                if(failBlock) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failBlock([status toError]);
                    });
                }
            }
            else if(failBlock) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock([status toError]);
                });
            }
        }
        else if(failBlock) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                HYResponseStatus *status = [HYResponseStatus parserError];
                
                failBlock([status toError]);
            });
        }
        
    } failBlock:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HYResponseStatus *status = [HYResponseStatus networkError];
            status.msg = [error localizedDescription];
            failBlock([status toError]);
        });
    }];
}

+ (HYURLSessionTask *)requestWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                         httpMedthod:(HYREQUEST_TYPE)httpMethod
                        successBlock:(HYResponseSuccessBlock)successBlock
                           failBlock:(HYResponseFailBlock)failBlock {
    
    return [self requestWithUrl:url
                         params:params
                    httpMedthod:httpMethod
                  progressBlock:nil
                   successBlock:successBlock
                      failBlock:failBlock];
}

+ (NSDictionary *)paramsWith:(NSDictionary *)params {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if(params) {
        
        dictionary = [NSMutableDictionary dictionaryWithDictionary:params];
        
        NSInteger timeStamp = [[NSDate date] utcTimeStamp];
        
        [dictionary setObject:@(timeStamp) forKey:@"timestamp"];

        NSArray *signArray = [dictionary objectForKey:@"signArray"];
        
        if(signArray) {
            
            NSString *sign = @"";
            
            for (NSString *key in signArray) {
                
                NSString *value = [NSString dp_stringWithDictionary:dictionary key:key];
                
                if(value) {
                    
                    sign = [NSString stringWithFormat:@"%@%@%@=%@", sign, ([NSString dp_isEmptyString:sign] ? @"" : @"&"), key, value];
                }
            }
            
            SXCocoaSecurityResult *result = [SXCocoaSecurity hmacSha256:sign hmacKey:HttpRequestSignKey];
            
            [dictionary setObject:HYNONNil(result.hex) forKey:@"sign"];
        }
        
        [dictionary removeObjectForKey:@"signArray"];
        
//        NSArray *array = [dictionary allKeys];
//
//        // 默认升序
//        NSArray *allKeys = [array sortedArrayUsingSelector:@selector(compare:)];
//
//        NSString *sign = @"";
//
//        for (NSString *key in allKeys) {
//
//            NSString *value = [NSString dp_stringWithDictionary:dictionary key:key];
//
//            if(value) {
//
//                sign = [NSString stringWithFormat:@"%@%@%@=%@", sign, ([NSString dp_isEmptyString:sign] ? @"" : @"&"), key, value];
//            }
//        }
//        SXCocoaSecurityResult *result = [SXCocoaSecurity hmacSha256:sign hmacKey:HttpRequestSignKey];
//
//        [dictionary setObject:HYNONNil(result.hex) forKey:@"sign"];
    }
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

+ (HYURLSessionTask *)requestWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                       httpMedthod:(HYREQUEST_TYPE)httpMethod
                     progressBlock:(HYNetWorkingProgress)progressBlock
                      successBlock:(HYResponseSuccessBlock)successBlock
                         failBlock:(HYResponseFailBlock)failBlock {
    
    return [self requestWithUrl:url needHttpUrl:YES params:params httpMedthod:httpMethod progressBlock:progressBlock successBlock:successBlock failBlock:failBlock];
}

+ (HYURLSessionTask *)requestWithUrl:(NSString *)url
                         needHttpUrl:(BOOL)needHttpUrl
                              params:(NSDictionary *)params
                         httpMedthod:(HYREQUEST_TYPE)httpMethod
                       progressBlock:(HYNetWorkingProgress)progressBlock
                        successBlock:(HYResponseSuccessBlock)successBlock
                           failBlock:(HYResponseFailBlock)failBlock {
    
    //处理中文和空格问题
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if(needHttpUrl) {
        
        url = [NSString stringWithFormat:@"%@%@", URL_main, url];
    }
    
    AFHTTPSessionManager *manager = [self manager];
    HYURLSessionTask *session;
    
    NSDictionary *dictionary = params;
    
    if (httpMethod == HYREQUEST_POST) {
        
        if (networkStatus == HYNERWORK_NOTREACHABLE ||  networkStatus == HYNERWORK_UNKNOWN) {
            
            failBlock ? failBlock(ERROR) : nil;
            
            return nil;
        }
        
        session = [manager POST:url parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (progressBlock) {
                
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //            HYLog(@"%@",responseObject);
            
            successBlock ? successBlock(responseObject) : nil;
            
            [[self allTasks] removeObject:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            failBlock ? failBlock(error) : nil;
            
            [[self allTasks] removeObject:task];
        }];
        
    }
    else if(httpMethod == HYREQUEST_GET) {
        
        if (networkStatus == HYNERWORK_NOTREACHABLE ||  networkStatus == HYNERWORK_UNKNOWN) {
            
            failBlock ? failBlock(ERROR) : nil;
            
            return nil;
        }
        
        session = [manager GET:url parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (progressBlock) {
                
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //            HYLog(@"%@",responseObject);
            
            successBlock ? successBlock(responseObject) : nil;
            
            [[self allTasks] removeObject:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            failBlock ? failBlock(error) : nil;
            
            [[self allTasks] removeObject:task];
        }];
    }
    
    if (session) {
        
        [requestTasks addObject:session];
    }
    return  session;
}

+ (void)updateRequestSerializerType:(HYSERIALIZER_TYPE)requestType responseSerializer:(HYSERIALIZER_TYPE)responseType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (requestType) {
        
        switch (requestType) {
                
            case HYSERIALIZER_HTTP: {
                
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
            }
            case HYSERIALIZER_JSON: {
                
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
            }
            default:
                break;
        }
    }
    
    if (responseType) {
        
        switch (responseType) {
                
            case HYSERIALIZER_HTTP: {
                
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
            }
                
            case HYSERIALIZER_JSON: {
                
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                break;
            }
            default:
                break;
        }
    }
}


#pragma 图片，文件上传下载方法
+ (HYURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                                 name:(NSString *)name
                                 type:(NSString *)type
                               params:(NSDictionary *)params
                        progressBlock:(HYNetWorkingProgress)progressBlock
                         successBlock:(HYResponseSuccessBlock)successBlock
                            failBlock:(HYResponseFailBlock)failBlock {
    
    AFHTTPSessionManager *manager = [self manager];
    
    HYURLSessionTask *session = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
        
        NSString *imageFileName;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        imageFileName = [NSString stringWithFormat:@"%@.png", str];
        
        NSString *blockImageType = type;
        
        if (type.length == 0) blockImageType = @"image/jpeg";
        
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:blockImageType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : nil;
        
        [[self allTasks] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock ? failBlock(error) : nil;
        
        [[self allTasks] removeObject:task];
    }];
    
    [session resume];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (HYURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                          progressBlock:(HYNetWorkingProgress)progressBlock
                           successBlock:(HYResponseSuccessBlock)successBlock
                              failBlock:(HYResponseFailBlock)failBlock {
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    HYURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        successBlock ? successBlock(responseObject) : nil;
        
        failBlock && error ? failBlock(error) : nil;
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (HYURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                        progressBlock:(HYNetWorkingProgress)progressBlock
                         successBlock:(HYResponseSuccessBlock)successBlock
                            failBlock:(HYResponseFailBlock)failBlock {
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self manager];
    
    HYURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        successBlock ? successBlock(filePath.absoluteString) : nil;
        
        failBlock && error ? failBlock(error) : nil;
    }];
    
    [session resume];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
+ (void)cancelAllRequest {
    
    @synchronized(self) {
        
        [[self allTasks] enumerateObjectsUsingBlock:^(HYURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task isKindOfClass:[HYURLSessionTask class]]) {
                
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
    
    @synchronized(self) {
        
        [[self allTasks] enumerateObjectsUsingBlock:^(HYURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task isKindOfClass:[HYURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                
                [task cancel];
                
                [[self allTasks] removeObject:task];
                
                return;
            }
        }];
    };
}

/**
 *  拼接post请求的网址
 *
 *  @param urlStr     基础网址
 *  @param parameters 拼接参数
 *
 *  @return 拼接完成的网址
 */
+ (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters{
    if (!parameters) {
        return urlStr;
    }
    
    NSMutableArray *parts = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        [parts addObject:part];
        
    }];
    
    NSString *queryString = [parts componentsJoinedByString:@"&"];
    
    queryString = queryString ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    
    NSString *pathStr = [NSString stringWithFormat:@"%@?%@",urlStr,queryString];
    
    return pathStr;
}


#pragma mark - 网络状态的检测
+ (void)detectNetworkStaus {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [reachabilityManager startMonitoring];
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            networkStatus = HYNERWORK_NOTREACHABLE;
            
        }
        else if (status == AFNetworkReachabilityStatusUnknown) {
            
            networkStatus = HYNERWORK_UNKNOWN;
            
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            
            networkStatus = HYNERWORK_NORMAL;
        }
    }];
}


@end
