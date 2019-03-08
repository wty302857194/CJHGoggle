//
//  UISearchBar+Util.m
//  CJHCompetitors
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "UISearchBar+Util.h"

@implementation UISearchBar (Util)

- (void)setIsSupportNullSearch:(BOOL)isSupportNullSearch {
    
    if([self isSupportNullSearch] != isSupportNullSearch) {
        
        [self supportNullSearch:isSupportNullSearch];
    }
    
    objc_setAssociatedObject(self, @selector(isSupportNullSearch), [NSNumber numberWithBool:isSupportNullSearch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSupportNullSearch {
    
    NSNumber *isSupportNullSearch = objc_getAssociatedObject(self, @selector(isSupportNullSearch));
    return isSupportNullSearch ? [isSupportNullSearch boolValue] : NO;
}

// 支持空搜索
- (void)supportNullSearch:(BOOL)enable {
    
    // 支持空搜索
    NSArray *views = [HYUtil dp_deepSubViews:self];
    
    for (UIView *subview in views) {
        
        if([subview isKindOfClass:NSClassFromString(@"UITextField")] || [subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            
            UITextField *textField = (UITextField *)subview;
            
            textField.enablesReturnKeyAutomatically = !enable;
            
            break;
        }
    }
}

- (void)setTextFieldBackgroundColor:(UIColor *)color {
    
    [self updateTextFieldBackgroundColor:color];
    
    objc_setAssociatedObject(self, @selector(textFieldBackgroundColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)textFieldBackgroundColor {
    
    UIColor *color = objc_getAssociatedObject(self, @selector(textFieldBackgroundColor));
    return color;
}

- (void)updateTextFieldBackgroundColor:(UIColor *)color {
    
    NSArray *views = [HYUtil dp_deepSubViews:self];
    
    for (UIView *subview in views) {
        
        if([subview isKindOfClass:NSClassFromString(@"UITextField")] || [subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            
            UITextField *textField = (UITextField *)subview;
            
            textField.backgroundColor = color;
            
            textField.layer.masksToBounds = YES;
            
            textField.layer.cornerRadius = 5;
            
            WEAKSELF
            [textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo(weakSelf);
            }];
        }
        else if([subview isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
            
            subview.backgroundColor = color;
            subview.hidden = YES;
        }
        else if([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            
            subview.hidden = YES;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
