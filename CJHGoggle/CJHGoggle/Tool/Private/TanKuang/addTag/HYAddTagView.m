//
//  HYAddTagView.m
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

#import "HYAddTagView.h"
#import "HYAddTagTableViewCell.h"
#import "HYInputTagView.h"
#import "HYUserLabelList.h"
#import "HYUserLabel.h"

static NSInteger const cellHeight = 44;

@interface HYAddTagView ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightLayout;

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) MBProgressHUD *hud;
@end
@implementation HYAddTagView

- (IBAction)addTag:(UIButton *)sender {
    
    self.hidden = YES;
    
    HYInputTagView *addTagView = [[[NSBundle mainBundle] loadNibNamed:@"HYInputTagView" owner:nil options:nil] lastObject];
    
    WEAKSELF
    
    addTagView.inputTagBlock = ^(NSString *str) {
        
        weakSelf.hidden = NO;
        
        if (![NSString dp_isEmptyString:str]) {
            
            [weakSelf requestAddTag:str];
        }
    };
    
    [self.superview addSubview:addTagView];
    
    [addTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.superview);
    }];
    
//    if (self.addTagBlock) {
//        
//        self.addTagBlock();
//    }
}

- (IBAction)isFinish:(UIButton *)sender {
    
    if (self.chooseTagBlock) {
        
        NSString *label_ids = @"";
        
        NSArray *array = self.tableView.visibleCells;
        
        for (HYAddTagTableViewCell *cell in array) {
            
            if (cell.isChoosed) {
                
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                
                NSInteger index = indexPath.row;
                
                HYUserLabel *label = [self.dataArr objectAtIndex:index];
                
                if (![self.dictionary objectForKey:label.ID]) {
                    
                    label_ids = [NSString stringWithFormat:@"%@,%@", label.ID, label_ids];
                }
            }
        }
        
        if (label_ids.length > 0) {
            
            label_ids = [label_ids substringToIndex:label_ids.length - 1];
            
            self.chooseTagBlock(label_ids);
        }
    }
}
- (IBAction)cancel:(UIButton *)sender {
    
    self.hidden = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.scrollEnabled = NO;
    
    _hud = [[MBProgressHUD alloc] initWithView:self];
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self addSubview:_hud];
    
    [self fetchMyTags];
}

- (void)bindWithModel:(id)model {
    
    if (model && [model isKindOfClass:[NSArray class]]) {
        
        NSArray *array = model;
        self.dictionary = [NSMutableDictionary dictionary];
        
        for (HYUserLabel *label in array) {
            
            [self.dictionary setObject:label forKey:label.labelId];
        }
        
        [self.tableView reloadData];
    }
}

#pragma mark - 新增标签

- (void)requestAddTag:(NSString *)name {

    NSString *url = @"/label/addLabel";
    
    NSDictionary *params = @{
                             @"token" : HYNONNil([HYManager sharedManager].currentUser.token),
                             @"name" : HYNONNil(name),
                             };
    
    WEAKSELF
    [self.hud showAnimated:YES];
    [HYHttpManager postRequestWithUrl:url params:params parserClass:[HYBaseModel class] successBlock:^(id response) {
        
        [weakSelf.hud hideAnimated:YES];
        
        [weakSelf fetchMyTags];
        
        [NOTIFICATION_CENTER postNotificationName:RELOAD_USER_LABELS object:nil];

    } failBlock:^(NSError *error) {
        [weakSelf.hud hideAnimated:YES];
        [HYFoundationCommon promotDialogWithTitle:@"添加标签" message:error.userInfo[@"msg"]?:@""];
    }];
}

#pragma mark - 获取我的标签

- (void)fetchMyTags {
    
    NSString *url = @"/label/getUserLabels";
    
    NSDictionary *params = @{
                             @"token" : HYNONNil([HYManager sharedManager].currentUser.token),
                             };
    
    WEAKSELF
    [self.hud showAnimated:YES];

    [HYHttpManager postRequestWithUrl:url params:params parserClass:[HYUserLabelList class] successBlock:^(id response) {
        [weakSelf.hud hideAnimated:YES];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            HYUserLabelList *list = response;
            
            if (list && list.data && list.data.count > 0) {
                
                weakSelf.dataArr = [NSArray arrayWithArray:list.data];
                weakSelf.tableViewHeightLayout.constant = weakSelf.dataArr.count*cellHeight;
                [weakSelf.tableView reloadData];
            }
        });
        
    } failBlock:^(NSError *error) {
        [weakSelf.hud hideAnimated:YES];

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
    return cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"listviewid";
    HYAddTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYAddTagTableViewCell" owner:nil options:nil] lastObject];
    }
    
    HYUserLabel *label = [self.dataArr objectAtIndex:indexPath.row];
    cell.nameLab.text = label.name;
    
    if ([self.dictionary objectForKey:label.ID]) {
        
        cell.isChoosed = YES;
    }
    else {
        
        cell.isChoosed = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYUserLabel *label = [self.dataArr objectAtIndex:indexPath.row];
    
    if (![self.dictionary objectForKey:label.ID]) {
        
        HYAddTagTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isChoosed = !cell.isChoosed;
    }
}
@end
