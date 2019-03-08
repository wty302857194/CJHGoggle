//
//  HYBaseTableViewCell.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@implementation HYBaseTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        
        // Fix the bug in iOS7 - initial constraints warning
        self.contentView.bounds = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self initialize];
    
    return self;
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)initialize {
    
}

- (void)bindWithModel:(id)viewModel {
    
}


@end
