//
//  HYLocationManager.m
//  Direction
//
//  Created by 耿建峰 on 17/01/18.
//  Copyright © 2016年 99bill. All rights reserved.
//

#import "HYLocationManager.h"

@interface HYLocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) HYLocationSuccessBlock block;

@end

@implementation HYLocationManager
@synthesize locationManager;

+ (instancetype)shareInstance {
    
    static HYLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[HYLocationManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        locationManager = [[CLLocationManager alloc] init];
        
        _currentLocation = nil;
    }
    
    return self;
}


//更新位置
- (void)startUpdates {
    
    if(locationManager) {
        
        [locationManager stopUpdatingLocation];
        [locationManager stopMonitoringSignificantLocationChanges];
        
        locationManager.delegate = self;
        locationManager.distanceFilter = 10.0f;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if(DP_ISIOS8) {
            //使用期间
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
        [locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)startUpdatesWithBlock:(HYLocationSuccessBlock)block {
    
    self.block = block;
    
    [self startUpdates];
}

// 停止更新
- (void)stopUpdates {
    
    _currentLocation = nil;
    
    self.block = nil;
    
    if(locationManager) {
        
        [locationManager stopUpdatingLocation];
        [locationManager stopMonitoringSignificantLocationChanges];
    }
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    if(newLocation && newLocation.horizontalAccuracy > 0) {
        
        _currentLocation = newLocation;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationSuccessed:)]) {
            
            [self.delegate locationSuccessed:newLocation.coordinate];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if(locations && [locations count] > 0) {
        
        CLLocation *newLocation = [locations lastObject];
        
        // 定位有效
        if(newLocation.horizontalAccuracy > 0) {
            
            _currentLocation = newLocation;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationSuccessed:)]) {
                
                [self.delegate locationSuccessed:newLocation.coordinate];
            }
            
            if(self.block) {
                
                self.block(newLocation.coordinate);
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    [self stopUpdates];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(locationFailed:)]) {
        
        [self.delegate locationFailed:error];
    }
    if(self.block) {
        
        self.block(kCLLocationCoordinate2DInvalid);
    }
}

@end
