//
//  HYMoorShipViewController.m
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

#import "HYMoorShipViewController.h"

#import "HYMoorShipTableViewCell.h"

#import "HYMoorShipModel.h"

#import "HYShipInfo.h"

#import "HYShipMapViewController.h"

@interface HYMoorShipViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HYMoorShipViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"近期靠泊";
    
    self.tableView.tableFooterView = [UIView new];
    
    WEAKSELF;
    [HYPublicClass refreshWithHeader:self.tableView refreshingBlock:^{
        
        weakSelf.page = 1;
        // 获取近期靠泊的船舶数据
        [weakSelf getMooredShipRequestData];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr ? self.dataArr.count : 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"listviewid";
    
    HYMoorShipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYMoorShipTableViewCell" owner:nil options:nil] lastObject];;
    }
    
    [cell bindWithModel:self.dataArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYMoorShipModel *model = self.dataArr[indexPath.row];
    
    HYShipInfo *ship = [[HYShipInfo alloc] init];
    ship.mmsi = model.mmsi;
    ship.shipName = model.shipName;
    
    NSString *title = ![NSString dp_isEmptyString:model.shipName] ? model.shipName : model.mmsi;
    
    HYShipMapViewController *viewController = [[HYShipMapViewController alloc] init];
    viewController.ship = ship;
    viewController.title = title;
    [self pushNewViewController:viewController];
}

// 近期靠泊船舶
- (void)getMooredShipRequestData {
    
    NSDictionary *dic = @{
                          @"page":@(_page),
                          @"size":@"20"
                          };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAKSELF
    [HYHTTPClient asynchronousPostRequest:@"myship/getRecentlyBberthing" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        if (success && data && [data isKindOfClass:[NSDictionary class]]) {
            
            NSArray *array = (NSArray *)data[@"rows"];
            
            if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
                
                weakSelf.dataArr = [HYMoorShipModel mj_objectArrayWithKeyValuesArray:array];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf.tableView reloadData];
                });
            }
        }
        else {
            
            [Global promptMessage:msg inView:self.view];
        }
        
    } failureBlock:^(NSString *description) {
        
        [Global promptMessage:description inView:weakSelf.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

@end
