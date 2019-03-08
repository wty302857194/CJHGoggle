//
//  HYTrailStartPointAnnotion
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@class HYShipInfo;

@interface HYTrailStartPointAnnotion : BMKPointAnnotation

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) HYShipInfo *ship;

@end
