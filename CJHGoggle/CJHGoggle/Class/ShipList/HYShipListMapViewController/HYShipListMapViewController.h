//
//  HYShipListMapViewController.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2017/9/25.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseViewController.h"

@class HYShipInfo;
@interface HYShipListMapViewController : HYBaseViewController

// 船舶列表
@property (nonatomic, strong) NSArray<HYShipInfo *> *array;

@end
