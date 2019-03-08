//
//  HYTrailPointAnnotion
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@class HYShipInfo;

@interface HYTrailPointAnnotion : BMKPointAnnotation

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) HYShipInfo *ship;

@end
