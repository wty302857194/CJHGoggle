//
//  HYUnassignedViewController.m
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

#import "HYUnassignedViewController.h"
#import "HYUnassignedTableViewCell.h"
#import "HYUnassignedModel.h"
#import "HYShipInfo.h"
#import "HYShipMapViewController.h"

@interface HYUnassignedViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, assign) BOOL isFresh;//是否加载
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation HYUnassignedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"未分配的船舶";
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    WEAKSELF;
    [HYPublicClass refreshWithHeader:self.tableView refreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.isFresh = NO;
        [weakSelf getUnassignedShipRequestData];
    }];
    [HYPublicClass refreshWithFooter:self.tableView refreshingBlock:^{
        weakSelf.page++;
        weakSelf.isFresh = YES;
        [weakSelf getUnassignedShipRequestData];
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
    
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"listviewid";
    
    HYUnassignedTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (messageCell == nil) {
        messageCell = [[[NSBundle mainBundle] loadNibNamed:@"HYUnassignedTableViewCell" owner:nil options:nil] lastObject];
    }
    
    [messageCell bindWithModel:self.dataArr[indexPath.row]];

    return messageCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYUnassignedModel *model = self.dataArr[indexPath.row];
    
    HYShipInfo *ship = [[HYShipInfo alloc] init];
    ship.mmsi = model.mmsi;
    ship.shipName = model.shipName;
    
    NSString *title = ![NSString dp_isEmptyString:model.shipName] ? model.shipName : model.mmsi;
    
    HYShipMapViewController *viewController = [[HYShipMapViewController alloc] init];
    viewController.ship = ship;
    viewController.title = title;
    [self pushNewViewController:viewController];
}

- (void)getUnassignedShipRequestData {
    
    NSDictionary *dic = @{
                          @"page":@(self.page),
                          @"size":@"20"
                          };
    WEAKSELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HYHTTPClient asynchronousPostRequest:@"myship/getUnassignedShip" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        NSLog(@"data====%@",data);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (success&&data) {
            NSArray *arr = [HYUnassignedModel mj_objectArrayWithKeyValuesArray:data[@"rows"]];
            
            if (weakSelf.isFresh) {
                
                if (arr&&arr.count > 0) {
                    
                    [weakSelf.dataArr addObjectsFromArray:arr];
                }
                else {
                    
                    [Global promptMessage:@"没有更多了" inView:weakSelf.view];
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [weakSelf.tableView reloadData];
            }
            else {
                
                [weakSelf.dataArr removeAllObjects];
                
                if (arr&&arr.count > 0) {
                    
                    [weakSelf.dataArr addObjectsFromArray:arr];
                }
                
                [weakSelf.tableView reloadData];
            }
        }
        else {
            
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [Global promptMessage:description inView:weakSelf.view];
        
    }];
}

@end
