//
//  HYMoorShipInfo.h
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYMoorShipInfo : HYBaseModel

@property (nonatomic, copy) NSString *mmsi;

@property (nonatomic, assign) double longitude;

@property (nonatomic, assign) double latitude;

@property (nonatomic, copy) NSString *moorstarttime;

@property (nonatomic, copy) NSString *moorendtime;

@property (nonatomic, assign) NSInteger cjhState;

@property (nonatomic, assign) double course;

@property (nonatomic, copy) NSString *shipname;

@end
