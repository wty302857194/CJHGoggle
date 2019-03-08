//
//  UIButton+EnlargeEdge.h
//  beiliao
//
//  Created by BeiliaoIOSDev on 14-7-20.
//  Copyright (c) 2014年 wangchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
