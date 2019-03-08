//
//  HYNotificationList.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYBaseModel.h"

@class HYNotification;
@interface HYNotificationList : HYBaseModel

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<HYNotification *> *data;

@end
