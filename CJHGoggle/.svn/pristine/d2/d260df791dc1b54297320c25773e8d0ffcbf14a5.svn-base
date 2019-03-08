//
//  HYMonitorListTableViewCell.m
//  Direction
//
//  Created by 耿建峰 on 2017/10/19.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYSailorTableViewCell.h"

#import "HYShipDetailInfo.h"

@interface HYSailorTableViewCell ()

// 姓名
@property (weak, nonatomic) IBOutlet UILabel *label_name;
// 手机号
@property (weak, nonatomic) IBOutlet UILabel *label_phone;
// 会员等级
@property (weak, nonatomic) IBOutlet UILabel *label_level;
// 状态
@property (weak, nonatomic) IBOutlet UILabel *label_status;

@property (weak, nonatomic) IBOutlet UIView *view_bottom_line;

@property (nonatomic, strong) HYShipMemberRecord *info;

@end

@implementation HYSailorTableViewCell

- (instancetype)init {
    
    self = [[NSBundle mainBundle] loadNibNamed:@"HYSailorTableViewCell" owner:self options:nil].lastObject;
    
    [self initialize];
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initialize];
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.info = nil;
    self.label_name.text = nil;
    self.label_level.text = nil;
    self.label_phone.text = nil;
    self.label_status.text = nil;
}

- (void)initialize {
    
}

- (void)bindWithModel:(id)model {
    
    if(model && [model isKindOfClass:[HYShipMemberRecord class]]) {
        
        self.info = model;
        
        self.label_name.text = [NSString dp_isEmptyString:self.info.user_name] ? @"未知" : self.info.user_name;
        
        self.label_phone.text = self.info.reg_phone;
        
        self.label_level.text = self.info.type;
        
        self.label_status.text = self.info.state;
    }
}

- (void)setIsLast:(BOOL)isLast {
    
    _isLast = isLast;
    
    self.view_bottom_line.hidden = !_isLast;
}

#pragma mark - Action methods

@end
