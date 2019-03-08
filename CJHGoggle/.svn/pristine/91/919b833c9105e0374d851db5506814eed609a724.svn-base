//
//  HYShipDetailInfo.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYBaseModel.h"

@class HYShipInfo;
@class HYUserLabel;

@interface HYShipMemberRecord : HYBaseModel

// 用户名
@property (nonatomic, copy) NSString *user_name;
// 销售日期
@property (nonatomic, copy) NSString *reg_phone;
// 类型
@property (nonatomic, copy) NSString *type;
// 状态
@property (nonatomic, copy) NSString *state;

@end

@interface HYShipOilRecord : HYBaseModel

// 站点名称
@property (nonatomic, copy) NSString *site_name;
// 销售日期
@property (nonatomic, copy) NSString *sale_date;
// 销售吨数
@property (nonatomic, copy) NSString *oilqty;

@end

@interface HYShipNoOilRecord : HYBaseModel

// 站点名称
@property (nonatomic, copy) NSString *site_name;
// 销售日期
@property (nonatomic, copy) NSString *sale_date;
// 销售吨数
@property (nonatomic, copy) NSString *total;

@end

@interface HYShipDetailInfo : HYBaseModel

@property (nonatomic, strong) HYShipInfo *shipBaseInfo;

@property (nonatomic, copy) NSString *shipid;

// 距离
@property (nonatomic, copy) NSString *distance;
// 靠泊信息
@property (nonatomic, copy) NSString *moortime;
// 是否星标客户
@property (nonatomic, assign) BOOL isstar;
// 是否是我的船舶
@property (nonatomic, assign) BOOL ismyship;
// 大V姓名及手机号
@property (nonatomic, copy) NSString *nameandphone;

// 船舶的标签
@property (nonatomic, strong) NSArray<HYUserLabel *> *labelList;

// 成员列表
@property (nonatomic, strong) NSArray<HYShipMemberRecord *> *memberList;
// 油品消费列表
@property (nonatomic, strong) NSArray<HYShipOilRecord *> *oilRecordList;
// 非油消费列表
@property (nonatomic, strong) NSArray<HYShipNoOilRecord *> *nonOilRecords;

@end
