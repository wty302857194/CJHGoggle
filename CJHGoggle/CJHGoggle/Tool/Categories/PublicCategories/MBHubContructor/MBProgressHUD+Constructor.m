//
//  MBProgressHUD+Constructor.m
//  CJHLogistics
//
//  Created by user_lzz on 2017/11/9.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "MBProgressHUD+Constructor.h"

@implementation MBProgressHUD (Constructor)

+ (instancetype)showHubViewAddedOnTopView:(UIView *)topView animated:(BOOL)animated
{
    MBProgressHUD *hud;
    if (topView == nil) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:topView animated:YES];
    }
    hud.graceTime = 0.5;
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.alpha = 0.8;
    return hud;
}


+ (instancetype)commonPropertyShowInView:(UIView *)view
{
    MBProgressHUD *hud;
    if (view == nil) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:1];
    hud.contentColor = [UIColor colorWithWhite:0.f alpha:1];
    hud.mode = MBProgressHUDModeText;
    
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:14];
    
    hud.margin = 10.f;
    return hud;
}

+ (void)promptMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD commonPropertyShowInView:view];
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:1];
}

+ (void)promptMessageYoffset:(CGFloat)yyOffset withMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD commonPropertyShowInView:view];
    hud.label.text = message;
    CGPoint point = hud.offset;
    point.y = yyOffset;
    hud.offset = point;
    [hud hideAnimated:YES afterDelay:1];
}

+ (void)promptDetailMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD commonPropertyShowInView:view];
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    [hud hideAnimated:YES afterDelay:1.3];
}

@end
