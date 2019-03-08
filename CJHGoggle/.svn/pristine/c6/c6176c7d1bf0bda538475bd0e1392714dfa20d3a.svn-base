//
//  HYHttpManager.h
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络状态
typedef NS_ENUM(NSInteger, HYNERWORK_STATUS) {
    
    HYNERWORK_UNKNOWN = 1 << 0,     // 未知网络
    
    HYNERWORK_NOTREACHABLE = 1 << 2, // 无法连接
    
    HYNERWORK_NORMAL = 1 << 3,  // 网络正常
};

// 请求方式
typedef NS_ENUM(NSInteger, HYREQUEST_TYPE) {
    
    HYREQUEST_POST = 1 << 0,    // POST方式来进行请求
    HYREQUEST_GET  = 1 << 1,    // GET方式来进行请求
};

// 数据序列化方式
typedef NS_ENUM(NSInteger, HYSERIALIZER_TYPE) {
    
    HYSERIALIZER_HTTP = 1 << 0, // HTTP方式来进行请求或响应
    
    HYSERIALIZER_JSON = 1 << 1, // JSON方式来进行请求或响应
};

typedef NSURLSessionTask HYURLSessionTask;

// 成功回调
typedef void(^HYResponseSuccessBlock)(id response);

// 失败回调
typedef void(^HYResponseFailBlock)(NSError *error);

/**
 *  进度
 *
 *  @param bytesRead              已下载或者上传进度的大小
 *  @param totalBytes                总下载或者上传进度的大小
 */
typedef void(^HYNetWorkingProgress)(int64_t bytesRead, int64_t totalBytes);

@interface HYHttpManager : NSObject

/**
 *  发起请求的参数键值对
 */
@property (strong, nonatomic) NSMutableDictionary *parameters;

+ (AFHTTPSessionManager *)manager;

/**
 *  配置请求头
 *
 *  @param httpHeaders 请求头参数
 */
+ (void)configHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *  取消所有请求
 */
+ (void)cancelAllRequest;

/**
 *  根据url取消请求
 *
 *  @param url 请求url
 */
+ (void)cancelRequestWithURL:(NSString *)url;


/**
 *	设置超时时间
 *
 *  @param timeout 超时时间
 */
+ (void)setupTimeout:(NSTimeInterval)timeout;

/**
 *  更新请求或者返回数据的解析方式(0为HTTP模式，1为JSON模式)
 *
 *  @param requestType  请求数据解析方式
 *  @param responseType 返回数据解析方式
 */
+ (void)updateRequestSerializerType:(HYSERIALIZER_TYPE)requestType
                 responseSerializer:(HYSERIALIZER_TYPE)responseType;

/**
 *  POST请求接口
 *
 *  @param url              请求路径
 *  @param params           拼接参数
 *  @param successBlock     成功回调block
 *  @param failBlock        失败回调block
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)postRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                            successBlock:(HYResponseSuccessBlock)successBlock
                               failBlock:(HYResponseFailBlock)failBlock;

/**
 *  POST请求接口
 *
 *  @param url              请求路径
 *  @param params           拼接参数
 *  @param parserClass      解析器类名
 *  @param successBlock     成功回调block
 *  @param failBlock        失败回调block
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)postRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                             parserClass:(Class)parserClass
                            successBlock:(HYResponseSuccessBlock)successBlock
                               failBlock:(HYResponseFailBlock)failBlock;

/**
 *  GET请求接口
 *
 *  @param url              请求路径
 *  @param params           拼接参数
 *  @param successBlock     成功回调block
 *  @param failBlock        失败回调block
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                           successBlock:(HYResponseSuccessBlock)successBlock
                              failBlock:(HYResponseFailBlock)failBlock;

/**
 *  GET请求接口
 *
 *  @param url              请求路径
 *  @param params           拼接参数
 *  @param parserClass      解析器类名
 *  @param successBlock     成功回调block
 *  @param failBlock        失败回调block
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                            parserClass:(Class)parserClass
                           successBlock:(HYResponseSuccessBlock)successBlock
                              failBlock:(HYResponseFailBlock)failBlock;

/**
 *  统一请求接口
 *
 *  @param url              请求路径
 *  @param params           拼接参数
 *  @param httpMethod       请求方式（0为POST,1为GET）
 *  @param progressBlock    进度回调
 *  @param successBlock     成功回调block
 *  @param failBlock        失败回调block
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)requestWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                         httpMedthod:(HYREQUEST_TYPE)httpMethod
                       progressBlock:(HYNetWorkingProgress)progressBlock
                        successBlock:(HYResponseSuccessBlock)successBlock
                           failBlock:(HYResponseFailBlock)failBlock;

+ (HYURLSessionTask *)requestWithUrl:(NSString *)url
                         needHttpUrl:(BOOL)needHttpUrl
                              params:(NSDictionary *)params
                         httpMedthod:(HYREQUEST_TYPE)httpMethod
                       progressBlock:(HYNetWorkingProgress)progressBlock
                        successBlock:(HYResponseSuccessBlock)successBlock
                           failBlock:(HYResponseFailBlock)failBlock;

/**
 *  图片上传接口
 *
 *	@param image            图片对象
 *  @param url              请求路径
 *	@param name             图片名
 *	@param type             默认为image/jpeg
 *	@param params           拼接参数
 *	@param progressBlock    上传进度
 *	@param successBlock     成功回调
 *	@param failBlock		失败回调
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                                 name:(NSString *)name
                                 type:(NSString *)type
                               params:(NSDictionary *)params
                        progressBlock:(HYNetWorkingProgress)progressBlock
                         successBlock:(HYResponseSuccessBlock)successBlock
                            failBlock:(HYResponseFailBlock)failBlock;

/**
 *  文件上传接口
 *
 *  @param url              上传文件接口地址
 *  @param uploadingFile    上传文件路径
 *  @param progressBlock    上传进度
 *	@param successBlock     成功回调
 *	@param failBlock		失败回调
 *
 *  @return 返回的对象中可取消请求
 */
+ (HYURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                          progressBlock:(HYNetWorkingProgress)progressBlock
                           successBlock:(HYResponseSuccessBlock)successBlock
                              failBlock:(HYResponseFailBlock)failBlock;

/**
 *  文件下载接口
 *
 *  @param url           下载文件接口地址
 *  @param saveToPath    存储目录
 *  @param progressBlock 下载进度
 *  @param successBlock  成功回调
 *  @param failBlock     下载回调
 *
 *  @return 返回的对象可取消请求
 */
+ (HYURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                        progressBlock:(HYNetWorkingProgress)progressBlock
                         successBlock:(HYResponseSuccessBlock)successBlock
                            failBlock:(HYResponseFailBlock)failBlock;

@end
