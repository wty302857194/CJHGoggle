//
//  DPMonitorAlertView
//  
//
//  Created by 耿建峰 on 2017/10/15.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPMonitorAlertView;
@protocol DPMonitorAlertViewDelegate <NSObject>

- (void)monitorAlertView:(DPMonitorAlertView *)view title:(NSString *)title isCJH:(BOOL)isCJH;

@end

@interface DPMonitorAlertView : UIView

@property (nonatomic, weak) id<DPMonitorAlertViewDelegate> delegate;

@end
