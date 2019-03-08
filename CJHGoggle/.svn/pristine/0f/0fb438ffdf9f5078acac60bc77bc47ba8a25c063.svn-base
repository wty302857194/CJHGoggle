//
//  HYResponseStatus.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYResponseStatus.h"

@implementation HYResponseStatus

+ (instancetype)networkError {
    
    HYResponseStatus *state = [[HYResponseStatus alloc] init];
    state.msg = @"网络异常，请稍候再试！";
    state.code = @"-1";
    return state;
}

+ (instancetype)parserError {
    
    HYResponseStatus *state = [[HYResponseStatus alloc] init];
    state.msg = @"数据解析异常！";
    state.code = @"-2";
    return state;
}

+ (instancetype)timeoutError {
    
    HYResponseStatus *state = [[HYResponseStatus alloc] init];
    state.msg = @"网络请求超时！";
    state.code = @"-3";
    return state;
}

// 验签异常
+ (instancetype)verifySignError {
    
    HYResponseStatus *state = [[HYResponseStatus alloc] init];
    state.msg = @"验证签名错误！";
    state.code = HYResponse_Verify;
    return state;
}

- (instancetype)initWith:(NSString *)code responseMsg:(NSString *)msg {
    
    if(self = [super init]) {
        
        self.code = code;
        self.msg = msg;
    }
    
    return self;
}

- (BOOL)stateIsSuccess {
    
    BOOL bRe = NO;
    
    if(self.code && [self.code isEqualToString:HYResponse_Success]) {
        bRe = YES;
    }
    
    return bRe;
}

- (BOOL)stateIsTokenExpired {
    
    BOOL bRe = NO;
    
    if(self.code && [self.code isEqualToString:HYResponse_TokenExpired]) {
        bRe = YES;
    }
    
    return bRe;
}

- (NSError *)toError {
    
    NSError *error = [NSError errorWithDomain:HYNONNil(self.msg) code:[HYNONNil(self.code) integerValue] userInfo:@{@"code" : HYNONNil(self.code), @"msg" : HYNONNil(self.msg)}];
    
    return error;
}

@end
