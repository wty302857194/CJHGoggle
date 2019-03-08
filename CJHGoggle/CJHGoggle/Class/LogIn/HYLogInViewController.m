//
//  HYLogInViewController.m
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

#import "HYLogInViewController.h"
#import "MQVerCodeImageView.h"
#import "DPOpenSSLRSA.h"

@interface HYLogInViewController () {
    
}
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UILabel *tiXingLab;

@property (weak, nonatomic) IBOutlet UILabel *label_device_sn;

@property (nonatomic, copy) NSString *verificationStr;

@end

@implementation HYLogInViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if([USER_DEFAULTS objectForKey:@"HY_USER_NAME"]) {
        self.userTF.text = [USER_DEFAULTS objectForKey:@"HY_USER_NAME"]?:@"";
    } else {
        self.userTF.text = @"";
    }
    
    self.label_device_sn.text = [NSString stringWithFormat:@"%@", [HYManager sharedManager].getDeviceId];
    self.label_device_sn.adjustsFontSizeToFitWidth = YES;

}
- (void)showErrorWithText:(NSString *)text {
    
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.tiXingLab.text = text;
    });
}

- (IBAction)logInBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSString *userName = self.userTF.text;
    
    if ([NSString dp_isEmptyString:userName]) {
        
        [self showErrorWithText:@"用户名不能为空"];
        return;
    }
    
    NSString *password = self.passwordTF.text;
    
    if ([NSString dp_isEmptyString:password]) {
        
        [self showErrorWithText:@"密码不能为空"];
        return;
    }
    
    // 登录请求
    NSDictionary *dic = @{
                          @"username":HYNONNil(userName),
                          @"password":HYNONNil(password),
                          @"device_sn":[[HYManager sharedManager] getDeviceId],
                          @"device_type":@"1",
                          @"client_public_key" : [DPOpenSSLRSA shareInstance].clientPublicKey,
                          };
    [self logInRequestDate:dic];
}

- (IBAction)textChange:(UITextField *)sender {
//    NSLog(@"sender.text == %@",sender.text);
//    if (sender == _userTF) {
//        
//    }else if (sender == _passwordTF) {
//        
//    }else {
//        if (![sender.text isEqualToString:_verificationStr]) {
//            [Global promptMessage:@"验证码输入不正确" inView:self.view];
//        }
//    }
}
#pragma mark - 登录请求
- (void)logInRequestDate:(NSDictionary *)dic {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WEAKSELF
    [HYHTTPClient asynchronousPostRequest:HY_LogIn_API parameters:dic successBlock:^(BOOL success, id data, NSString *msg) {
        NSLog(@"data====%@",data);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (success && data) {

            HYUser *user = [HYUser mj_objectWithKeyValues:data];
            user.token = [[DPOpenSSLRSA shareInstance] decryptString:user.token privateKey:[DPOpenSSLRSA shareInstance].clientPrivateKey];
            [[HYManager sharedManager] updateCurrentUser:user];
            
            [HYSharedAppDelegate initViewController];
            
            
            [USER_DEFAULTS setObject:user.username?:@"" forKey:HY_USER_NAME];
            if([JPUSHService registrationID].length>0) {
                [USER_DEFAULTS setObject:[JPUSHService registrationID] forKey:Registration_ID];
            }
            
            [USER_DEFAULTS synchronize];

        }
        else {
            [weakSelf showErrorWithText:msg];
        }
    } failureBlock:^(NSString *description) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        [weakSelf showErrorWithText:description];
    }];
}

@end
