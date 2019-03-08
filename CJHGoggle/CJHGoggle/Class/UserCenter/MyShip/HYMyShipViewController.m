//
//  HYMyShipViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/8.
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

#import "HYMyShipViewController.h"
#import "HYShipListViewController.h"
#import "HYUnassignedViewController.h"
#import "HYImportantClientViewController.h"
#import "HYMoorShipViewController.h"
#import "HYLostShipViewController.h"
#import "HYMyTagsModel.h"

@interface HYMyShipViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;
// 我的标签
@property (nonatomic, strong) NSArray *array_tags;

@end

@implementation HYMyShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的船舶";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    WEAKSELF;
    [HYPublicClass refreshWithHeader:self.tableView refreshingBlock:^{
        
        [weakSelf getMyShipQtyRequestData];
    }];
}
#pragma mark - FooterView
- (void)initTableFooterView {
    
    if (!self.array_tags || self.array_tags.count == 0) return;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.tableView.tableFooterView = footerView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    lineView.backgroundColor = hexColor(f4f5f6);
    [footerView addSubview:lineView];
    
    UILabel *titleLab = [UILabel labelWithTitle:@"我的标签船舶：" color:hexColor(323232) fontSize:15 alignment:NSTextAlignmentLeft];
    [footerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    UIView *btnBackView = [[UIView alloc] init];
    [footerView addSubview:btnBackView];
    [btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(10);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    CGFloat marginX = 10.f;  //按钮距离左边和右边的距离
    CGFloat marginY = 10.f;  //距离上下边缘距离

    CGFloat gapX = 30.f;    //左右按钮之间的距离
    CGFloat gapY = 10.f;    //上下按钮之间的距离
    NSInteger col = 2;    //这里只布局2列

    CGFloat y_height = 40.f;
    CGFloat w_width = (kScreenWidth-marginX-marginX-gapX)/col*1.f;
    
    
    for (int i = 0; i < self.array_tags.count; i++) {
        
        HYMyTagsModel *tag = self.array_tags[i];
        
        UIButton *btn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@   %@", tag.name, tag.qty] titleColor:hexColor(323232) font:[UIFont systemFontOfSize:15] imageName:nil target:self action:@selector(goMyTags:)];
        btn.frame = CGRectMake(marginX + (w_width + gapX)*(i%col), marginY+(y_height + gapY)*(i/col), w_width, y_height);
        btn.tag = 100 +i;
        btn.borderColor = hexColor(1dac5e);
        btn.borderWidth = 0.5;
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@   %@", tag.name, tag.qty]];
        [aString addAttribute:NSForegroundColorAttributeName value:hexColor(1dac5e) range:NSMakeRange(aString.length - tag.qty.length, tag.qty.length)];
        btn.titleLabel.attributedText= aString;
        
        [btnBackView addSubview:btn];
        
    }
}
- (void)goMyTags:(UIButton *)btn {
    
    if (!btn) return;
    
    NSInteger tag = btn.tag;
    
    HYMyTagsModel *model = self.array_tags[tag - 100];
    
    if (model.qty && model.qty.integerValue > 0) {
        
        HYImportantClientViewController *vc = [[HYImportantClientViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"%@（%@）", model.name, model.qty];
        vc.tagsId = model.ID;
        [self pushNewViewController:vc];
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"listviewid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    
    NSDictionary *dictionary = [self.dataArr objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[dictionary objectForKey:@"ico"]];
    cell.textLabel.text = [dictionary objectForKey:@"title"];
    cell.detailTextLabel.text = [dictionary objectForKey:@"number"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictionary = self.dataArr[indexPath.row];
    
    NSString *number = [NSString dp_stringWithDictionary:dictionary key:@"number"];
    
    if (!number || number.integerValue == 0) {
        
        return;
    }
    
    UIViewController *viewController = nil;
    
    if (indexPath.row == 0) {
        // 我负责的船舶
        viewController = [[HYShipListViewController alloc] init];
    }
    else if (indexPath.row == 1) {
        // 近期靠泊船舶
        viewController = [[HYMoorShipViewController alloc] init];
    }
    else if (indexPath.row == 2) {
        // 近期流失船舶
        viewController = [[HYLostShipViewController alloc] init];
    }
    else if (indexPath.row == 3) {
        // 未分配船舶
        viewController = [[HYUnassignedViewController alloc] init];
    }
    else {
        
        return;
    }

    if (viewController) {
        
        [self pushNewViewController:viewController];
    }
}

#pragma mark - 请求
- (void)getMyShipQtyRequestData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAKSELF
    [HYHTTPClient asynchronousPostRequest:@"myship/getMyShipQty" parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        
        if (success && data) {
            
            weakSelf.dataArr = @[
                         @{
                             @"ico" : @"user_responsible_ship",
                             @"title" : @"我负责的船舶",
                             @"number" : [NSString dp_stringWithDictionary:data key:@"myShip"],
                             },
                         @{
                             @"ico" : @"user_stop_ship",
                             @"title" : @"近期靠泊船舶",
                             @"number" : [NSString dp_stringWithDictionary:data key:@"berthingShip"],
                             },
                         @{
                             @"ico" : @"user_lose_ship",
                             @"title" : @"近期流失船舶",
                             @"number" : [NSString dp_stringWithDictionary:data key:@"lostShip"],
                             },
                         @{
                             @"ico" : @"user_unallocated_ship",
                             @"title" : @"未分配船舶",
                             @"number" : [NSString dp_stringWithDictionary:data key:@"unassignedShip"],
                             },
                         ];
            
            [weakSelf.tableView reloadData];

            [weakSelf getMyTagShipQtyRequestData];
        }
        else {
            [weakSelf.tableView.mj_header endRefreshing];
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf.tableView.mj_header endRefreshing];
        [Global promptMessage:description inView:weakSelf.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

#pragma mark - 获取我的标签船舶数据

- (void)getMyTagShipQtyRequestData {
    
    WEAKSELF
    
    [HYHTTPClient asynchronousPostRequest:@"label/getLabelShipQty" parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (success && data) {
            
            NSArray *array = (NSArray *)data;
            
            if (array && array.count > 0) {
                
                weakSelf.array_tags = [HYMyTagsModel mj_objectArrayWithKeyValuesArray:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf initTableFooterView];
                });
            }
        }
        else {
            
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [Global promptMessage:description inView:self.view];
    }];
}

#pragma mark - Properties

- (NSArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = @[
                     @{
                         @"ico" : @"user_responsible_ship",
                         @"title" : @"我负责的船舶",
                         @"number" : @"0",
                         },
                     @{
                         @"ico" : @"user_stop_ship",
                         @"title" : @"近期靠泊船舶",
                         @"number" : @"0",
                         },
                     @{
                         @"ico" : @"user_lose_ship",
                         @"title" : @"近期流失船舶",
                         @"number" : @"0",
                         },
                     @{
                         @"ico" : @"user_unallocated_ship",
                         @"title" : @"未分配船舶",
                         @"number" : @"0",
                         },
                     ];
    }
    
    return _dataArr;
}

@end
