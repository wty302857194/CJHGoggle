//
//  HYSelectView.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/6.
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

#import "HYSelectView.h"
static NSInteger const cellHeight = 44;

@interface HYSelectViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *text_lab;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@implementation HYSelectViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _text_lab = [[UILabel alloc] init];
        _text_lab.textAlignment = NSTextAlignmentCenter;
        _text_lab.font = [UIFont systemFontOfSize:15];
        _text_lab.textColor = hexColor(323232);
        [self.contentView addSubview:_text_lab];
        [_text_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
@end

@interface HYSelectView () {
    double y_height;
}

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeightLayout;

@end
@implementation HYSelectView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}
- (void)initialize {
    
    self.backgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    
    [self.backgroundView addGestureRecognizer:tap];
}
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    
    self.selectViewHeightLayout.constant  = self.dataArr.count * cellHeight;
    
    [self.tableView reloadData];
}

- (void)bindWithModel:(id)model {
    
    if (model && [model isKindOfClass:[NSArray class]]) {
        
        self.dataArr = model;
        
        self.selectViewHeightLayout.constant  = self.dataArr.count * cellHeight;
        
        [self.tableView reloadData];
    }
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
    return cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"listviewid";
    HYSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[HYSelectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.text_lab.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectBlock) {
        self.selectBlock([self.dataArr objectAtIndex:indexPath.row], indexPath.row);
    }
}

#pragma mark - Action methed

- (void)selectAtIndex:(NSInteger)index {
    
    if (!self.dataArr || self.dataArr.count == 0) return;
    
    if (index >= self.dataArr.count) return;
    
    if (self.selectBlock) {
        
        self.selectBlock([self.dataArr objectAtIndex:index], index);
    }
}

- (void)clicked:(id)sender {
    
    WEAKSELF
    
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.hidden = YES;
    }];
}

@end
