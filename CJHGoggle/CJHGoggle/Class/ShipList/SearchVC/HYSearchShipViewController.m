//
//  HYSearchShipViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/15.
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

#import "HYSearchShipViewController.h"
#import "HYHYShipListTableViewCell.h"
#import "HYShipListModel.h"

@interface HYSearchShipViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UITextFieldDelegate>

//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//searchController
@property (strong, nonatomic)  UISearchController *searchController;

//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *dataArr;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (nonatomic, copy) NSString *keywordStr;
@end

@implementation HYSearchShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [NSMutableArray arrayWithCapacity:0];
    self.searchList = [NSMutableArray arrayWithCapacity:0];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];

    //创建UISearchController
//    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    //设置代理
//    _searchController.delegate = self;
//    _searchController.searchResultsUpdater= self;
//
//    //隐藏导航栏
//    _searchController.hidesNavigationBarDuringPresentation = YES;
//    // 添加 searchbar 到 headerview
//    self.tableView.tableHeaderView = _searchController.searchBar;
//
//    [_searchController.searchBar becomeFirstResponder];
//
//
//    [self myChargeShipRequestData];
}
//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        return [self.dataList count];
    }
}


//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"listviewid";
    HYHYShipListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYHYShipListTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}


#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
//    NSString *searchString = [self.searchController.searchBar text];
//
//    if (searchString) { // 记录搜索历史
//        NSDictionary *dictionarySearchHistories = [USER_DEFAULTS objectForKey:@"Search Histories"];
//        if (!dictionarySearchHistories) {
//            dictionarySearchHistories = @{searchString:[NSDate date]};
//        }
//        NSMutableDictionary *mutableDictionarySearchHistories = [[NSMutableDictionary alloc] initWithDictionary:dictionarySearchHistories];
//        if (![mutableDictionarySearchHistories objectForKey:searchString]) {
//            if (mutableDictionarySearchHistories.count==20) {
//                NSArray *array = [mutableDictionarySearchHistories keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//                    return [obj1 compare:obj2];
//                }];
//                [mutableDictionarySearchHistories removeObjectForKey:[array objectAtIndex:0]];
//            }
//        }
//        [mutableDictionarySearchHistories setObject:[NSDate date] forKey:searchString];
//        [USER_DEFAULTS setObject:mutableDictionarySearchHistories forKey:@"Search Histories"];
//        [USER_DEFAULTS synchronize];
//
//
//    }
    
    
    
    
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
//    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
//    //刷新表格
//    [self.tableView reloadData];

    

}
//在代理方法中实现你想要的点击操作就可以了
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    NSLog(@"点击了搜索");
    
    return YES;
    
}
    
- (void)myChargeShipRequestData
{
    NSDictionary *dic = @{
                          @"keyword":@"",
                          @"page":@"",
                          @"size":@""
                          };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WEAKSELF;
    [HYHTTPClient asynchronousPostRequest:@"myship/myChargeShip" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        NSLog(@"data====%@",data);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (success&&data) {
            NSArray *arr = [HYShipListModel mj_objectArrayWithKeyValuesArray:data[@"rows"]];
            if (arr&&arr.count>0) {
                [weakSelf.dataArr addObjectsFromArray:arr];
                [weakSelf.tableView reloadData];
            }else {
                NSLog(@"加载空视图");
            }
            
        }else {
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [Global promptMessage:description inView:weakSelf.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
