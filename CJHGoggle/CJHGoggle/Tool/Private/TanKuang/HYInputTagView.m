//
//  HYInputTagView.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/6.
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

#import "HYInputTagView.h"
@interface HYInputTagView () {
    NSString *_tfText;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation HYInputTagView

- (void)awakeFromNib {
    [super awakeFromNib];
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
}
- (IBAction)editingChange:(UITextField *)sender {
    _tfText = sender.text;
}

- (IBAction)cancel:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
    self.hidden = YES;
    
    if (self.inputTagBlock) {
        
        self.inputTagBlock(nil);
    }
}

- (IBAction)finish:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
    self.hidden = YES;
    
    if (self.inputTagBlock) {
        
        self.inputTagBlock(_tfText?:@"");
    }
}

@end
