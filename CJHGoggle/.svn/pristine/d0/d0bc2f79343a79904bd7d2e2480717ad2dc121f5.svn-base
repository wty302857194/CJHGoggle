//
//  HYPublicClass.m
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYPublicClass.h"
#import <MJRefresh/MJRefresh.h>

@implementation HYPublicClass

+ (void)refreshWithHeader:(UITableView *)tableView
          refreshingBlock:(void (^)(void))headerWithRefreshingBlock
{
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        headerWithRefreshingBlock();
        
    }];
    
    tableView.mj_header.automaticallyChangeAlpha = YES;
    // 设置文字
    [header setTitle:@"轻轻下拉，刷新精彩..." forState:MJRefreshStateIdle];
    [header setTitle:@"该放手了，我要刷新啦..." forState:MJRefreshStatePulling];
    [header setTitle:@"努力加载中..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    
    // 设置颜色
//    header.stateLabel.textColor = color_title_gray;
//    header.lastUpdatedTimeLabel.textColor = color_title_gray;
    
    // 设置刷新控件
    tableView.mj_header = header;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
}

+(void)refreshWithFooter:(UITableView *)tableView refreshingBlock:(void (^)(void))footerWithRefreshingBlock
{
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        footerWithRefreshingBlock();
        
    }];
    
    // 设置文字
    [footer setTitle:@"上拉即可加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"释放即可更新..." forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置颜色
//    footer.stateLabel.textColor = color_title_gray;
    
    // 设置footer
    tableView.mj_footer = footer;
    
}

#pragma mark - UICollectionView刷新

+ (void)refreshCollectionWithHeader:(UICollectionView *)collection
                    refreshingBlock:(void (^)(void))headerWithRefreshingBlock
{
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        headerWithRefreshingBlock();
        
    }];
    
    collection.mj_header.automaticallyChangeAlpha = YES;
    // 设置文字
    [header setTitle:@"轻轻下拉，刷新精彩..." forState:MJRefreshStateIdle];
    [header setTitle:@"该放手了，我要刷新啦..." forState:MJRefreshStatePulling];
    [header setTitle:@"努力加载中..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    
    // 设置颜色
//    header.stateLabel.textColor = color_title_gray;
//    header.lastUpdatedTimeLabel.textColor = color_title_gray;
    
    // 设置刷新控件
    collection.mj_header = header;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
}

+ (void)refreshCollectionWithFooter:(UICollectionView *)collection
                    refreshingBlock:(void (^)(void))footerWithRefreshingBlock
{
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        footerWithRefreshingBlock();
        
    }];
    
    // 设置文字
    [footer setTitle:@"上拉即可加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"释放即可更新..." forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置颜色
//    footer.stateLabel.textColor = color_title_gray;
    
    // 设置footer
    collection.mj_footer = footer;
    
}


@end
