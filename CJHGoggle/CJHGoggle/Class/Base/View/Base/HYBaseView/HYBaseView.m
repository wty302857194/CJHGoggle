//
//  HYBaseView.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseView.h"

@implementation HYBaseView

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        // Initialization code
        [self initialize];
    }
    return self;
}

#pragma mark - PSBaseViewProtocol methed

- (void)initialize {
    
}

- (void)bindWithModel:(id)viewModel {
    
}

#pragma mark -

@end
