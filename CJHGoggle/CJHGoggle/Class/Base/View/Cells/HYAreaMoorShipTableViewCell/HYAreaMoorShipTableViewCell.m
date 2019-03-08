//
//  HYAreaMoorShipTableViewCell.m
//  Direction
//
//  Created by 耿建峰 on 2017/10/19.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYAreaMoorShipTableViewCell.h"

#import "HYMoorShipInfo.h"

@interface HYAreaMoorShipTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView_ship;

// 船名
@property (weak, nonatomic) IBOutlet UILabel *label_name;

// 靠泊状态
@property (weak, nonatomic) IBOutlet UILabel *label_moor_status;

// 靠泊时间
@property (weak, nonatomic) IBOutlet UILabel *label_moor_time;

// 靠泊持续时间
@property (weak, nonatomic) IBOutlet UILabel *label_duration;

@property (nonatomic, strong) HYMoorShipInfo *info;

@end

@implementation HYAreaMoorShipTableViewCell

- (instancetype)init {
    
    self = [[NSBundle mainBundle] loadNibNamed:@"HYAreaMoorShipTableViewCell" owner:self options:nil].lastObject;
    
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
    
    if(model && [model isKindOfClass:[HYMoorShipInfo class]]) {
        
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
        
        NSString *title = ![NSString dp_isEmptyString:self.info.shipname] ? self.info.shipname : self.info.mmsi;
        
        self.label_name.text = title;
        
        self.label_moor_time.text = [NSString stringWithFormat:@"靠泊时间：%@", [NSDate dateWithTimeIntervalSince1970:self.info.moorstarttime.integerValue/1000].string];
        
        self.label_moor_status.text = [NSString stringWithFormat:@"靠泊状态：%@", [NSString dp_isEmptyString:self.info.moorendtime] ? @"靠泊中" : @"已离开"];
        
        if (self.info.moorendtime && self.info.moorstarttime) {
            
            NSInteger duration = (self.info.moorendtime.integerValue - self.info.moorstarttime.integerValue) / (1000 * 60);
            
            self.label_duration.text = [NSString stringWithFormat:@"停留时间：%ld分钟", duration];
        }
       
    }
}

#pragma mark - Action methods

@end
