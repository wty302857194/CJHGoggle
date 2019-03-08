//
//  HYCustomOverlay.h
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface HYCustomOverlay : BMKShape<BMKOverlay> {
    
    @package
    BMKMapPoint *_points;
    int _pointCount;
    BMKMapRect _boundingMapRect;
}
@property (nonatomic, readonly) BMKMapRect boundingMapRect;
@property (nonatomic, readonly) BMKMapPoint* points;
@property (nonatomic, readonly) int pointCount;
-(id)initWithPoints:(BMKMapPoint *)points count:(NSUInteger)count;

+ (HYCustomOverlay *)customWithPoints:(BMKMapPoint *)points count:(NSUInteger)count;

@end
