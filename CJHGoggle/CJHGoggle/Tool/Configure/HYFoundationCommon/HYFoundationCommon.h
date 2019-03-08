//
//  HYFoundationCommon.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYFoundationCommon : NSObject

/**
 *  设置导航栏背景
 *
 *  @param navigationBar 导航条
 *  @param bShadow       导航栏底部是否需要阴影
 */
+ (void)setNaviBarBG:(UINavigationBar *)navigationBar withShadow:(BOOL)bShadow;

/**
 *  设置导航栏背景
 *
 *  @param navigationBar 导航条
 *  @param image         所用导航栏的背景图
 *  @param bShadow       导航栏底部是否需要阴影
 */
+ (void)setNavigationBackground:(UINavigationBar *)navigationBar withImage:(UIImage *)image  withShadow:(BOOL)bShadow;

/**
 *  设置导航栏背景
 *
 *  @param navigationBar 导航条
 *  @param color         导航栏字体颜色
 *  @param bShadow       导航栏底部是否需要阴影
 */
+ (void)setNavigationTitle:(UINavigationBar *)navigationBar withColor:(UIColor *)color withShadow:(BOOL)bShadow;

/**
 *  自定义导航栏BarButtonItem
 *
 *  @param target 响应对象
 *  @param select 点击响应事件
 *  @param image  显示图片
 *  @param frame 点击区域
 *
 */
+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withImage:(UIImage *)image withRect:(CGRect)frame;

/**
 *  自定义导航栏BarButtonItem
 *
 *  @param target 响应对象
 *  @param select 点击响应事件
 *  @param title  标题
 *  @param frame  点击区域
 *
 */
+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withTitle:(NSString *)title withRect:(CGRect)frame;

/**
 *  自定义导航栏BarButtonItem
 *
 *  @param target 响应对象
 *  @param select 点击响应事件
 *  @param title  标题
 *  @normalColor  字体正常状态颜色
 *  @highlightedColor  字体高亮状态颜色
 *  @param frame  点击区域
 *
 */
+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withTitle:(NSString *)title withNormalColor:(UIColor *)normalColor withHighlightedColor:(UIColor *)highlightedColor withRect:(CGRect)frame;

/**
 *  自定义导航栏BarButtonItem
 *
 *  @param target 响应对象
 *  @param select 点击响应事件
 *  @param view  自定义视图
 *
 */
+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withView:(UIView *)view;

/**
 *  自定义导航栏BarButtonItem
 *
 *  @param target 响应对象
 *  @param select 点击响应事件
 *  @param control  自定义视图
 *
 */
+ (NSArray *)barButtonItemWithTarget:(id)target select:(SEL)select withControl:(UIControl *)control;

/**
 *  修复iOS7下leftBarButtonItem位置相比之前版本靠右的问题
 *
 *
 */
+ (NSArray *)barButtonItemsWithItem:(UIBarButtonItem *)barButtomItem;

/**
 *  弹出dialog提示信息
 *
 *  @param message 提示框的内容
 */
+ (void)promotDialogWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  弹出dialog对话框
 *
 *  @param title         标题
 *  @param message       提示内容
 *  @param cancelTitle   取消按钮名称
 *  @param commitTitle   确认按钮名称
 *  @param cancelHandler 点击取消按钮响应事件
 *  @param commitHandler 点击确定按钮响应事件
 */
+ (void)promotDialog:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle cancelHandler:(void (^)())cancelHandler commitHandler:(void (^)())commitHandler;


+ (void)promotToast:(NSString *)message;

@end
