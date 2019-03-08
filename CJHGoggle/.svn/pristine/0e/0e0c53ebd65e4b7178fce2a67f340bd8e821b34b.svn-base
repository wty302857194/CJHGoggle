//
//  UIImage+DPUtil.h
//  CJHCompetitors
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DPUtil)

// 创建一个指定颜色的image对象
+ (UIImage *)dp_imageWithColor:(UIColor *)color;
+ (UIImage *)dp_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

- (UIImage *)dp_scaleToSize:(CGSize)size;
- (UIImage *)dp_scaleToFullSize:(CGSize)size;

// 生成二维码图片
+ (UIImage *)dp_generateQRCode:(NSString *)code size:(CGSize)size;

/**
 *  return 旋转后的图片
 *  @param image              原始图片    （必传，不可空）
 *  @param orientation        旋转方向    （必传，不可空）
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

+ (UIImage *)dp_rotateImageWithAngle:(UIImage*)vImg Angle:(CGFloat)vAngle IsExpand:(BOOL)vIsExpand;

@end
