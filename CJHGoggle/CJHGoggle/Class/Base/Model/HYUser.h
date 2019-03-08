//
//  HYUser.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYUser : HYBaseModel

@property (nonatomic, copy) NSString *token;
// 用户id
@property (nonatomic, copy) NSString *userid;
// 登录名
@property (nonatomic, copy) NSString *username;
// 真实姓名
@property (nonatomic, copy) NSString *realname;
// 部门id
@property (nonatomic, copy) NSString *departmentid;
//部门名称
@property (nonatomic, copy) NSString *departmentname;
// 角色id
@property (nonatomic, copy) NSString *role_id;

// 添加监控区域权限
@property (nonatomic, assign) BOOL add_monitor;
// 删除监控区域权限
@property (nonatomic, assign) BOOL delete_monitor;
// 我的区域权限
@property (nonatomic, assign) BOOL my_area;
// 我的船舶权限
@property (nonatomic, assign) BOOL my_ship;
// 发布公告
@property (nonatomic, assign) BOOL publish_notice;
// 我的标签
@property (nonatomic, assign) BOOL my_label;

// 是否拥有添加监控区域权限
- (BOOL)haveAddMonitorRight;
// 是否拥有移除监控区域权限
- (BOOL)haveRemoveMonitorRight;
// 是否拥有查看区域权限
- (BOOL)haveMyAreaRight;
// 是否拥有我的船舶列表权限
- (BOOL)haveMyShipsRight;
// 是否拥有标签权限
- (BOOL)haveMyLabelRight;

@end
