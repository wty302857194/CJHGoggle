//
//  HYAnnounceView.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/20.
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

#import "HYAnnounceView.h"
#import "HYAddTagTableViewCell.h"
#import "HYAnnounceModel.h"

static NSInteger const cellHeight = 50;
@interface HYAnnounceView () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabViewHeightLayout;

@end
@implementation HYAnnounceView
- (IBAction)finishClick:(UIButton *)sender {
    if (self.finishBlock) {
        NSArray *cellArr = [self.tableView visibleCells];
        __block NSString *ids = @"";
        __block NSString *names = @"";
        [cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HYAnnounceModel *mode = self.dataArr[idx];
            HYAddTagTableViewCell *cell = (HYAddTagTableViewCell *)obj;
            if (cell.isChoosed) {
                if (ids.length == 0) {
                    ids = mode.ID?:@"";
                }else {
                    ids = [NSString stringWithFormat:@"%@,%@",ids,mode.ID?:@""];
                }
                names = names.length == 0?mode.departmentName?:@"":[NSString stringWithFormat:@"%@,%@",names,mode.departmentName?:@""];
            }
        }];
        self.finishBlock(ids,names);
    }
}
- (IBAction)cancelClick:(UIButton *)sender {
    self.hidden = YES;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    self.tabViewHeightLayout.constant = cellHeight*_dataArr.count;
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
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
    HYAddTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYAddTagTableViewCell" owner:nil options:nil] lastObject];
    }
    HYAnnounceModel *model = _dataArr[indexPath.row];
    cell.nameLab.text = model.departmentName?:@"";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYAddTagTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isChoosed = !cell.isChoosed;
    
}
@end
