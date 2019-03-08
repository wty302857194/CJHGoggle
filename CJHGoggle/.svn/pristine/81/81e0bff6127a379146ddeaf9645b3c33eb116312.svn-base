//
//  HYUCRemindVC.m
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/7.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYUCRemindVC.h"
#import "HYUCRemindCell.h"
#import "HYRemindModel.h"

#define HYUCRemindCellID      @"HYUCRemindCell"

@interface HYUCRemindVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic, copy) NSMutableArray *dataArr;
@end

@implementation HYUCRemindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"提醒设置";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    //mainTableView的配置
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.bounces = NO;
    [self.mainTableView registerClass:[HYUCRemindCell class] forCellReuseIdentifier:HYUCRemindCellID];
    [self.view addSubview:self.mainTableView];
    
    [self remindRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYUCRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:HYUCRemindCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellSetUp:indexPath];
    HYRemindModel *model = self.dataArr[indexPath.row];
    cell.remindModel = model;
    MJWeakSelf;
    cell.clickAction = ^(BOOL isOn){
        
        if (isOn) {
            [weakSelf openRemindRequestData:model.ID];
        }else {
            [weakSelf closeRemindRequestData:model.ID];
        }
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 73;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    backView.backgroundColor = hexColor(f4f5f6);
    
    UILabel *lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"关闭后将无法收到该类别的消息推送";
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = hexColor(f80000);
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backView);
    }];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - RequestData
- (void)remindRequestData
{
    MJWeakSelf;
    [HYHTTPClient asynchronousPostRequest:@"set/remindsetting" parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        
        if (success&&data) {
            NSArray *arr = [NSArray arrayWithArray:data];
            if (arr&&arr.count>0) {
                weakSelf.dataArr =  [HYRemindModel mj_objectArrayWithKeyValuesArray:arr];
                [self.mainTableView reloadData];
            }
        }else {
            [Global promptMessage:msg inView:self.view];
        }
    } failureBlock:^(NSString *description) {
        
    }];
}
- (void)closeRemindRequestData:(NSString *)remindId
{
    NSDictionary *dic = @{
                          @"remindid":remindId?:@""
                          };
    
    [HYHTTPClient asynchronousPostRequest:@"set/closeremind" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        
        if (success&&data&&[data isKindOfClass:[NSDictionary class]]) {
            [Global promptMessage:data[@"msg"] inView:self.view];
        }else {
            [Global promptMessage:msg inView:self.view];
        }
    } failureBlock:^(NSString *description) {
        
    }];
}
//set/openremind
- (void)openRemindRequestData:(NSString *)remindId
{
    NSDictionary *dic = @{
                          @"remindid":remindId?:@""
                          };
    
    [HYHTTPClient asynchronousPostRequest:@"set/openremind" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        
        if (success&&data&&[data isKindOfClass:[NSDictionary class]]) {
            [Global promptMessage:data[@"msg"] inView:self.view];
        }else {
            [Global promptMessage:msg inView:self.view];
        }
    } failureBlock:^(NSString *description) {
        
    }];
}
@end
