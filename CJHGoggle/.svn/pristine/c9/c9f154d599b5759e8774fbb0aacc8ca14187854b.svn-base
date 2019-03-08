//
//  HYBaseTabBarController.m
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

#import "HYBaseTabBarController.h"
#import "HYHomeCenterViewController.h"
#import "HYMessageCenterViewController.h"
#import "HYShipListViewController.h"
#import "HYMyAreaViewController.h"
#import "HYUserCenterViewController.h"
#import "HYBaseNavigationController.h"

@interface HYBaseTabBarController ()

@end

@implementation HYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];

}

#pragma mark - 添加所有的子控制器
- (void)addChildViewControllers
{
    // 首页
    HYHomeCenterViewController *homeVC = [[HYHomeCenterViewController alloc] init];
    [self addOneChildViewController:homeVC title:@"首页" imageName: @"hy_home_normal" selectedImageName:@"hy_home_light"];
    
    if([[HYManager sharedManager] currentUser].my_ship) {
        // 船舶列表
        HYShipListViewController *discoverVC = [[HYShipListViewController alloc] init];
        [self addOneChildViewController:discoverVC title:@"我的船舶" imageName:@"hy_ship_nomal" selectedImageName:@"hy_ship_light"];
    }
    
    if([[HYManager sharedManager] currentUser].my_area) {
        HYMyAreaViewController *myArea = [[HYMyAreaViewController alloc] init];
        [self addOneChildViewController:myArea title:@"我的区域" imageName:@"hy_area_normal" selectedImageName:@"hy_area_light"];
    }
    
    HYUserCenterViewController *myVC = [[HYUserCenterViewController alloc] init];
    [self addOneChildViewController:myVC title:@"我的" imageName:@"hy_mine_normal" selectedImageName:@"hy_mine_light"];
    
}

#pragma mark - 添加单个子控制器
- (void)addOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    vc.tabBarItem.title = title;
//     设置文字正常状态属性
    NSDictionary *textAttrNormal = @{NSForegroundColorAttributeName : [hexColor(323232) colorWithAlphaComponent:0.5]};
    [vc.tabBarItem setTitleTextAttributes: textAttrNormal forState: UIControlStateNormal];
    
    // 设置文字选中状态下属性
    NSDictionary *textAttrSelected = @{NSForegroundColorAttributeName : hexColor(ff4e00)};
    [vc.tabBarItem setTitleTextAttributes: textAttrSelected forState: UIControlStateSelected];
    
    HYBaseNavigationController *nav = [[HYBaseNavigationController alloc] initWithRootViewController:vc];
    // 开启手势返回功能
    nav.interactivePopGestureRecognizer.enabled = YES;
//    [HYFoundationCommon setNavigationBackground:nav.navigationBar withImage:[UIImage dp_imageWithColor:[UIColor whiteColor]] withShadow:YES];
    [self addChildViewController:nav];
    
}


@end
