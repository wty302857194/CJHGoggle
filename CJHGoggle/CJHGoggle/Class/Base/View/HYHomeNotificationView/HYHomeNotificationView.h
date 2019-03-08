//
//  HYHomeNotificationView.h

#import <UIKit/UIKit.h>

#import "HYBaseView.h"

@class HYNotification;

@class HYHomeNotificationView;

@protocol HYHomeNotificationViewDelegate <NSObject>

- (void)homeNotificationView:(HYHomeNotificationView *)view withObj:(HYNotification *)obj;

@end

@interface HYHomeNotificationView : HYBaseView

@property (nonatomic, weak) id<HYHomeNotificationViewDelegate> delegate;

- (instancetype)initWithInterval:(NSTimeInterval)timeInterval;

@end
