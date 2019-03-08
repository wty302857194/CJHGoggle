//
//  HYStationItemView.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYBaseView.h"

@class HYStation;
@class HYStationItemView;

@protocol HYStationItemViewDelegate <NSObject>

- (void)stationItemViewChange:(HYStationItemView *)view;

@end

@interface HYStationItemView : HYBaseView

@property (nonatomic, weak) id<HYStationItemViewDelegate> delegate;

- (HYStation *)station;

@end
