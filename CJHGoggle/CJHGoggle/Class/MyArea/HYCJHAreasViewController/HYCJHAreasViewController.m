//
//  HYOtherAreasViewController.m
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

#import "HYCJHAreasViewController.h"
#import "HYMyAreaModel.h"
#import "WSDatePickerView.h"

#import "HYMoorShipListViewController.h"

#import "HYPassShipListViewController.h"

@interface HYCJHAreasViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightDateBtn;
@property (nonatomic, copy) NSString *leftDateStr;
@property (nonatomic, copy) NSString *rightDateStr;

@property (weak, nonatomic) IBOutlet UIButton *stopShipNum;
@property (weak, nonatomic) IBOutlet UIButton *bigVNum;
@property (weak, nonatomic) IBOutlet UIButton *clientNum;

@property (weak, nonatomic) IBOutlet UIButton *allNum;
@property (weak, nonatomic) IBOutlet UIButton *topWaterNum;
@property (weak, nonatomic) IBOutlet UIButton *bottomWaterNum;
@property (weak, nonatomic) IBOutlet UIButton *bigVNum2;
@property (weak, nonatomic) IBOutlet UIButton *clientNum2;


@property (nonatomic, strong) HYMyAreaNumModel *myAreaNumModel;
@end

@implementation HYCJHAreasViewController

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
        if (weakSelf.leftDateStr && weakSelf.leftDateStr.length > 0 && weakSelf.rightDateStr && weakSelf.rightDateStr.length > 0) {
            
            [weakSelf getAreaShipQtyRequestData];
        }
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    
}
//靠泊船舶
- (IBAction)stopShip:(UIButton *)sender {
    
    NSString *starTime = self.leftDateStr ? [NSString stringWithFormat:@"%@:00:00", self.leftDateStr] : @"";
    NSString *endTime = self.rightDateStr ? [NSString stringWithFormat:@"%@:59:59", self.rightDateStr] : @"";
    
    HYMoorShipListViewController *viewController = [[HYMoorShipListViewController alloc] init];
    viewController.cid = self.ID;
    viewController.startdate = starTime;
    viewController.enddate = endTime;
    viewController.moor_type = MOORSHIPTYPE_CJH_MOOR;
    viewController.query_type = sender.tag - 100;
    [self pushNewViewController:viewController];
}

- (IBAction)passShip:(UIButton *)sender {
    
    NSString *starTime = self.leftDateStr ? [NSString stringWithFormat:@"%@:00:00", self.leftDateStr] : @"";
    NSString *endTime = self.rightDateStr ? [NSString stringWithFormat:@"%@:59:59", self.rightDateStr] : @"";
    
    HYPassShipListViewController *viewController = [[HYPassShipListViewController alloc] init];
    viewController.cid = self.ID;
    viewController.startdate = starTime;
    viewController.enddate = endTime;
    viewController.pass_type = PASSSHIPTYPE_CJH_PASS;
    viewController.query_type = sender.tag - 1000;
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
    
    [self getAreaShipQtyRequestData];
}

- (void)initWithData
{
    [self.stopShipNum setTitle:self.myAreaNumModel.totalBerthing?:@"" forState:UIControlStateNormal];
    [self.bigVNum setTitle:self.myAreaNumModel.largeVBerthing?:@"" forState:UIControlStateNormal];
    [self.clientNum setTitle:self.myAreaNumModel.potentialCustomers?:@"" forState:UIControlStateNormal];
    
    [self.allNum setTitle:self.myAreaNumModel.totalPass?:@"" forState:UIControlStateNormal];
    [self.topWaterNum setTitle:self.myAreaNumModel.upWaterPass?:@"" forState:UIControlStateNormal];
    [self.bottomWaterNum setTitle:self.myAreaNumModel.downWaterPass?:@"" forState:UIControlStateNormal];
    [self.bigVNum2 setTitle:self.myAreaNumModel.largeVPass?:@"" forState:UIControlStateNormal];
    [self.clientNum2 setTitle:self.myAreaNumModel.potentialPass?:@"" forState:UIControlStateNormal];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getAreaShipQtyRequestData {
    
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
            [Global promptMessage:msg inView:self.view];
        }
    } failureBlock:^(NSString *description) {
        [Global promptMessage:description inView:self.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

    }];
}

@end
