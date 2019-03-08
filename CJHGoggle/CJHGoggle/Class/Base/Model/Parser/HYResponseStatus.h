//
//  HYResponseStatus.h
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseModel.h"

// 成功
static NSString *HYResponse_Success = @"0";

// 验证失败
static NSString *HYResponse_VerifyFailed = @"300";
// 请求参数出错
static NSString *HYResponse_ParamsError = @"400";
// 找不到
static NSString *HYResponse_NotFound = @"404";
// 服务器错误
static NSString *HYResponse_ServerError = @"500";

// token过期
static NSString *HYResponse_TokenExpired = @"9000";

// 网络请求超时
static NSString *HYResponse_TimeOut = @"-3";

// 验证签名错误
static NSString *HYResponse_Verify = @"-4";

@interface HYResponseStatus : HYBaseModel

// 响应吗(00:成功 其他失败)
@property (nonatomic, copy) NSString *code;

// 响应消息
@property (nonatomic, copy) NSString *msg;

// 网络异常
+ (instancetype)networkError;

// 数据解析异常
+ (instancetype)parserError;

// 请求超时异常
+ (instancetype)timeoutError;

// 验签异常
+ (instancetype)verifySignError;

// 初始化错误信息
- (instancetype)initWith:(NSString *)code responseMsg:(NSString *)msg;

// 响应状态是否为成功
- (BOOL)stateIsSuccess;

// token是否已过期
- (BOOL)stateIsTokenExpired;

// 转换成NSError对象
- (NSError *)toError;

@end
