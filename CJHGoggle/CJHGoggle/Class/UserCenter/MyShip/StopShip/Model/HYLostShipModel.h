//
//  HYLostShipModel.h
//  CJHGoggle
//
//  Created by 耿建峰 on 2018/8/15.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYBaseModel.h"
/*
 {
 "id": 119,
 "uid": null,
 "mmsi": "413812674",
 "shipName": null,
 "createTime": "2018-08-08 18:46:20",
 "updateTime": "2018-08-09 03:05:44",
 "siteName": null,
 "lostDate": null,
 "otherName": null,
 "cjhState": 1
 }
 */
@interface HYLostShipModel : HYBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mmsi;
@property (nonatomic, copy) NSString *shipName;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;

// 最近一次靠泊长江汇的站点名称
@property (nonatomic, copy) NSString *siteName;
// 靠泊时间
@property (nonatomic, copy) NSString *moorDate;
// 流失区域名称
@property (nonatomic, copy) NSString *otherName;
// 流失时间
@property (nonatomic, copy) NSString *lostDate;
// 船舶在长江汇的状态
@property (nonatomic, copy) NSString *cjhState;

@end
