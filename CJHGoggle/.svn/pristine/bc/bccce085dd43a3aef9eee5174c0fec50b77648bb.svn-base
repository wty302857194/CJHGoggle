//
//  GeneralMacrol.h
//  CJHLogistics
//
//  Created by user_lzz on 2017/11/6.
//  Copyright © 2017年 cjh. All rights reserved.
//
//  全局的宏

#ifndef GeneralMacrol_h
#define GeneralMacrol_h

// 系统版本宏
#define IOS11_OR_LATER    @available(iOS 11.0, *)
#define ProjectAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


// 判断设备类型
#define iPhone4_Vertical ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iPhoneX      ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)

// 一些系统单例的简写
#define USER_DEFAULTS       [NSUserDefaults standardUserDefaults]
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]
#define Window_             [[UIApplication sharedApplication].delegate window]

// 设备尺寸
#define kScreenWidth   [[UIScreen mainScreen]bounds].size.width  //屏宽
#define kScreenHeight  [[UIScreen mainScreen]bounds].size.height //屏高

#define kSafeAreaMaiginTop         (iPhoneX?44:0)
#define kSafeAreaMaiginBottom      (iPhoneX?34:0)
#define kStatusBarHeight           (iPhoneX?44:20)    // 状态栏高度
#define kNavigationBarHeight       44     // NavBar高度
#define kTabBarHeight              (iPhoneX?83:49)

// 状态栏＋导航栏高度(兼容iPhoneX)
#define kLayoutViewMarginTop  ((kStatusBarHeight) + (kNavigationBarHeight))
#define kTableBarHeight            (iPhoneX?83:49)  // 底部tablebar的高度


#define GO_BACK    UIButton *barBtnItem = [UIButton buttonWithType:UIButtonTypeCustom];[barBtnItem setImage:[UIImage imageNamed:@"nav_default_back"] forState:UIControlStateNormal];[barBtnItem addTarget:self action:@selector(goBackNV) forControlEvents:UIControlEventTouchUpInside];barBtnItem.frame = CGRectMake(0, 0, 44, 44);barBtnItem.imageEdgeInsets = UIEdgeInsetsMake(7, -24, 7, 5);UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc] initWithCustomView:barBtnItem];self.navigationItem.leftBarButtonItem=barButtonItem

#endif /* GeneralMacrol_h */
