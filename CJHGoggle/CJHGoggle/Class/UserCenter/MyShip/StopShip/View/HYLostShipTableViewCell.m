//
//  HYLostShipTableViewCell.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/9.
//  Copyright © 2018年 CJH. All rights reserved.
//
/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */

#import "HYLostShipTableViewCell.h"

#import "HYLostShipModel.h"

@interface HYLostShipTableViewCell ()

@property (nonatomic, strong) HYLostShipModel *model;

@end

@implementation HYLostShipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(HYLostShipModel *)model
{
    self.shipNameLab.text = [NSString stringWithFormat:@"【%@】",model.shipName?:@""];
    self.stopStationShip.text = [NSString stringWithFormat:@"最近靠泊：%@",model.siteName?:@""];
    self.lostStationLab.text = [NSString stringWithFormat:@"流失站点：%@",model.otherName?:@""];
    self.timeLab.text = [NSString stringWithFormat:@"流失时间：%@",model.lostDate?:@""];
    
}
- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.model = nil;
    self.imgView.image = nil;
    self.shipNameLab.text = nil;
    self.lostStationLab.text = nil;
    self.stopStationShip.text = nil;
    self.timeLab.text = nil;
}

- (void)bindWithModel:(id)model {
    
    if (model && [model isKindOfClass:[HYLostShipModel class]]) {
        
        self.model = model;
        
        UIImage *image = [UIImage imageNamed:@"ship_default_right"];
        
        NSInteger cjhState = self.model.cjhState.integerValue;
        
        if (cjhState == 1) {
            
            image = [UIImage imageNamed:@"cjh_p_right"];
        }
        else if (cjhState == 2) {
            
            image = [UIImage imageNamed:@"cjh_v_right"];
        }
        
        self.imgView.image = image;
        
        self.shipNameLab.text = self.model.shipName;
        
        self.stopStationShip.text = [NSString stringWithFormat:@"最近靠泊：%@", ([NSString dp_isEmptyString:self.model.siteName] ? @"暂无" : self.model.siteName )];
        
        self.lostStationLab.text = [NSString stringWithFormat:@"流失站点：%@", self.model.otherName];
        
        self.timeLab.text = [NSString stringWithFormat:@"流失日期：%@", self.model.lostDate];
    }
}

@end
