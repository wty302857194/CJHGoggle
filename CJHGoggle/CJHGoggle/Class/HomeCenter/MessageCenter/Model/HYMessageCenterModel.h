 //
//  HYMessageCenterModel.h
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/13.
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
/*
 {
 "id": 1108,
 "cid": 11,
 "type": 7,
 "userId": 8,
 "title": "电子围栏提醒",
 "message": "华通油889于2018-08-06 11:53:17已上水进入长江大桥范围内，请及时联系",
 "state": 1,
 "mmsi": "413965653",
 "longitude": "118.74683980964952",
 "latitude": "32.12141983577868",
 "createDate": 1533527766000,
 "updateTime": 1533527767000
 }
 */
@interface HYMessageCenterModel : HYBaseModel
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *mmsi;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *userId;
@end
