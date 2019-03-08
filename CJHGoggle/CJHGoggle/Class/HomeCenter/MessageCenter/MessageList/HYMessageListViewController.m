//
//  HYMessageListViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/13.
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

#import "HYMessageListViewController.h"
#import "HYAnnounceDetailViewController.h"
#import "HYMessageCenterTableViewCell.h"
#import "HYMessageCenterModel.h"

@interface HYMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isFresh;
@end

@implementation HYMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息列表";
    self.page = 1;
    self.isFresh = NO;
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    WEAKSELF;
    [HYPublicClass refreshWithHeader:self.tableView refreshingBlock:^{
        weakSelf.isFresh = NO;
        weakSelf.page = 1;
        [weakSelf messageListRequestData];
    }];
    [HYPublicClass refreshWithFooter:self.tableView refreshingBlock:^{
        weakSelf.page++;
        weakSelf.isFresh = YES;
        [weakSelf messageListRequestData];
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
    return 80;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"listviewid";
    HYMessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYMessageCenterTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.messageCenterModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYMessageCenterModel *model = self.dataArr[indexPath.row];
    HYAnnounceDetailViewController *vc = [[HYAnnounceDetailViewController alloc] init];
    vc.messageCenterModel = model;
    [self pushNewViewController:vc];
}
- (void)messageListRequestData
{
    NSDictionary *dic = @{
                          @"type":self.type,
                          @"page":@(self.page),
                          @"size":@"20"
                          };
    WEAKSELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HYHTTPClient asynchronousPostRequest:@"message/messageList" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (success&&data) {
            
            NSArray *arr = [HYMessageCenterModel mj_objectArrayWithKeyValuesArray:data[@"rows"]];
            
            if (weakSelf.isFresh) {
                
                if (arr && arr.count > 0) {
                    
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
                
                if (arr&&arr.count>0) {
                    
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
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
