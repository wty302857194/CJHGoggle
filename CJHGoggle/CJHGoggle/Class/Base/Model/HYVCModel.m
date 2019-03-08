//
//  HYVCModel.m
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYVCModel.h"

@implementation HYVCModel

+(void)loadWithUrl:(NSString *)requestURL withParameters:(id)parameters FinishedLogin:(void(^)(NSArray *))FinishedSuccess fail:(void(^)(NSString *))resultFail
{
    
    [HYHTTPClient asynchronousPostRequest:requestURL parameters:parameters successBlock:^(BOOL success, NSDictionary *data, NSString *msg) {
        
        if (success) {
            
//            NSArray *array = [NSArray yy_modelArrayWithClass:[ZJGoodDeedsVirtueDeedModel class] json:data[@"info"]];
            
//            FinishedSuccess(array);
            
        }else{
            
            resultFail(@"请求失败");
            
        }
        
    } failureBlock:^(NSString *description) {
        
        
//        [YJProgressHUD showMessage:@"网络异常"];
        
        resultFail(@"网络异常");
        
    }];
    
    
}

@end
