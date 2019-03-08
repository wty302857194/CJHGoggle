//
//  UIImageView+TYExtension.h
//  CJHLogistics
//
//  Created by wbb on 2017/11/22.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TYExtension)
// 没有占位图片
- (void)setHeaderUrl:(NSString *)url;
// 带有占位图片
- (void)setHeaderUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName;

@end
