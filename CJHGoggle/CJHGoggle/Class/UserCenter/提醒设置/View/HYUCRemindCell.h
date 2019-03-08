//
//  HYUCRemindCell.h
//  CJHGoggle
//
//  Created by 阿杰 on 2018/8/7.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYRemindModel;
typedef void(^SwitchBlock)(BOOL isOn)
;
@interface HYUCRemindCell : UITableViewCell

@property (nonatomic,copy) SwitchBlock clickAction;

@property (nonatomic,strong) HYRemindModel *remindModel;

-(void)cellSetUp:(NSIndexPath *)indexPath;

@end
