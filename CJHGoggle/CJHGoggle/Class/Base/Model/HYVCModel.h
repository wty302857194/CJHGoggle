//
//  HYVCModel.h
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYVCModel : HYBaseModel

+(void)loadWithUrl:(NSString *)requestURL withParameters:(id)parameters FinishedLogin:(void(^)(NSArray *array))FinishedSuccess fail:(void (^)(NSString *errorMsg))resultFail;

@end
