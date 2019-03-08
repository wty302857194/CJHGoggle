//
//  MBProgressHUD+Constructor.h
//  CJHLogistics
//
//  Created by user_lzz on 2017/11/9.
//  Copyright © 2017年 cjh. All rights reserved.
//

/**
 *  MBProgressHUD 文字提示构造器
 */

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Constructor)

#pragma mark -- 旋转背景属性修改 --
+ (instancetype)showHubViewAddedOnTopView:(UIView *)topView animated:(BOOL)animated;



#pragma mark -- label --
// label:不偏移
+ (void)promptMessage:(NSString *)message inView:(UIView *)view;

// label:上下偏移20
+ (void)promptMessageYoffset:(CGFloat)yyOffset withMessage:(NSString *)message inView:(UIView *)view;

#pragma mark -- detail --
+ (void)promptDetailMessage:(NSString *)message inView:(UIView *)view;



@end
