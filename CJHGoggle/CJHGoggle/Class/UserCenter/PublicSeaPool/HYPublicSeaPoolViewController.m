//
//  HYPublicSeaPoolViewController.m
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

#import "HYPublicSeaPoolViewController.h"
#import "HYPublicSeaPoolTableViewCell.h"
#import "HYPublicSeaPoolModel.h"
#import "HYShipMapViewController.h"
#import "HYShipInfo.h"

@interface HYPublicSeaPoolViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, assign) BOOL isFresh;//是否加载
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation HYPublicSeaPoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"公海池";
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    WEAKSELF;
    [HYPublicClass refreshWithHeader:self.tableView refreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.isFresh = NO;
        [weakSelf getPublicSeaShipRequestData];
    }];
    [HYPublicClass refreshWithFooter:self.tableView refreshingBlock:^{
        weakSelf.page++;
        weakSelf.isFresh = YES;
        [weakSelf getPublicSeaShipRequestData];
    }];
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"listviewid";
    
    HYPublicSeaPoolTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (messageCell == nil) {
        messageCell = [[[NSBundle mainBundle] loadNibNamed:@"HYPublicSeaPoolTableViewCell" owner:nil options:nil] lastObject];
    }
    
    messageCell.publicSeaPoolModel = self.dataArr[indexPath.row];
    return messageCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYPublicSeaPoolModel *model = self.dataArr[indexPath.row];
    
    HYShipInfo *ship = [[HYShipInfo alloc] init];
    ship.mmsi = model.mmsi;
    ship.latitude = model.latitude.doubleValue;
    ship.longitude = model.longitude.doubleValue;
    ship.chName = model.chname;
    ship.shipName = model.shipname;
    
    NSString *title = ![NSString dp_isEmptyString:model.chname] ? model.chname : (![NSString dp_isEmptyString:model.shipname] ? model.shipname : model.mmsi);
    
    HYShipMapViewController *viewController = [[HYShipMapViewController alloc] init];
    viewController.ship = ship;
    viewController.title = title;
    [self pushNewViewController:viewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getPublicSeaShipRequestData
{
    NSDictionary *dic = @{
                          @"page":@(self.page),
                          @"size":@"20"
                          };
    WEAKSELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HYHTTPClient asynchronousPostRequest:@"myship/getPublicSeaShip" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        NSLog(@"data====%@",data);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (success&&data) {
            NSArray *arr = [HYPublicSeaPoolModel mj_objectArrayWithKeyValuesArray:data[@"rows"]];
            
            if (weakSelf.isFresh) {
                if (arr&&arr.count>0) {
                    [weakSelf.dataArr addObjectsFromArray:arr];
                    [weakSelf.tableView reloadData];
                }else {
                    [Global promptMessage:@"没有更多了" inView:weakSelf.view];
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }
            }else {
                [weakSelf.dataArr removeAllObjects];
                if (arr&&arr.count>0) {
                    [weakSelf.dataArr addObjectsFromArray:arr];
                    [weakSelf.tableView reloadData];
                }else {
                    NSLog(@"加载空视图");
                }
            }
        }else {
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [Global promptMessage:description inView:weakSelf.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

@end
