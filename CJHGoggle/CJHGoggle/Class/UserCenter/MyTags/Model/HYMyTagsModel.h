 //
//  HYMyTagsModel.h
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

@interface HYMyTagsModel : HYBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *userId;
// 数量
@property (nonatomic, copy) NSString *qty;

@end

@interface HYImportantClientModel : HYBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *mmsi;
@property (nonatomic, copy) NSString *shipName;
@property (nonatomic, copy) NSString *userId;
// 船舶在长江汇的状态，1：大V，2：潜在客户
@property (nonatomic, assign) NSInteger cjhState;

@end