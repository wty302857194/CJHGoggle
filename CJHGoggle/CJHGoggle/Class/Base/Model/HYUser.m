//
//  HYUser.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYUser.h"

@interface HYUser ()

@end

@implementation HYUser


#pragma mark - 拥有的权限

// 是否拥有添加监控区域权限
- (BOOL)haveAddMonitorRight {
    
    return self.add_monitor;
}

// 是否拥有移除监控区域权限
- (BOOL)haveRemoveMonitorRight {
    
    return self.delete_monitor;
}

// 是否拥有查看区域权限
- (BOOL)haveMyAreaRight {
    
    return self.my_area;
}

// 是否拥有我的船舶列表权限
- (BOOL)haveMyShipsRight {
    
    return self.my_ship;
}
// 是否拥有标签权限
- (BOOL)haveMyLabelRight {
    
    return self.my_label;
}

@end
