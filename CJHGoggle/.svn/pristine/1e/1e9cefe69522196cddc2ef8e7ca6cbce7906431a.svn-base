//
//  UIImage+TYExtension.m
//  CJHLogistics
//
//  Created by wbb on 2017/11/22.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "UIImage+TYExtension.h"

@implementation UIImage (TYExtension)

- (instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImage:(NSString *)image
{
    return [[self imageNamed:image] circleImage];
}

@end
