//
//  HYMyAreaViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/2.
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

#import "HYMyAreaViewController.h"
#import "HYMyAreaTableViewCell.h"
#import "HYSelectView.h"
#import "HYCJHAreasViewController.h"
#import "HYFriendsAreasViewController.h"
#import "HYElectricAreasViewController.h"
#import "HYMyAreaModel.h"

@interface HYMyAreaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_selectBtn;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (nonatomic, strong) HYSelectView *selectView;

@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, assign) BOOL isFresh;//加载
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation HYMyAreaViewController
- (IBAction)downList:(UIButton *)sender {
    
    self.selectView.hidden = !self.selectView.hidden;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的区域";
    /***************初始化数据***********/
    _page = 1;
    self.typeId = @"0";
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self initWithData];
    
    WEAKSELF;
    [HYPublicClass refreshWithHeader:self.tableView refreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.isFresh = NO;
        [weakSelf myAreasRequestData];
    }];
    [HYPublicClass refreshWithFooter:self.tableView refreshingBlock:^{
        weakSelf.page++;
        weakSelf.isFresh = YES;
        [weakSelf myAreasRequestData];
    }];
}
// 区域类型：0、全部监控点，1、长江汇站点，2、友商监控点，3、电子围栏上水监控点，4、电子围栏下水监控点

- (void)initWithData
{
    NSArray *nameArr = @[@"全部监控点",@"长江汇监控点",@"友商监控点",@"电子围栏上水监控点",@"电子围栏下水监控点"];
    self.leftLab.text = nameArr[0];
    self.selectView.dataArr = [NSArray arrayWithArray:nameArr];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"listviewid";
    HYMyAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYMyAreaTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.myAreaModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYMyAreaModel *model = self.dataArr[indexPath.row];
    switch ([model.type?:@"" integerValue]) {
        case 1:
        {
            HYCJHAreasViewController *viewController = [[HYCJHAreasViewController alloc] init];
            viewController.title = model.name;
            viewController.ID = model.ID?:@"";
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2:
        {
            HYFriendsAreasViewController *viewController = [[HYFriendsAreasViewController alloc] init];
            viewController.title = model.name;
            viewController.ID = model.ID?:@"";
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
            
        default:
        {
            HYElectricAreasViewController *viewController = [[HYElectricAreasViewController alloc] init];
            viewController.title = model.name;
            viewController.ID = model.ID?:@"";
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
    }
    
}
#pragma mark - =========懒加载========
- (HYSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[[NSBundle mainBundle] loadNibNamed:@"HYSelectView" owner:nil options:nil] lastObject];
        _selectView.hidden = YES;
        MJWeakSelf;
        _selectView.selectBlock = ^(NSString *str, NSInteger index) {
            weakSelf.selectView.hidden = YES;
            weakSelf.leftLab.text = str;
            weakSelf.typeId = [NSString stringWithFormat:@"%ld",index];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        
        [self.view addSubview:_selectView];
        
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakSelf.view);
        }];
    }
    
    return _selectView;
}

#pragma mark - requestData
- (void)myAreasRequestData
{
    NSDictionary *dic = @{
                          @"type":self.typeId,
                          @"page":@(_page),
                          @"size":@"20"
                          };
    WEAKSELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HYHTTPClient asynchronousPostRequest:@"area/getUserArea" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        
        NSLog(@"data====%@",data);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (success && data) {
            
            NSArray *arr = [HYMyAreaModel mj_objectArrayWithKeyValuesArray:data[@"rows"]];
            
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
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

}
@end
