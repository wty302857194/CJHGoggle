 //
//  HYShipListModel.h
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/16.
//  Copyright © 2018年 CJH. All rights reserved.
//
/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */

#import "HYBaseModel.h"

@interface HYShipListModel : HYBaseModel<NSCoding>

@property (nonatomic, copy) NSString *dest;
@property (nonatomic, copy) NSString *moortime;
@property (nonatomic, copy) NSString *mmsi;
@property (nonatomic, copy) NSString *utc;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *course;
@property (nonatomic, copy) NSString *trueheading;
@property (nonatomic, copy) NSString *speed;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *vdesc;
@property (nonatomic, copy) NSString *imo;
@property (nonatomic, copy) NSString *callSign;
@property (nonatomic, copy) NSString *shipName;
@property (nonatomic, copy) NSString *sitename;
@property (nonatomic, copy) NSString *cargoType;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *posFix;
@property (nonatomic, copy) NSString *eta;
@property (nonatomic, copy) NSString *draft;
@property (nonatomic, copy) NSString *classType;
@property (nonatomic, copy) NSString *chName;
@property (nonatomic, copy) NSString *exceed2hour;
@property (nonatomic, copy) NSString *cjhState;
@property (nonatomic, copy) NSArray *labelList;

@end

@interface HYLabelListModel : HYBaseModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *labelId;
@property (nonatomic, copy) NSString *shipId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mmsi;

@end
