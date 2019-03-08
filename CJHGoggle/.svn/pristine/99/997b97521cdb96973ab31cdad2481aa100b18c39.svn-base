//
//  HYFoundationCommon.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYFoundationCommon.h"

static NSString *DPNavigationBarImageName = @"common_navigationbar";

#define HEX_COLOR_NAVGATION_TITLE 0x383838

@implementation HYFoundationCommon

+ (void)setNaviBarBG:(UINavigationBar *)navigationBar withShadow:(BOOL)bShadow {
    
    UIImage *image_navigationBar = [UIImage imageNamed:DPNavigationBarImageName];
    
    [self setNavigationBackground:navigationBar withImage:image_navigationBar withShadow:bShadow];
    
}

+ (void)setNavigationBackground:(UINavigationBar *)navigationBar withImage:(UIImage *)image  withShadow:(BOOL)bShadow {
    
    UIImage *image_navigationBar = image;
    if(!image_navigationBar) {
        
        image_navigationBar = [UIImage imageNamed:DPNavigationBarImageName];
    }
    if ([navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        [navigationBar setBackgroundImage:[image_navigationBar stretchableImageWithLeftCapWidth:30 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
    }
    
    // 设置导航栏字体样式
    [self setNavigationTitle:navigationBar withColor:DP_HexRGB(HEX_COLOR_NAVGATION_TITLE) withShadow:bShadow];
    
    if(bShadow) {
        
        navigationBar.layer.masksToBounds = NO;
        navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
        navigationBar.layer.shadowOpacity = 0.0;
        navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:navigationBar.bounds].CGPath;
    }
    else {
        
        navigationBar.layer.masksToBounds = NO;
        navigationBar.layer.shadowOffset = CGSizeMake(0, 0);
        navigationBar.layer.shadowOpacity = 0.0;
        navigationBar.layer.shadowPath = nil;
        [navigationBar setShadowImage:[UIImage new]];
    }
    
}

+ (void)setNavigationTitle:(UINavigationBar *)navigationBar withColor:(UIColor *)color withShadow:(BOOL)bShadow {
    
    // 设置导航栏字体
    
    UIColor *titleColor = color ? color : DP_HexRGB(HEX_COLOR_NAVGATION_TITLE);
    
    // 320,375,414
    CGFloat screenSize = SCREEN_MIN_LENGTH;
    
    CGFloat titleSize = (screenSize > 320) ? DPRealValue47(17) : DPRealValue(17);
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont systemFontOfSize:titleSize], NSFontAttributeName,
                                titleColor, NSForegroundColorAttributeName,
                                nil];
    
    if(bShadow) {
        
        NSShadow *shadow = [NSShadow new];
        [shadow setShadowColor : [UIColor blackColor]];
        [shadow setShadowOffset : CGSizeMake(0.0f, 0.0f)];
        
        attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                      [UIFont systemFontOfSize:titleSize], NSFontAttributeName,
                      titleColor, NSForegroundColorAttributeName,
                      shadow, NSShadowAttributeName,
                      nil];
    }
    
    [navigationBar setTitleTextAttributes:attributes];
}

+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withImage:(UIImage *)image withRect:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target
               action:select
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return [self barButtonItemsWithItem:backBarButtonItem];
}

+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withTitle:(NSString *)title withRect:(CGRect)frame {
    
    return [self barButtonItemWithTarget:target select:select withTitle:title withNormalColor:[UIColor darkGrayColor] withHighlightedColor:[UIColor darkGrayColor] withRect:frame];
}

+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withTitle:(NSString *)title withNormalColor:(UIColor *)normalColor withHighlightedColor:(UIColor *)highlightedColor withRect:(CGRect)frame {
    
    if ( !normalColor ) normalColor = [UIColor whiteColor];
    
    if ( !highlightedColor ) highlightedColor = [UIColor darkGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:DPRealValue(11)];
    [button addTarget:target
               action:select
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [self barButtonItemsWithItem:backBarButtonItem];
}

+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withView:(UIView *)view {

    if(!view) return nil;
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    backBarButtonItem.action = select;
    backBarButtonItem.target = target;
    return [self barButtonItemsWithItem:backBarButtonItem];
}

+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withControl:(UIControl *)control {
    
    if(!control) return nil;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = control.frame;
    
    [button addSubview:control];
    
    [control addTarget:target
                action:select
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return [self barButtonItemsWithItem:backBarButtonItem];
}

+ (NSArray *)barButtonItemsWithItem:(UIBarButtonItem *)barButtomItem {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    NSArray *barItems = @[negativeSpacer, barButtomItem];
    
    return barItems;
}

+ (void)promotDialog:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle cancelHandler:(void (^)())cancelHandler commitHandler:(void (^)())commitHandler {
    
    if(!title && !message) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        if(cancelTitle) {
            [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler]];
        }
        
        if(commitTitle) {
            [alertController addAction:[UIAlertAction actionWithTitle:commitTitle style:UIAlertActionStyleDefault handler:commitHandler]];
        }
        
        [HYSharedAppDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

/**
 *  弹出dialog提示信息
 *
 *  @param message 提示框的内容
 */
+ (void)promotDialogWithTitle:(NSString *)title message:(NSString *)message {
    
    [self promotDialog:title message:message cancelTitle:@"我知道了" commitTitle:nil cancelHandler:nil commitHandler:nil];
}

+ (void)promotToast:(NSString *)message {
    
    if(!message) return;
    
//    [HYSharedAppDelegate.window makeToast:message duration:1 position:[CSToastManager defaultPosition]];
}

@end
