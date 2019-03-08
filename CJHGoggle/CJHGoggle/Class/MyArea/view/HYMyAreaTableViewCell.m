//
//  HYMyAreaTableViewCell.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/7.
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

#import "HYMyAreaTableViewCell.h"
#import "HYMyAreaModel.h"

@implementation HYMyAreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setMyAreaModel:(HYMyAreaModel *)myAreaModel
{
    _myAreaModel = myAreaModel;
    
    NSInteger type = myAreaModel.type.integerValue;
    
    if (type == 1) {
        // 长江汇站点
        self.nameLab.text = [NSString stringWithFormat:@"长江汇 -【%@】",myAreaModel.name?:@""];
        self.imgView.image = [UIImage imageNamed:@"user_stop_ship"];
        self.contentLab.text = [NSString stringWithFormat:@"近期靠泊数量：%@只船舶",myAreaModel.shipqty?:@""];
    }
    else if (type == 2) {
        // 友商监控点
        self.nameLab.text = [NSString stringWithFormat:@"友商 -【%@】",myAreaModel.name?:@""];
        self.imgView.image = [UIImage imageNamed:@"user_lose_ship"];
        self.contentLab.text = [NSString stringWithFormat:@"近期靠泊数量：%@只船舶",myAreaModel.shipqty?:@""];
    }
    else if (type == 3) {
        // 上水电子围栏
        self.nameLab.text = [NSString stringWithFormat:@"上水电子围栏 -【%@】",myAreaModel.name?:@""];
        self.imgView.image = [UIImage imageNamed:@"user_unallocated_ship"];
        self.contentLab.text = [NSString stringWithFormat:@"近期途径数量：%@只船舶",myAreaModel.shipqty?:@""];
    }
    else if (type == 4) {
        // 下水电子围栏
        self.nameLab.text = [NSString stringWithFormat:@"下水电子围栏 -【%@】",myAreaModel.name?:@""];
        self.imgView.image = [UIImage imageNamed:@"user_unallocated_ship"];
        self.contentLab.text = [NSString stringWithFormat:@"近期途径数量：%@只船舶",myAreaModel.shipqty?:@""];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end