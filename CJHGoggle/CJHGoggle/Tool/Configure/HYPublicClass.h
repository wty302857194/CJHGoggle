//
//  HYPublicClass.h
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPublicClass : NSObject

/*
 下拉刷新
 */
+ (void)refreshWithHeader:(UITableView *)tableView
          refreshingBlock:(void (^)(void))headerWithRefreshingBlock;
/*
 上拉加载
 */
+ (void)refreshWithFooter:(UITableView *)collection
          refreshingBlock:(void (^)(void))footerWithRefreshingBlock;

/*
 collection下拉刷新
 */
+ (void)refreshCollectionWithHeader:(UICollectionView *)collection
                    refreshingBlock:(void (^)(void))headerWithRefreshingBlock;
/*
 collection上拉加载
 */
+ (void)refreshCollectionWithFooter:(UICollectionView *)collection
                    refreshingBlock:(void (^)(void))footerWithRefreshingBlock;

@end
