//
//  HYAreaPassShipTableViewCell.m
//  Direction
//
//  Created by 耿建峰 on 2017/10/19.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYAreaPassShipTableViewCell.h"

#import "HYPassShipInfo.h"

@interface HYAreaPassShipTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView_ship;

// 船名
@property (weak, nonatomic) IBOutlet UILabel *label_name;

// 靠泊状态
@property (weak, nonatomic) IBOutlet UILabel *label_pass_status;

// 路过时间
@property (weak, nonatomic) IBOutlet UILabel *label_pass_time;

@property (nonatomic, strong) HYPassShipInfo *info;

@end

@implementation HYAreaPassShipTableViewCell

- (instancetype)init {
    
    self = [[NSBundle mainBundle] loadNibNamed:@"HYAreaPassShipTableViewCell" owner:self options:nil].lastObject;
    
    [self initialize];
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    
}

- (void)bindWithModel:(id)model {
    
    if(model && [model isKindOfClass:[HYPassShipInfo class]]) {
        
        self.info = model;
        
        //    长江汇状态：0：陌生船舶，1：长江汇池中船，有号码，但尚不是客户，2：长江汇大V，3：24h内有靠泊的
        UIImage *image = [UIImage imageNamed:@"ship_default_right"];
        
        if (self.info.cjhState == 0) {
            // 默认
            image = [UIImage imageNamed:@"ship_default_right"];
        }
        else if (self.info.cjhState == 1) {
            // 绿色船舶
            image = [UIImage imageNamed:@"cjh_p_right"];
        }
        else if (self.info.cjhState == 2) {
            // 大V
            image = [UIImage imageNamed:@"cjh_v_right"];
        }
        
        self.imageView_ship.image = image;
        
        NSString *title = ![NSString dp_isEmptyString:self.info.chname] ? self.info.chname : (![NSString dp_isEmptyString:self.info.shipname] ? self.info.shipname : self.info.mmsi);
        
        self.label_name.text = title;
        
        BOOL isUpper = NO;
        
        int course = @(self.info.course).intValue % 360;
        
        if(course >= 0 && course <= 180) {
            // 下水，向右
            isUpper = NO;
        }
        else if(course > 180 && course <= 360) {
            // 上水，向左
            isUpper = YES;
        }
        
        self.label_pass_status.text = [NSString stringWithFormat:@"航行方向：%@", (isUpper ? @"上水" : @"下水")];
        
        self.label_pass_time.text = [NSString stringWithFormat:@"路过时间：%@", self.info.createTime];
        
//        self.label_pass_status.text = [NSString stringWithFormat:@"路过时间：%@", [NSString dp_isEmptyString:self.info.moorendtime] ? @"靠泊中" : @"已离开"];
    }
}

#pragma mark - Action methods

@end
