//
//  HYBaseTableViewController.h
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseTableViewController : HYBaseViewController <
UITableViewDelegate,
UITableViewDataSource
>

/**
 *  显示大量数据的控件
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  初始化init的时候设置tableView的样式才有效
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  是否正在数据请求
 */
@property (nonatomic, assign) BOOL isDataLoading;

/**
 *  数据请求的当前分页
 */
@property (nonatomic, assign) NSInteger requestCurrentPage;

/**
 *  数据请求每页展示的数量
 */
@property (nonatomic, assign) NSInteger requestLimitPePage;


/**
 *  去除iOS7新的功能api，tableView的分割线变成iOS6正常的样式
 *  可以解决ios7之后tableview每个cell的分割线左侧短15像素的问题
 */
- (void)configuraTableViewNormalSeparatorInset;

/**
 *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

/**
 *  加载本地或者网络数据源
 */
- (void)loadDataSource;

/**
 *  添加头部下拉刷新控件
 */
- (void)addHeaderPullDownRefreshControl;

/**
 *  添加底部加载更多控件
 */
- (void)addFooterLoadMoreRefreshControl;

/**
 *  移除底部加载更多控件
 */
- (void)removeFooterLoadMoreRefreshControl;

/**
 *  开始下拉刷新
 */
- (void)startPullDownRefreshing;

/**
 *   终止下拉刷新
 */
- (void)endPullDownRefreshing;

/**
 *  终止加载更多
 */
- (void)endLoadMoreRefreshing;

// 更换无数据时展现的UI
- (void)updateNoDataView:(UIView *)nodataView;

- (void)showNoDataView;

- (void)hideNoDataView;

@end
