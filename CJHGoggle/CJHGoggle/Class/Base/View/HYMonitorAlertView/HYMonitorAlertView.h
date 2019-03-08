//
//  HYMonitorAlertView
//  
//
//  Created by 耿建峰 on 2017/10/15.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYMonitorAlertView;
@protocol HYMonitorAlertViewDelegate <NSObject>

- (void)monitorAlertView:(HYMonitorAlertView *)view title:(NSString *)title refmin:(NSInteger)refmin isCJH:(BOOL)isCJH;

@end

@interface HYMonitorAlertView : UIView

@property (nonatomic, weak) id<HYMonitorAlertViewDelegate> delegate;

@end
