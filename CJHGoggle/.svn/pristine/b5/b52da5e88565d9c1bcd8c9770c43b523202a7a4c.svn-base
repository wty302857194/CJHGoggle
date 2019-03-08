//
//  UIImageView+TYExtension.m
//  CJHLogistics
//
//  Created by wbb on 2017/11/22.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "UIImageView+TYExtension.h"

@implementation UIImageView (TYExtension)
- (void)setHeaderUrl:(NSString *)url
{
    [self setCircleHeaderUrl:url];
}

- (void)setCircleHeaderUrl:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image circleImage];
    }];
}
- (void)setHeaderUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image circleImage];
    }];
    
}

@end
