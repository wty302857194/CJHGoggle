//
//  HYOilSaledTableViewCell.m
//  Direction
//
//  Created by 耿建峰 on 2017/10/19.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYOilSaledTableViewCell.h"

#import "HYShipDetailInfo.h"

@interface HYOilSaledTableViewCell ()

// 站点名
@property (weak, nonatomic) IBOutlet UILabel *label_name;
// 消费日期
@property (weak, nonatomic) IBOutlet UILabel *label_date;
// 消费吨数或金额
@property (weak, nonatomic) IBOutlet UILabel *label_saled;

@property (nonatomic, strong) HYBaseModel *model;

@end

@implementation HYOilSaledTableViewCell

- (instancetype)init {
    
    self = [[NSBundle mainBundle] loadNibNamed:@"HYOilSaledTableViewCell" owner:self options:nil].lastObject;
    
    [self initialize];
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initialize];
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.model = nil;
    self.label_name.text = nil;
    self.label_date.text = nil;
    self.label_saled.text = nil;
}

- (void)initialize {
    
}

- (void)bindWithModel:(id)model {
    
    if (model && [model isKindOfClass:[HYShipOilRecord class]]) {
        
        self.model = model;
        
        self.label_name.text = ((HYShipOilRecord *)model).site_name;
        self.label_date.text = ((HYShipOilRecord *)model).sale_date;
        self.label_saled.text = [NSString stringWithFormat:@"%ld吨", ((HYShipOilRecord *)model).oilqty.integerValue];
    }
    else if (model && [model isKindOfClass:[HYShipNoOilRecord class]]) {
        
        self.model = model;
        
        self.label_name.text = ((HYShipNoOilRecord *)model).site_name;
        self.label_date.text = ((HYShipNoOilRecord *)model).sale_date;
        self.label_saled.text = [NSString stringWithFormat:@"%.02f元", ((HYShipNoOilRecord *)model).total.doubleValue];
    }
}

#pragma mark - Action methods

@end
