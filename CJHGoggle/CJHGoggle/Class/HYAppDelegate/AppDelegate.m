//
//  AppDelegate.m
//  CJHGoggle
//
//  Created by 阿杰 on 2018/7/31.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "AppDelegate.h"
#import "HYBaseTabBarController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "HYLogInViewController.h"
#import "HYBaseTabBarController.h"

@interface AppDelegate ()<JPUSHRegisterDelegate, BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate

- (void)initViewController {
    
    if ([HYManager sharedManager].currentUser) {
        // 已登录
        [self initHomeViewController];
    }
    else {
        // 尚未登录
        [self initLoginViewController];
    }
    
}

- (void)initHomeViewController {
    
    //查看本地是否存储的有Registration_ID，若没有给通知
    NSString *registration_id = [USER_DEFAULTS objectForKey:Registration_ID];
    if (registration_id&&registration_id.length>0) {
        [self userDeviceRequestData:registration_id?:@""];
    }else {
        //开启通知

        WEAKSELF;
        [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
            
            [weakSelf userDeviceRequestData:registrationID?:@""];
        }];
    }
    // 首页
    [self.window setRootViewController:[[HYBaseTabBarController alloc] init]];
    
    [self.window makeKeyAndVisible];
}

- (void)initLoginViewController {
    // 登录
    HYLogInViewController *viewController = [[HYLogInViewController alloc] initWithNibName:@"HYLogInViewController" bundle:nil];
    
    [self.window setRootViewController:viewController];
    
    [self.window makeKeyAndVisible];
}

#pragma mark - =====写入用户设备id admin/userDevice====
- (void)userDeviceRequestData:(NSString *)registrationID
{
    NSDictionary *dic = @{
                          @"device_id":registrationID
                          };
    [HYHTTPClient asynchronousPostRequest:@"admin/userDevice" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        
    } failureBlock:^(NSString *description) {
    }];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initViewController];
    
    //配置极光推送
    [self registJiGuang:launchOptions];
    
    // 注册百度地图
    [self initBaiduMapSDK];


    return YES;
}

#pragma mark - 配置极光推送
- (void)registJiGuang:(NSDictionary *)launchOptions
{
    /*****************极光推动注册****************/
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 关闭日志
    [JPUSHService setLogOFF];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JGPUSH_AppKey
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    /************************end**************************/
}

#pragma mark - 要使用百度地图，请先启动BaiduMapManager

- (void)initBaiduMapSDK {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    /**
     *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_COMMON]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    
    BOOL ret = [_mapManager start:BDMAP_AppKey generalDelegate:self];
    
    if (!ret) {
        
        NSLog(@"manager start failed!");
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //在这个方法里输入如下清除方法
    [application setApplicationIconBadgeNumber:0]; //清除角标
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//清除APP所有通知消息
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}




- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
