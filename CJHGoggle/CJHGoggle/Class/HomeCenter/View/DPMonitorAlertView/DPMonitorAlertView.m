//
//  DPHomeHeaderView.m
//  Direction
//
//  Created by 耿建峰 on 2017/10/15.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "DPMonitorAlertView.h"

@interface DPMonitorAlertView ()

@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIView *view_input_bg;

@property (weak, nonatomic) IBOutlet UITextField *textField_input;

@property (weak, nonatomic) IBOutlet UIButton *button_iscjh;

@property (weak, nonatomic) IBOutlet UILabel *label_cjh;

@end

@implementation DPMonitorAlertView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super initWithCoder:aDecoder]) {
        
        [[NSBundle mainBundle] loadNibNamed:@"DPMonitorAlertView" owner:self options:nil];
        
        [self addSubview:self.view];
        
        [self initialize];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initialize];
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        [[NSBundle mainBundle] loadNibNamed:@"DPMonitorAlertView" owner:self options:nil];
        
        [self addSubview:self.view];
        
        [self initialize];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.view.frame = self.bounds;
}

#pragma mark - PSBaseViewProtocol methed

- (void)initialize {
    
    self.textField_input.delegate = self;
    
    self.view_input_bg.layer.masksToBounds = YES;
    self.view_input_bg.layer.borderColor = hexColor(0xE5E5E5).CGColor;
    self.view_input_bg.layer.borderWidth = 1.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIsCJH:)];
    self.label_cjh.userInteractionEnabled = YES;
    [self.label_cjh addGestureRecognizer:tap];
    
//    UITapGestureRecognizer *tapHiden = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
//    self.view.userInteractionEnabled = YES;
//    [self.view addGestureRecognizer:tapHiden];
}

- (void)bindWithModel:(id)viewModel {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Action method

- (IBAction)selectIsCJH:(id)sender {
    
    self.button_iscjh.selected = !self.button_iscjh.selected;
}

- (IBAction)cancel:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)commit:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(monitorAlertView:title:isCJH:)]) {
        
        [self.delegate monitorAlertView:self title:self.textField_input.text isCJH:self.button_iscjh.selected];
    }
    
    [self removeFromSuperview];
}


@end