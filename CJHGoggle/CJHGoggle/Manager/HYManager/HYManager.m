//
//  HYManager.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYManager.h"

#import "HYUtil.h"

static NSString *kKeychainService = @"com.cjh.monitor";
static NSString *kKeychainDeviceId    = @"MonitorDeviceId";
static NSString *kHYUserInfo    = @"HYUserInfo";

@interface HYManager ()

@property (nonatomic, strong) HYUser *user;

@property (nonatomic, copy) NSString *device_sn;

@end

@implementation HYManager

+ (instancetype)sharedManager {
    
    static HYManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    
    if(self = [super init]) {
        
    }
    
    return self;
}

- (NSString *)getDeviceId {
    
    if (!self.device_sn) {
        
        // 读取设备号
        NSString *deviceIdLocal = [SSKeychain passwordForService:kKeychainService account:kKeychainDeviceId];
        
        if ([NSString dp_isEmptyString:deviceIdLocal]) {
            
            deviceIdLocal = [[NSUserDefaults standardUserDefaults] objectForKey:kKeychainDeviceId];
            
            if ([NSString dp_isEmptyString:deviceIdLocal]) {
                
                // 本地暂无设备编号，创建一个并写入keychain
                CFUUIDRef deviceIdRef = CFUUIDCreate(NULL);
                
                if (deviceIdRef) {
                    
                    CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceIdRef);
                    
                    deviceIdLocal = [NSString stringWithFormat:@"%@", deviceIdStr];
                    
                    deviceIdLocal = [deviceIdLocal stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    [SSKeychain setPassword:deviceIdLocal forService:kKeychainService account:kKeychainDeviceId];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:deviceIdLocal forKey:kKeychainDeviceId];
                    
                    CFRelease(deviceIdStr);
                    
                    CFRelease(deviceIdRef);
                }
            }
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        self.device_sn = deviceIdLocal;
    }
    
    return self.device_sn;
}

- (void)updateCurrentUser:(HYUser *)user {
    
    self.user = user;
    
    if(user) {
        
        NSData *data = [user mj_JSONData];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kHYUserInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHYUserInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (HYUser *)currentUser {
    
    if (!self.user) {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kHYUserInfo];
        
        if(data) {
            
            self.user = [HYUser mj_objectWithKeyValues:data];
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return self.user;
}

- (void)logout {
    
    [USER_DEFAULTS removeObjectForKey:Registration_ID];
    [USER_DEFAULTS synchronize];
    
    [self updateCurrentUser:nil];
    
    [HYSharedAppDelegate initViewController];
}


- (BOOL)isLogIn {
    return [self currentUser]?YES:NO;
}
@end
