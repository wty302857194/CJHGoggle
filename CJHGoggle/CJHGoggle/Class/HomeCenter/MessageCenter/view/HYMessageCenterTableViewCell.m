//
//  HYMessageCenterTableViewCell.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/10.
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

#import "HYMessageCenterTableViewCell.h"
#import "HYMessageCenterModel.h"

@implementation HYMessageCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.messageCenterModel = nil;
    self.imageView.image = nil;
    self.imgView.image = nil;
    self.tagLab.text = nil;
    self.timeLab.text = nil;
    self.contentLab.text = nil;
    self.messageLab.hidden = YES;
}

- (void)setMessageCenterModel:(HYMessageCenterModel *)messageCenterModel {
    
    if (messageCenterModel && [messageCenterModel isKindOfClass:[HYMessageCenterModel class]]) {
        
        _messageCenterModel = messageCenterModel;
        self.tagLab.text = [NSString stringWithFormat:@"【%@】",messageCenterModel.title?:@""];
        self.timeLab.text = messageCenterModel.createDate?:@"";
        self.contentLab.text = messageCenterModel.message?:@"";
        
        if ([messageCenterModel.state integerValue] == 2) {
            //已读
            self.messageLab.hidden = YES;
        }
        else {
            //未读
            self.messageLab.hidden = NO;
        }
        
        NSInteger type = messageCenterModel.type.integerValue;
        
        UIImage *image = nil;
        if (type == 1) {
            // 公告助手
            image = [UIImage imageNamed:@"hyucr_announcement"];
        }
        else if (type == 4) {
            // 流失提醒
            image = [UIImage imageNamed:@"hyucr_loss"];
        }
        else if (type == 5) {
            // 靠泊提醒
            image = [UIImage imageNamed:@"hyucr_anchor"];
        }
        else if (type == 6) {
            // 过客未停提醒
            image = [UIImage imageNamed:@"hyucr_guo"];
        }
        else if (type == 7) {
            // 电子围栏提醒
            image = [UIImage imageNamed:@"hyucr_electronicFence"];
        }
        
        if (image) {
            
            self.imgView.image = [image dp_scaleToSize:CGSizeMake(30, 30)];
        }
    }
    
}


@end
