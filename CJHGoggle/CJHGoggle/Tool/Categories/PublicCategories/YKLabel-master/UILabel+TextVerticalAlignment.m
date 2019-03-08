//
//  UILabel+TextVerticalAlignment.m
//  FunctionalTest
//
//  Created by user_lzz on 16/11/24.
//  Copyright © 2016年 user_lzz. All rights reserved.
//

#import "UILabel+TextVerticalAlignment.h"

@implementation UILabel (TextVerticalAlignment)

// 垂直居上、中、下
- (void)setTextVerticalAlignment:(MYLabelVerticalAlignmentModel)verticalAlignment
{
    CGRect currentTextRect = [self textRectForBounds:self.frame limitedToNumberOfLines:self.numberOfLines];
    switch (verticalAlignment) {
        case MYLabelVerticalAlignmentModelTop:{
            currentTextRect.origin.y = self.frame.origin.y;
            break;
        }
        case MYLabelVerticalAlignmentModelMiddle:{
            currentTextRect.origin.y = self.frame.origin.y + (self.frame.size.height - currentTextRect.size.height)/2.0;
            break;
        }
        case MYLabelVerticalAlignmentModelBottom:{
            currentTextRect.origin.y = self.frame.origin.y+self.frame.size.height - currentTextRect.size.height;
            break;
        }
        default:
            break;
    }
    self.frame = currentTextRect;

}

// 设置lab 的行间距
- (void)setTextLineSpaceing:(CGFloat)lineSpace
{
    if ([self.text length]>0) {
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.text];
        
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:lineSpace];
        
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.text length])];
        [self setAttributedText:attributedString1];
    }else {
        NSLog(@"text 为空不设置");
    }
}

@end
