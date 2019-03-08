//
//  HYPassShipInfo.h
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYPassShipInfo : HYBaseModel

@property (nonatomic, copy) NSString *mmsi;

@property (nonatomic, copy) NSString *shipname;

@property (nonatomic, assign) double course;

@property (nonatomic, copy) NSString *chname;

// 途径时间
@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger cjhState;


@end
