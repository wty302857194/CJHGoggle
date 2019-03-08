//
//  ViewController.m
//  CJHGoggle
//
//  Created by 阿杰 on 2018/7/31.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "ViewController.h"
#import "HYVCModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [HYVCModel loadWithUrl:goodDeeds_virtueDeed_API withParameters:nil FinishedLogin:^(NSArray *array) {
        
        
        
        
    } fail:^(NSString *errorMsg) {
        
        
        
        
    }];
//    
//    [HYPublicClass refreshWithHeader:<#(UITableView *)#> refreshingBlock:^{
//        
//    }];
//    
//    [HYPublicClass refreshWithFooter:<#(UITableView *)#> refreshingBlock:^{
//        
//    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
