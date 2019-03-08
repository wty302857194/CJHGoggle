//
//  ZJCustomNoTableView.m
//  zjcharity
//
//  Created by 阿杰 on 2017/11/21.
//  Copyright © 2017年 善纳得. All rights reserved.
//

#import "ZJCustomNoTableView.h"
#
#define NOTableViewID   @"NOTableViewDE"

@interface ZJCustomNoTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) NSTimeInterval timeInterval;
@property (nonatomic,assign) NSInteger currentRowIndex;//计数器

@end

@implementation ZJCustomNoTableView


+(instancetype)noTableViewWithTitle:(NSArray *)DataArray timeArray:(NSArray *)timeArray timeInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame
{
    ZJCustomNoTableView *custView = [[ZJCustomNoTableView alloc] initWithFrame:frame];
    custView.dataArray = DataArray;
    custView.timeArray = timeArray;
    custView.timeInterval = timeInterval ? timeInterval : 1;
    
    return custView;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        [self addSubview:backView];
        
        self.noTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.noTableView.backgroundColor = [UIColor clearColor];
        self.noTableView.delegate = self;
        self.noTableView.dataSource = self;
        self.noTableView.rowHeight = frame.size.height/3.f;
        self.noTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.noTableView.userInteractionEnabled = NO;
        [self.noTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NOTableViewID];
        [self addSubview:self.noTableView];
        
    }
    return self;
}

#pragma mark - priviate method
-(void)setTimeInterval:(NSTimeInterval)timeInterval
{
    // 定时器
    self.noTableViewTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(noTableviewtimer) userInfo:nil repeats:YES];
}

- (void)noTableviewtimer {
    
    self.currentRowIndex++;
    
    [self.noTableView setContentOffset:CGPointMake(0, _currentRowIndex * self.frame.size.height/3.f) animated:YES];
    
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 以无动画的形式跳到第1组的第0行
    if (_currentRowIndex == self.dataArray.count) {
        
        _currentRowIndex = 0;
        [self.noTableView setContentOffset:CGPointZero];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOTableViewID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    //地址
    NSString *str = self.dataArray[indexPath.row];
    NSRange numRang = [str rangeOfString:self.timeArray[indexPath.row]];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:hexColor(000000),NSForegroundColorAttributeName, nil];
    NSDictionary *attributeNumDic = [NSDictionary dictionaryWithObjectsAndKeys:hexColor(999999),NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *attribuedStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attributeDict];
    [attribuedStr setAttributes:attributeNumDic range:numRang];
    
    cell.textLabel.attributedText = attribuedStr;
    cell.textLabel.textColor = [UIColor whiteColor];

    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

