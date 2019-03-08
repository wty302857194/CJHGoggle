//
//  HYBaseTableViewController.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYBaseTableViewController ()

// 修改iOS7之后UITableView分割线左端空了15像素的问题
@property (nonatomic, assign) BOOL configureSeparator;

@property (nonatomic, strong) UIView *view_nodata;

/**
 *  判断tableView是否支持iOS7的api方法
 *
 *  @return 返回预想结果
 */
- (BOOL)validateSeparatorInset;

@end

@implementation HYBaseTableViewController

#pragma mark - Publish Method

- (void)configuraTableViewNormalSeparatorInset {
    
    self.configureSeparator = YES;
    
    if ([self validateSeparatorInset]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self validateLayoutMargins]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView {
    if ([tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
}

- (void)loadDataSource {
    // subClasse
}

- (void)updateNoDataView:(UIView *)nodataView {
    
    self.view_nodata = nodataView;
}

- (void)showNoDataView {

    self.view_nodata.hidden = NO;
//    self.tableView.backgroundView = self.view_nodata;
}

- (void)hideNoDataView {
    
    self.view_nodata.hidden = YES;
//    self.tableView.backgroundView = nil;
}

#pragma mark - Propertys

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

- (NSInteger)requestLimitPePage {
    
    if(_requestLimitPePage <= 0) {
        _requestLimitPePage = REQUEST_LIMIT;
    }
    return _requestLimitPePage;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    WEAKSELF

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONGSELF
        
        make.edges.equalTo(strongSelf.view);
    }];
    
    if (![self validateSeparatorInset]) {
        if (self.tableViewStyle == UITableViewStyleGrouped) {
            UIView *backgroundView = [[UIView alloc] initWithFrame:_tableView.bounds];
            backgroundView.backgroundColor = _tableView.backgroundColor;
            _tableView.backgroundView = backgroundView;
            [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                STRONGSELF
                
                make.edges.equalTo(strongSelf.tableView);
            }];
        }
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Helper Method

- (BOOL)validateSeparatorInset {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        return YES;
    }
    return NO;
}

- (BOOL)validateLayoutMargins {
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        return YES;
    }
    return NO;
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.configureSeparator) {
        
        // 处理ios7之后tableview每个cell的分割线左侧短15像素的问题
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}


#pragma mark - PullRefesh methods

- (void)startPullDownRefreshing {
    
    if(!self.tableView.mj_header) {
        
        return;
    }
    
    if(![self.tableView.mj_header isRefreshing]) {
        
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)endPullDownRefreshing {
    
    if(!self.tableView.mj_header) {
        return;
    }
    
    if([self.tableView.mj_header isRefreshing]) {
        
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)endLoadMoreRefreshing {
    
    if(!self.tableView.mj_footer) {
        
        return;
    }
    
    if([self.tableView.mj_footer isRefreshing]) {
        
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)addHeaderPullDownRefreshControl {
    
    if(!self.tableView.mj_header) {
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginPullDownRefreshing)];
    }
}

- (void)addFooterLoadMoreRefreshControl {
    
    if(!self.tableView.mj_footer) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginLoadMoreRefreshing)];
    }
    else {
//        self.tableView.footer.hidden = NO;
        
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (void)removeFooterLoadMoreRefreshControl {
    
    if(self.tableView.mj_footer) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        [self.tableView.footer removeFromSuperview];
//        self.tableView.footer = nil;
    }
}

#pragma mark - XHRefreshControl Delegate

- (BOOL)isLoading {
    return self.isDataLoading;
}

- (void)beginPullDownRefreshing {
    self.requestCurrentPage = 0;
    [self loadDataSource];
}

- (void)beginLoadMoreRefreshing {
    self.requestCurrentPage ++;
    [self loadDataSource];
}

@end
