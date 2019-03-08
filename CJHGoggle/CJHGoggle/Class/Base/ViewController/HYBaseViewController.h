//
//  HYBaseViewController.h
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//
/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */

#import <UIKit/UIKit.h>

@interface HYBaseViewController : UIViewController
/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param titles    标题数组
 @param textColor 字体颜色
 @param isLeft    是否是左边 非左即右
 @param target    目标
 @param action    点击方法
 @param tags tags 数组 回调区分用
 */
- (NSMutableArray *)addNavigationItemWithImageNames:(NSArray *)imageNames titles:(NSArray *)titles textClolr:(UIColor *)textColor isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;
/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的控制器对象
 */
- (void)pushNewViewController:(UIViewController *)newViewController;

/**
 *  返回上一级UIViewController
 *
 *  @param viewControllerClass 所需返回到的viewController
 */
- (void)backToLastViewController:(Class)viewControllerClass;

- (void)dismissViewController;

/**
 *  取消弹起的键盘
 */
- (void)resignKeyBoard;

@end
