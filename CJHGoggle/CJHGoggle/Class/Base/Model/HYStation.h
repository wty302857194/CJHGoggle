//
//  HYStation.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYStation : HYBaseModel

// 区域名称
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) double longitude;

@property (nonatomic, assign) double latitude;

@end
