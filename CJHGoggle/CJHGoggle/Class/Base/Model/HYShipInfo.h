//
//  HYShipInfo.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYShipInfo : HYBaseModel

// 九位码
@property (nonatomic, copy) NSString *mmsi;
// ais更新时间戳
@property (nonatomic, copy) NSString *utc;
// 经度
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
// 方向
@property (nonatomic, assign) double course;
// 船艏
@property (nonatomic, assign) double trueheading;
// 船速
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *vdesc;
@property (nonatomic, copy) NSString *imo;
@property (nonatomic, copy) NSString *callSign;
// 英文名
@property (nonatomic, copy) NSString *shipName;
// 船舶中文名
@property (nonatomic, copy) NSString *chName;
// 目的地
@property (nonatomic, copy) NSString *dest;

@property (nonatomic, copy) NSString *eta;

// 货物类型
@property (nonatomic, assign) NSInteger cargoType;
// 船长度
@property (nonatomic, assign) NSInteger length;
// 船宽度
@property (nonatomic, assign) NSInteger width;
// 吃水
@property (nonatomic, assign) NSInteger draft;

@property (nonatomic, assign) NSInteger posFix;

@property (nonatomic, assign) NSInteger classType;
@property (nonatomic, assign) NSInteger exceed2hour;

// 长江汇状态：0：陌生船舶，1：长江汇池中船，有号码，但尚不是客户，2：长江汇大V，3：24h内有靠泊的
@property (nonatomic, assign) NSInteger cjhState;

@property (nonatomic, copy) NSString *id;

// 是否是大V
- (BOOL)isV;
// 是否在我们电销维护的池子中
- (BOOL)isP;
// 今天是否靠泊过长江汇
- (BOOL)hasMoorCJH;

@end
