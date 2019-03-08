//
//  HYFriendsAreasViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/7.
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

#import "HYFriendsAreasViewController.h"
#import "HYMyAreaModel.h"
#import "WSDatePickerView.h"
#import "HYMoorShipListViewController.h"

#define FriendColor hexColor(f8cd8d)

@interface HYFriendsAreasViewController ()
@property (weak, nonatomic) IBOutlet UILabel *passLab;
@property (weak, nonatomic) IBOutlet UILabel *bigVLab;
@property (weak, nonatomic) IBOutlet UILabel *clientLab;

@property (weak, nonatomic) IBOutlet UIButton *passBtn;
@property (weak, nonatomic) IBOutlet UIButton *bigVBtn;
@property (weak, nonatomic) IBOutlet UIButton *clientBtn;

@property (weak, nonatomic) IBOutlet UIButton *leftDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightDateBtn;
@property (nonatomic, copy) NSString *leftDateStr;
@property (nonatomic, copy) NSString *rightDateStr;

@property (nonatomic, strong) HYMyAreaNumModel *myAreaNumModel;

@end

@implementation HYFriendsAreasViewController
//日期选择
- (IBAction)chooseDate:(UIButton *)sender {
    WEAKSELF;
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHour CompleteBlock:^(NSDate *selectDate) {
        
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH"];
        NSLog(@"选择的日期：%@",dateString);
        [sender setTitle:dateString forState:UIControlStateNormal];
        if (sender == weakSelf.leftDateBtn) {
            weakSelf.leftDateStr = dateString;
        }else {
            weakSelf.rightDateStr = dateString;
        }
        if (weakSelf.leftDateStr&&weakSelf.leftDateStr.length>0&&weakSelf.rightDateStr&&weakSelf.rightDateStr.length>0) {
            [weakSelf getAreaShipQtyRequestData];
        }
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
}
- (IBAction)btnPress:(UIButton *)sender {
    
    NSString *starTime = self.leftDateStr ? [NSString stringWithFormat:@"%@:00:00", self.leftDateStr] : @"";
    NSString *endTime = self.rightDateStr ? [NSString stringWithFormat:@"%@:59:59", self.rightDateStr] : @"";
    
    HYMoorShipListViewController *viewController = [[HYMoorShipListViewController alloc] init];
    viewController.cid = self.ID;
    viewController.startdate = starTime;
    viewController.enddate = endTime;
    viewController.moor_type = MOORSHIPTYPE_MOOR;
    viewController.query_type = sender.tag - 100;
    [self pushNewViewController:viewController];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *last = [[[NSDate date] offsetDay:-1] stringWithFormat:@"yyyy-MM-dd HH"];
    NSString *now = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH"];
    
    self.leftDateStr = last;
    [self.leftDateBtn setTitle:self.leftDateStr forState:UIControlStateNormal];
    
    self.rightDateStr = now;
    [self.rightDateBtn setTitle:self.rightDateStr forState:UIControlStateNormal];
    
    self.passLab.backgroundColor = FriendColor;
    self.bigVLab.backgroundColor = FriendColor;
    self.clientLab.backgroundColor = FriendColor;
    self.passLab.text = @"靠泊数量";
    
    [self getAreaShipQtyRequestData];
}
- (void)initWithData
{
    [self.passBtn setTitle:self.myAreaNumModel.totalBerthing?:@"" forState:UIControlStateNormal];
    [self.bigVBtn setTitle:self.myAreaNumModel.largeVBerthing?:@"" forState:UIControlStateNormal];
    [self.clientBtn setTitle:self.myAreaNumModel.potentialCustomers?:@"" forState:UIControlStateNormal];
//    else {
//
//        [self.passBtn setTitle:self.myAreaNumModel.totalPass?:@"" forState:UIControlStateNormal];
//        [self.bigVBtn setTitle:self.myAreaNumModel.largeVPass?:@"" forState:UIControlStateNormal];
//        [self.clientBtn setTitle:self.myAreaNumModel.potentialPass?:@"" forState:UIControlStateNormal];
//    }
    
}

- (void)getAreaShipQtyRequestData
{
    NSString *starTime = self.leftDateStr ? [NSString stringWithFormat:@"%@:00:00", self.leftDateStr] : @"";
    NSString *endTime = self.rightDateStr ? [NSString stringWithFormat:@"%@:59:59", self.rightDateStr] : @"";
    NSDictionary *dic = @{
                          @"cid":self.ID,
                          @"startdate":starTime?:@"",
                          @"enddate":endTime?:@""
                          };
    WEAKSELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HYHTTPClient asynchronousPostRequest:@"area/getAreaShipQty" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        if (success&&data) {
            HYMyAreaNumModel *model = [HYMyAreaNumModel mj_objectWithKeyValues:data];
            weakSelf.myAreaNumModel = model;
            [weakSelf initWithData];
        }else {
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [Global promptMessage:description inView:self.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

    }];
}

@end
