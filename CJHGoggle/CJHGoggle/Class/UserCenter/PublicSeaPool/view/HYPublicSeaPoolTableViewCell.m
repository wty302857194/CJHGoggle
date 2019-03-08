//
//  HYPublicSeaPoolTableViewCell.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/8.
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

#import "HYPublicSeaPoolTableViewCell.h"
#import "HYPublicSeaPoolModel.h"

@implementation HYPublicSeaPoolTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
- (void)setPublicSeaPoolModel:(HYPublicSeaPoolModel *)publicSeaPoolModel
{
    NSString *title = ![NSString dp_isEmptyString:publicSeaPoolModel.chname] ? publicSeaPoolModel.chname : (![NSString dp_isEmptyString:publicSeaPoolModel.shipname] ? publicSeaPoolModel.shipname : publicSeaPoolModel.mmsi);
    
    self.shipNameLab.text = [NSString stringWithFormat:@"【%@】", title];
    self.contentLab.text = [NSDate dateWithTimeIntervalSince1970:publicSeaPoolModel.utc.doubleValue / 1000].string;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
