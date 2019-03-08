//
//  HYCustomOverlayView.m
//
#import <Foundation/Foundation.h>
#import "HYCustomOverlayView.h"

@implementation HYCustomOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (HYCustomOverlay *)customOverlay
{
    return (HYCustomOverlay*)self.overlay;
}
- (id)initWithCustomOverlay:(HYCustomOverlay *)customOverlay;
{
    self = [super initWithOverlay:customOverlay];
    if (self)
    {
        
    }
    
    return self;
}

- (void)glRender {
    
    //自定义overlay绘制
    HYCustomOverlay *customOverlay = [self customOverlay];
    
    // 小于三个点不需要绘制
    if (customOverlay.pointCount >= 3) {
     
        self->keepScale = NO;
        
        [self renderLinesWithPoints:customOverlay.points pointCount:customOverlay.pointCount strokeColor:self.strokeColor lineWidth:self.lineWidth looped:YES lineDash:YES];
        [self renderRegionWithPoints:customOverlay.points pointCount:customOverlay.pointCount fillColor:self.fillColor usingTriangleFan:YES];
    }
}

@end
