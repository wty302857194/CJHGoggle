//
//  HYAnnounceViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/8.
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

#import "HYAnnounceViewController.h"
#import "FSTextView.h"
#import "HYAnnounceModel.h"
#import "HYAnnounceView.h"

@interface HYAnnounceViewController ()

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *contentStr;

@property (weak, nonatomic) IBOutlet FSTextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (nonatomic, copy) NSArray *dataArr;//获取部门列表的数据

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) HYAnnounceView *announceView;
@end

@implementation HYAnnounceViewController

- (IBAction)chooseTitle:(UIButton *)sender {
    self.announceView.hidden = !self.announceView.hidden;
    
    self.announceView.dataArr = [NSArray arrayWithArray:self.dataArr];
}

//确认发布
- (IBAction)sureAnnounce:(UIButton *)sender {
    

    MJWeakSelf;
    ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:self.view.bounds];
    select_view.choose_type = ONLYTEXTTYPE;
    select_view.isShowCancelBtn = YES;
    select_view.isShowSureBtn = YES;
    select_view.isShowTitle = YES;
    select_view.sureBtn_title_color = hexColor(ff4e00);
    select_view.content_text = @"\n发布后将无法撤销\n";
    select_view.sureBtn_title = @"确认";
    select_view.cancelBtn_title = @"取消";
    select_view.sureBtn_title_color = hexColor(ff4e00);
    select_view.lab_content.textAlignment = NSTextAlignmentCenter;
    select_view.contentTextFount = 15;
    select_view.title_height = 50;
    [select_view addTitleArray:nil andTitleString:@"确认发布" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
        
    } withSureButtonBlock:^{
        NSLog(@"sure btn");
        [weakSelf publishRequestData];
    }];
    [self.view addSubview:select_view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布公告";
    self.titleArr = [NSMutableArray arrayWithCapacity:0];
    self.ID = @"";
    self.contentStr = @"";
    
    _contentTV.placeholder = @"内容不可超过144个字";
    _contentTV.maxLength = 144;
    
    MJWeakSelf;
    [_contentTV addTextLengthDidMaxHandler:^(FSTextView *textView) {
        [Global promptMessage:@"内容不可超过144个字" inView:weakSelf.view];
    }];
    [_contentTV addTextDidChangeHandler:^(FSTextView *textView) {
        weakSelf.contentStr = textView.text;
    }];
    
    [self getDepartmentsRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - notice/publish -- RequestData

- (void)getDepartmentsRequestData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MJWeakSelf
    [HYHTTPClient asynchronousPostRequest:@"notice/getDepartments" parameters:nil successBlock:^(BOOL success, id data, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (success&&data) {
            
            NSArray *arr = (NSArray *)data;
            
            weakSelf.dataArr = [HYAnnounceModel mj_objectArrayWithKeyValuesArray:arr];
            
            for (HYAnnounceModel *model in weakSelf.dataArr) {
                
                [weakSelf.titleArr addObject:model.departmentName?:@""];
            }
        }
        else {
            
            [Global promptMessage:msg inView:weakSelf.view];
        }
        
    } failureBlock:^(NSString *description) {
        
        [Global promptMessage:description inView:weakSelf.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

- (void)publishRequestData
{
    if (self.ID.length == 0) {
        [Global promptMessage:@"部门不能为空" inView:self.view];
        return;
    }
    if (self.contentStr.length == 0) {
        [Global promptMessage:@"内容不能为空" inView:self.view];
        return;
    }
    NSDictionary *dic = @{
                          @"department_ids":self.ID,
                          @"content":self.contentStr
                          };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MJWeakSelf;
    [HYHTTPClient asynchronousPostRequest:@"notice/publish" parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (success&&data) {
            weakSelf.contentTV.text = nil;
            [Global promptMessage:msg inView:weakSelf.view];

        }else {
            [Global promptMessage:msg inView:weakSelf.view];
        }
    } failureBlock:^(NSString *description) {
        [Global promptMessage:description inView:weakSelf.view];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

#pragma mark - ==懒加载==


- (HYAnnounceView *)announceView
{
    if(!_announceView) {
        _announceView = [[[NSBundle mainBundle] loadNibNamed:@"HYAnnounceView" owner:nil options:nil] lastObject];
        _announceView.hidden = YES;
        WEAKSELF
        _announceView.finishBlock = ^(NSString *departmentId, NSString *names) {
            weakSelf.announceView.hidden = YES;
            weakSelf.ID = departmentId?:@"";
            [weakSelf.titleBtn setTitle:names.length==0?@"选择部门":names forState:UIControlStateNormal];
            [weakSelf.titleBtn setTitleColor:names.length==0?hexColor(808080):hexColor(323232) forState:UIControlStateNormal];
        };
        
        [self.view addSubview:_announceView];
        
        [_announceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _announceView;
}
@end
