//
//  HYStationItemView.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 2018/8/4.
//  Copyright © 2018年 gengjf. All rights reserved.
//

#import "HYStationItemView.h"

#import "HYStation.h"

@interface HYStationItemView ()

@property (nonatomic, strong) UIImageView *imageView_ico;

@property (nonatomic, strong) UILabel *label_name;

@property (nonatomic, strong) HYStation *model;

@end

@implementation HYStationItemView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    
    [self addSubview:self.imageView_ico];
    
    [self addSubview:self.label_name];
    
    WEAKSELF
    
    [self.imageView_ico mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).offset(-7.5);
    }];
    
    [self.label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.imageView_ico.mas_bottom).offset(2.5);
        make.bottom.equalTo(weakSelf);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    
    [self addGestureRecognizer:tap];
}

- (void)bindWithModel:(id)model {
    
    if (model && [model isKindOfClass:[HYStation class]]) {
        
        self.model = model;
        
        self.label_name.text = self.model.name;
    }
}

- (HYStation *)station {
    
    return self.model;
}

- (void)clicked:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(stationItemViewChange:)]) {
        
        [self.delegate stationItemViewChange:self];
    }
}

#pragma mark - Properties

- (UIImageView *)imageView_ico {
    
    if(!_imageView_ico) {
        
        _imageView_ico = [[UIImageView alloc] init];
        _imageView_ico.image = [UIImage imageNamed:@"home_ico_station"];
    }
    
    return _imageView_ico;
}

- (UILabel *)label_name {
    
    if(!_label_name) {
        
        _label_name = [[UILabel alloc] init];
        _label_name.backgroundColor = [UIColor clearColor];
        _label_name.font = [UIFont systemFontOfSize:11];
        _label_name.textColor = DP_HexRGB(0x363738);
        _label_name.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    return _label_name;
}

@end
