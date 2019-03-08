//
//  HYShipInfo.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/5/4.
//  Copyright © 2018年 耿建峰. All rights reserved.
//

#import "HYShipInfo.h"

@implementation HYShipInfo

// 是否是大V
- (BOOL)isV {
    
// 长江汇状态：0：陌生船舶，1：长江汇池中船，有号码，但尚不是客户，2：长江汇大V，3：24h内有靠泊的
    if (self.cjhState == 2) {
        
        return YES;
    }
    
    return NO;
}

// 是否在我们电销维护的池子中
- (BOOL)isP {
    
    if (self.cjhState == 1) {
        
        return YES;
    }
    
    return NO;
}

// 今天是否靠泊过长江汇
- (BOOL)hasMoorCJH {
    
    if (self.cjhState == 3) {
        
        return YES;
    }
    
    return NO;
}


@end
