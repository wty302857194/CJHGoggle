 //
//  HYRemindModel.h
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/9.
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

/**
 
 
 {
 "create_time" = "<null>";
 id = 298;
 remark = "\U7535\U5b50\U56f4\U680f\U63d0\U9192";
 settingId = 7;
 status = 1;
 "update_time" = "<null>";
 userId = 2;
 }
 */
@interface HYRemindModel : HYBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *settingId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *userId;

@end
