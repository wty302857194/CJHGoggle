//
//  TagView.h
//  CustomTag
//
//  Created by za4tech on 2017/12/15.
//  Copyright © 2017年 Junior. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TagsViewHeight) (NSInteger height);
@protocol TagViewDelegate <NSObject>

@optional

-(void)handleSelectTag:(NSString *)keyWord;

@end
@interface TagView : UIView
@property (nonatomic ,weak)id <TagViewDelegate>delegate;

@property (nonatomic, copy) TagsViewHeight tagsViewHeight;
@property (nonatomic ,copy)NSArray * arr;
@end
