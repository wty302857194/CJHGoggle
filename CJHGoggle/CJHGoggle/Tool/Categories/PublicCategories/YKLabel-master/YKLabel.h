//
//  YKLabel.h
//  
//
//  Created by youki on 16/1/14.
//  Copyright © 2016年 youki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YKLabelVerticalAlignmentModel)
{
    YKLabelVerticalAlignmentModelTop,
    YKLabelVerticalAlignmentModelMiddle,
    YKLabelVerticalAlignmentModelBottom,
};


@interface YKLabel : UILabel

@property (assign, nonatomic) YKLabelVerticalAlignmentModel verticalAlignment;
@property (assign, nonatomic) CGFloat lineSpaceing;

@end
