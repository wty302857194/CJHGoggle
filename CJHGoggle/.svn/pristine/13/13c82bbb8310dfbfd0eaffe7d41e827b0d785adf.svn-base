//
//  HYManager.h
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYUser;

@interface HYManager : NSObject

+ (instancetype)sharedManager;

// 获取当前设备编号
- (NSString *)getDeviceId;

// 登录后更新当前用户信息
- (void)updateCurrentUser:(HYUser *)user;

// 获取当前用户信息
- (HYUser *)currentUser;

// 退出登录
- (void)logout;

//是否登录
- (BOOL)isLogIn;

@end
