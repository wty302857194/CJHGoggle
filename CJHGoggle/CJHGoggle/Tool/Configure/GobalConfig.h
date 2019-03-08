//
//  GobalConfig.h
//  CJHLogistics
//
//  Created by user_lzz on 2017/11/6.
//  Copyright © 2017年 cjh. All rights reserved.
//
// 系统全局配置
//

#ifndef GobalConfig_h
#define GobalConfig_h

// 自定义打印
#ifdef DEBUG
    #define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
    #define DDLog(...)
#endif



// 网络环境配置
#define debugEnable YES    // YES 开发；NO 现网
#define TestersEnable YES  // YES 测试员用测试环境224；NO 开发人员用开发环境222

// 线上
#define HY_HTTP_URL @"http://106.14.150.228:8080/monitor"
//#define HY_HTTP_URL @"http://192.168.1.210:8080"

#define TEST_HTTP_URL (TestersEnable ? @"http://192.168.1.36:8080" : @"http://192.168.1.210:8080")
// HTTP请求的baseUrl
#define HTTP_SERVER (debugEnable ? TEST_HTTP_URL : @"http://106.14.150.228:8080/monitor")



#pragma mark -- 个推SDK -------
#define kBindAliasSequenceNum   @"seq-1"
#define kGTAppId           (debugEnable ? @"nczYKX9aSZ54lutitpoMF3" : @"nczYKX9aSZ54lutitpoMF3")
#define kGTAppKey          (debugEnable ? @"djh8mdkaOk5Ai8ega80Qc2" : @"djh8mdkaOk5Ai8ega80Qc2")
#define kGTAppSecret       (debugEnable ? @"jiKzDGIPpv5jqt2cBlPMY2" : @"jiKzDGIPpv5jqt2cBlPMY2")





#endif /* GobalConfig_h */
