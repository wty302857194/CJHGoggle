//
//  HYTrailEndPointAnnotion
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@class HYShipInfo;

@interface HYTrailEndPointAnnotion : BMKPointAnnotation

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) HYShipInfo *ship;

@end
