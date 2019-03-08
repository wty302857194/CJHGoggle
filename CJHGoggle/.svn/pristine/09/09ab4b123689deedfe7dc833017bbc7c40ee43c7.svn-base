//
//  ZJCustomNoTableView.h
//  zjcharity
//
//  Created by 阿杰 on 2017/11/21.
//  Copyright © 2017年 善纳得. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCustomNoTableView : UIView


/**
 初始化跑马灯

 @param DataArray 数据数组
 @param timeArray 时间数组
 @param timeInterval 动画停留时间
 @param frame 为止
 @return 对象
 */
+(instancetype)noTableViewWithTitle:(NSArray *)DataArray timeArray:(NSArray *)timeArray timeInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame;

/**
 定时器
 */
@property (nonatomic,strong) NSTimer *noTableViewTimer;

@property (nonatomic,strong) NSArray *dataArray;//数据数组

@property (nonatomic,strong) NSArray *timeArray;//时间数组

@property (nonatomic,strong) UITableView *noTableView;

@end
