//
//  HYUtilsMacro.h
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#ifndef HYUtilsMacro_h
#define HYUtilsMacro_h

#define REQUEST_LIMIT 11

#import "AppDelegate.h"

#define HYSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define HYLog(x, ...) NSLog(@"%s-%d:" x, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define HYLog(x...) NSLog(@"", @"")

#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)

#else

#define NSLog(...){}

#endif

#define HYNONNil(str) ([NSString dp_isEmptyString:str] ? @"" : str)

///------
/// block self
///------

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

///------
/// block XX
///------

#define WEAKOBJECT(XX) typeof(XX) __weak weakObject = XX;
#define STRONGOBJECT typeof(weakObject) __strong strongObject = weakObject;

#pragma mark - 系统版本判断
#define DP_ISIOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0
#define DP_ISIOS7 [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0
#define DP_ISIOS11 [[[UIDevice currentDevice] systemVersion] floatValue]>=11.0

//  判断机型
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define HEIGHT_NAVIGATIONBAR 44

#define SCREEN_MAX_LENGTH (MAX(ScreenWidth, ScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(ScreenWidth, ScreenHeight))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

// 不同设备适配不同大小，设计图以320的为准
#define DPRealValue(value) (ceilf(((CGFloat)(value))/320.0f*SCREEN_MIN_LENGTH))
#define DPRealHeightValue(value) ((value)/568.0f*SCREEN_MAX_LENGTH)

// 不同设备适配不同大小，设计图以375的为准,4.7的屏幕
#define DPRealValue47(value) (ceilf(((CGFloat)(value))/375.0f*SCREEN_MIN_LENGTH))
#define DPRealHeightValue47(value) (ceilf(((CGFloat)(value))/667.0f*SCREEN_MAX_LENGTH))

#define DPBarItemRect CGRectMake(0, 0, DPRealValue(30), DPRealValue(30))

// RGB颜色
#define DP_RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define DP_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 十六进制
#define DP_HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DP_HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define HEX_COLOR_BASE_BG         0x121C27
#define HEX_COLOR_BG              0x262C2F
#define HEX_COLOR_BG_GRAY         0xF7F7F7

#define HEX_COLOR_TABBAR_TEXT_NOR 0x8A8A8A
#define HEX_COLOR_TABBAR_TEXT_PRE 0xFFCB02

#define HEX_COLOR_NAVGATION_TITLE 0x383838

// 绿色
#define HEX_COLOR_TEXT_GREEN      0x00bf70
// 橙色
#define HEX_COLOR_TEXT_ORANGE     0xff7122
#define HEX_COLOR_TEXT_ORANGE_DISABLED     0xf4c5ab
// 灰色
#define HEX_COLOR_TEXT_GRAY       0xbdbdbd

#define HEX_COLOR_BUTTON_ABLED    0x21BDED
#define HEX_COLOR_BUTTON_DISABLED 0x8ADBF4


#endif /* DPUtilsMacro_h */
