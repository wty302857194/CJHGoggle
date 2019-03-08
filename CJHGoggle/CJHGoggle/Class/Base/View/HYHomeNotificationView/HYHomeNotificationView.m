//
//  HYHomeNotificationView.m

#import "HYHomeNotificationView.h"
#import "HYNotification.h"

#define HYHomeNotificationTableViewID   @"HYHomeNotificationTableViewID"

@interface HYHomeNotificationView()<UITableViewDelegate,UITableViewDataSource>

// 定时器间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
// 计数器
@property (nonatomic, assign) NSInteger currentRowIndex;

// 定时器
@property (nonatomic, strong) NSTimer *noTableViewTimer;

// 数据数组
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *noTableView;

@end

@implementation HYHomeNotificationView

- (instancetype)initWithInterval:(NSTimeInterval)timeInterval {
    
    if (self = [super init]) {
        
        _timeInterval = timeInterval ? timeInterval : 1;
    }
    
    return self;
}

- (void)initialize {
    
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    WEAKSELF
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    
    self.noTableView = [[UITableView alloc] init];
    self.noTableView.backgroundColor = [UIColor clearColor];
    self.noTableView.delegate = self;
    self.noTableView.dataSource = self;
    self.noTableView.rowHeight = 40.f;
    self.noTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.noTableView.scrollEnabled = NO;
    [self.noTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HYHomeNotificationTableViewID];
    [self addSubview:self.noTableView];
    
    [self.noTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
}

- (void)bindWithModel:(id)model {
    
    if (model && [model isKindOfClass:[NSArray class]]) {
        
        self.dataArray = model;
        
        [self.noTableView reloadData];
        
        self.timeInterval = self.timeInterval;
    }
}

#pragma mark - priviate method

-(void)setTimeInterval:(NSTimeInterval)timeInterval {
    
    _timeInterval = timeInterval;
    
    [self resetTimer];
    
    // 定时器
    self.noTableViewTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(noTableviewtimer) userInfo:nil repeats:YES];
}

- (void)noTableviewtimer {
    
    self.currentRowIndex++;
    
    [self.noTableView setContentOffset:CGPointMake(0, _currentRowIndex * self.frame.size.height/3.f) animated:YES];
}

- (void)resetTimer {
    
    if (self.noTableViewTimer && [self.noTableViewTimer isValid]) {
        
        [self.noTableViewTimer invalidate];
        self.noTableViewTimer = nil;
    }
}

- (void)cancelShow {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.hidden = YES;
    }];
    
    [self resetTimer];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 以无动画的形式跳到第1组的第0行
    if (_currentRowIndex == self.dataArray.count) {
        
        // 显示完毕，隐藏
        [self cancelShow];
        
        _currentRowIndex = 0;
        [self.noTableView setContentOffset:CGPointZero];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HYHomeNotificationTableViewID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    HYNotification *notification = [self.dataArray objectAtIndex:indexPath.row];
    
    //地址
    NSString *str = [NSString stringWithFormat:@"【%@】%@", notification.notification_title, notification.notification_message];
    NSRange numRang = [str rangeOfString:[NSString stringWithFormat:@"【%@】", notification.notification_title]];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    NSDictionary *attributeNumDic = [NSDictionary dictionaryWithObjectsAndKeys:hexColor(ffe987),NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *attribuedStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attributeDict];
    [attribuedStr setAttributes:attributeNumDic range:numRang];
    
    cell.textLabel.attributedText = attribuedStr;
    
    cell.textLabel.numberOfLines = 2;
    
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
//    cell.textLabel.textColor = [UIColor whiteColor];

    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeNotificationView:withObj:)]) {
        
        [self.delegate homeNotificationView:self withObj:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
}

@end

