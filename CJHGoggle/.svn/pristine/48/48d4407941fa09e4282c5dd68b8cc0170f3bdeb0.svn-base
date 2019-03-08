//
//  HYLocationManager.h
//  Direction
//
//  Created by 耿建峰 on 17/01/18.
//  Copyright © 2016年 99bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// 成功回调
typedef void(^HYLocationSuccessBlock)(CLLocationCoordinate2D coordinate);

@protocol HYLocationManagerDelegate <NSObject>

@optional

- (void)locationSuccessed:(CLLocationCoordinate2D)coordinate;

- (void)locationFailed:(NSError *)error;

@end

@interface HYLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id<HYLocationManagerDelegate> delegate;

// 当前位置
@property (nonatomic, readonly) CLLocation *currentLocation;

+ (instancetype)shareInstance;

- (void)startUpdates;

- (void)startUpdatesWith:(id<HYLocationManagerDelegate>)delegate;

- (void)startUpdatesWithBlock:(HYLocationSuccessBlock)block;

- (void)stopUpdates;

- (NSString *)currentCity;

@end
