//
//  HYSailorTableHeaderView.m
//  Direction
//
//  Created by 耿建峰 on 2017/10/15.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYSailorTableHeaderView.h"

@interface HYSailorTableHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *view;

@end

@implementation HYSailorTableHeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super initWithCoder:aDecoder]) {
        
        [[NSBundle mainBundle] loadNibNamed:@"HYSailorTableHeaderView" owner:self options:nil];
        
        [self addSubview:self.view];
        
        [self initialize];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initialize];
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        [[NSBundle mainBundle] loadNibNamed:@"HYSailorTableHeaderView" owner:self options:nil];
        
        [self addSubview:self.view];
        
        [self initialize];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.view.frame = self.bounds;
}

#pragma mark - PSBaseViewProtocol methed

- (void)initialize {
    
}

- (void)bindWithModel:(id)viewModel {
    
}

@end
