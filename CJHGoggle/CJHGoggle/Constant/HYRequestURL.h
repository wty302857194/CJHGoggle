//
//  HYRequestURL.h
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//

#ifndef HYRequestURL_h
#define HYRequestURL_h

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    0
#define TestSever       0
#define ProductSever    1

#if DevelopSever

/**开发服务器*/
#define URL_main       @"http://192.168.1.36:8080/"
/** H5 */
#define WEBURL_main    @""
/** 图片 */
#define IMAGE_URL_main @""
/** 视频 */
#define VIDEO_URL_main @""


#elif TestSever

/**测试服务器**/

#define URL_main       @"http://192.168.1.199:8080/monitor/"
#define WEBURL_main    @""

#elif ProductSever

/**生产服务器*/

#define URL_main       @"https://monitor.njcjh.cn/mhs/"
//#define URL_main       @"http://erp.njcjh.cn:9090/mhs/"
/** H5 */
#define WEBURL_main    @""
/** 图片 */
#define IMAGE_URL_main @""
/** 视频 */
#define VIDEO_URL_main @""

#endif


#pragma mark - ——————— 登录 ————————
#define HY_LogIn_API     @"admin/login"

#pragma mark - ——————— 首页 ————————
//首页
#define goodDeeds_virtueDeed_API     URL_main@"/api/deed/getVirtueDeed"

#pragma mark - ——————— 搜索 ————————
//搜索项目
#define goodDeeds_search_hot_API     URL_main@"/api/2.1/Item/searchHotItem"




#endif /* HYRequestURL_h */
