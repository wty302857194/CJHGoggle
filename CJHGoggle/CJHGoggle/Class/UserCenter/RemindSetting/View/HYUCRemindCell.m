//
//  HYUCRemindCell.m
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/7.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYUCRemindCell.h"
#import "HYRemindModel.h"

@interface HYUCRemindCell()

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UISwitch *mainSwitch;

@property (nonatomic,strong) UIView *lineView;

@end
@implementation HYUCRemindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRemindModel:(HYRemindModel *)remindModel
{
    _remindModel = remindModel;
    
    self.titleLabel.text = remindModel.remark?:@"";
    
    self.mainSwitch.on = [remindModel.status boolValue];
    
}
-(void)cellSetUp:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            [self.iconImageView setImage:[UIImage imageNamed:@"hyucr_announcement"]];
            self.titleLabel.text = @"公告信息";
            
        }
            break;
        case 1:
        {
            
            [self.iconImageView setImage:[UIImage imageNamed:@"hyucr_loss"]];
            self.titleLabel.text = @"流失提醒";
            
        }
            break;
        case 2:
        {
            
            [self.iconImageView setImage:[UIImage imageNamed:@"hyucr_anchor"]];
            self.titleLabel.text = @"靠泊提醒";
            
        }
            break;
        case 3:
        {
            
            [self.iconImageView setImage:[UIImage imageNamed:@"hyucr_electronicFence"]];
            self.titleLabel.text = @"电子围栏提醒";
            
        }
            break;
        case 4:
        {
            
            [self.iconImageView setImage:[UIImage imageNamed:@"hyucr_guo"]];
            self.titleLabel.text = @"过客未停提醒";
            
        }
            break;
        default:
            break;
    }
    
    self.lineView.backgroundColor = [UIColor colorWithHexColorString:@"f4f5f6"];

}


-(UIImageView *)iconImageView
{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_iconImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:25].active = true;
        [_iconImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0].active = true;
        [_iconImageView.widthAnchor constraintEqualToConstant:26].active = true;
        [_iconImageView.heightAnchor constraintEqualToConstant:26].active = true;

    }
    
    return _iconImageView;
    
}

-(UILabel *)titleLabel
{

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.tintColor = [UIColor colorWithHexColorString:@"323232"];
        [self.contentView addSubview:_titleLabel];

        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_titleLabel.leftAnchor constraintEqualToAnchor:self.iconImageView.rightAnchor constant:20].active = true;
        [_titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0].active = true;
        [_titleLabel.widthAnchor constraintEqualToConstant:150].active = true;
        [_titleLabel.heightAnchor constraintEqualToConstant:23].active = true;
        
    }

    return _titleLabel;

}

-(UISwitch *)mainSwitch
{
    
    if (!_mainSwitch) {
        
        _mainSwitch = [[UISwitch alloc] init];
//        _mainSwitch.tintColor = [UIColor colorWithHexColorString:@"25bb99"];
        [_mainSwitch addTarget:self action:@selector(swichChange:) forControlEvents:UIControlEventValueChanged];
        
        [self.contentView addSubview:_mainSwitch];
        
        _mainSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        [_mainSwitch.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-25].active = true;
        [_mainSwitch.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0].active = true;

        
    }
    
    return _mainSwitch;
    
}

-(UIView *)lineView
{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];

        [self.contentView addSubview:_lineView];
        
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
        [_lineView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0].active = true;
        [_lineView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-1].active = true;
        [_lineView.widthAnchor constraintEqualToConstant:kScreenWidth].active = true;
        [_lineView.heightAnchor constraintEqualToConstant:1].active = true;
        
    }
    
    return _lineView;
    
}

-(void)swichChange:(UISwitch *)sender
{
    self.clickAction ? self.clickAction(sender.on) : nil;
}

@end

