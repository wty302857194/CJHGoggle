//
//  ListSelectView.m
//  cjh
//
//  Created by wbb on 16/10/31.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import "ListSelectView.h"

@interface ListSelectView()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat kSingleTitleHeight;
    CGFloat kSingleBtnHeight;
}
@property (strong, nonatomic) UIView *selectView;
@property (assign, nonatomic) CGFloat collectionViewHeight;
@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) BOOL isAnimated;
@property (nonatomic, copy)   NSString *title_str;
@property (strong, nonatomic)UIButton *topCancelButton;
@property (strong, nonatomic)UITableView *table_view;
@property (strong, nonatomic)UIButton *cancelButton;
@property (strong, nonatomic)UIButton *okButton;
@property (strong, nonatomic)UILabel *verticalline;
@property (strong, nonatomic)UILabel *horizontal2;
//@property (strong, nonatomic)YKLabel *tilteLabel;
//@property (copy,   nonatomic) dismissViewWithButton completionBlock;
//@property (copy,   nonatomic) SureButtonBlock sureButtonBlock;
@end
@implementation ListSelectView
- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc]init];
        _selectView.backgroundColor = [UIColor whiteColor];
        _selectView.layer.cornerRadius = 10;
        _selectView.layer.shadowColor = [UIColor grayColor].CGColor;
        _selectView.layer.shadowOffset = CGSizeMake(10, 10);
        _selectView.layer.shadowOpacity = 0.5;
        _selectView.layer.shadowRadius = 5;
        [self addSubview:_selectView];
    }
    return _selectView;
}
/**
 标题Label
 */
- (YKLabel *)tilteLabel {
    if (!_tilteLabel) {
        _tilteLabel = [[YKLabel alloc]init];
        _tilteLabel.verticalAlignment = YKLabelVerticalAlignmentModelBottom;
//        _tilteLabel.font = [UIFont systemFontOfSize:17.f];
        _tilteLabel.textAlignment = NSTextAlignmentCenter;
        [self.selectView addSubview:_tilteLabel];
    }
    return _tilteLabel;
}
/**
 横线
 */

//-(UILabel *)horizontal1 {
//    if (!_horizontal1) {
//        _horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0 , tilteLabel.frame.size.height-1, self.selectView.frame.size.width, 0.5)];
//        _horizontal1.hidden = _isShowTitle?NO:YES;
//        _horizontal1.backgroundColor = [UIColor grayColor];
//        [tilteLabel addSubview:_horizontal1];
//    }
//    return _horizontal1;
//}

/**
 取消Button
 */
- (UIButton *)topCancelButton {
    if (!_topCancelButton) {
        _topCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topCancelButton setBackgroundImage:[UIImage imageNamed:@"canle_pay_password"] forState:UIControlStateNormal];
        _topCancelButton.frame = CGRectMake(self.selectView.width-25, _title_height+5, 20, 20);
        [_topCancelButton addTarget:self action:@selector(topCancelButtonAction) forControlEvents:UIControlEventTouchDown];
        [self.selectView addSubview:_topCancelButton];
        [self.selectView bringSubviewToFront:_topCancelButton];

    }
    return _topCancelButton;
}

/**
 *  注册tableview
 */
- (UITableView *)table_view {
    if (!_table_view) {
        _table_view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table_view.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table_view.backgroundColor = [UIColor whiteColor];
        _table_view.delegate = self;
        _table_view.dataSource = self;
        [self.selectView addSubview:_table_view];
    }
    return _table_view;
}
/**
 注册contentLabel
 */
- (YKLabel *)lab_content {
    if (!_lab_content) {
        _lab_content = [[YKLabel alloc] init];
        _lab_content.numberOfLines = 0;
        [self.selectView addSubview:_lab_content];
    }
    return _lab_content;
}
/**
 取消Button
 */
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchDown];
        [self.selectView addSubview:_cancelButton];
    }
    return _cancelButton;
}
/**
 确定Button
 */
- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_okButton addTarget:self action:@selector(okButtonAction) forControlEvents:UIControlEventTouchDown];
        [self.selectView addSubview:_okButton];
    }
    return _okButton;
}
/**
 竖线
 */
- (UILabel *)verticalline {
    if (!_verticalline) {
        _verticalline = [[UILabel alloc]init];
        _verticalline.backgroundColor = hexColor(f1f0e8);
        [self.selectView addSubview:_verticalline];
    }
    return _verticalline;
}
/**
 横线
 */
- (UILabel *)horizontal2 {
    if (!_horizontal2) {
        _horizontal2 = [[UILabel alloc]init];
        _horizontal2.backgroundColor = hexColor(f1f0e8);
        [self.selectView addSubview:_horizontal2];
    }
    return _horizontal2;
}
- (instancetype _Nonnull)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}
- (void)addTitleArray:(NSArray<NSString *> * __nullable)titleArray andTitleString:(NSString *__nullable)titleStr animated:(BOOL)animated completionHandler:(dismissViewWithButton __nullable)completionHandler withSureButtonBlock:(SureButtonBlock __nullable)sureButtonBlock {
    
    self.titleArray = titleArray;
    self.isAnimated = animated;
    self.completionBlock = completionHandler;
    self.sureButtonBlock = sureButtonBlock;
    self.title_str = titleStr;
    
//    if (!_isShowTitle) {
//        kSingleTitleHeight = 0.f;
//    }else{
//        kSingleTitleHeight = _title_height;
//    }
    if (_isShowSureBtn||_isShowCancelBtn) {
        kSingleBtnHeight = 50;
    }else {
        kSingleBtnHeight = 0;
    }
    [self setupHeight];
    
    [self initSelectView];
    
    if (self.isAnimated) {
        [self addPopAnimation];
    }
    
}
#pragma mark - setup methods

- (void)setupHeight {
    
    if(_choose_type == MORECHOOSETITLETYPE){
        self.collectionViewHeight = self.titleArray.count * kSingleSelectCellHeight;
    }else if (_choose_type == ONLYTEXTTYPE) {
        if (self.content_text.length>0) {
            self.collectionViewHeight = [Global heightForText:self.content_text textFont:_contentTextFount==0? kSingleContentTextFount:_contentTextFount standardWidth:kScreenWidth-80]+(_content_height==0?40:_content_height);
        }
        if (self.attributedStr.length>0) {
            
            self.collectionViewHeight = [Global heightForText:[self.attributedStr string] textFont:_contentTextFount==0? kSingleContentTextFount:_contentTextFount standardWidth:kScreenWidth-80]+(_content_height==0?40:_content_height);//这里后期优化      
        }
    }
    
    if (self.collectionViewHeight + 200 > kScreenHeight) {
        self.collectionViewHeight = kScreenHeight-200;
    }
}

- (void)initSelectView {
    
    if (_proportion_count==0) {
        _proportion_count = 2/3.f;
    }
    self.selectView.frame = CGRectMake(15, ((kScreenHeight-(self.collectionViewHeight+101))/2)*_proportion_count, kScreenWidth-30, self.collectionViewHeight+_title_height+kSingleBtnHeight+1);
    /**
     标题Label
     */
    self.tilteLabel.frame = CGRectMake(0, 0, self.selectView.frame.size.width, _title_height);
    self.tilteLabel.hidden = _isShowTitle?NO:YES;;
    self.tilteLabel.text = _title_str;//@"请选择适合的选项";
    self.tilteLabel.textColor = _title_color?:hexColor(323232);
    self.tilteLabel.font = [UIFont systemFontOfSize:_title_font!=0?_title_font:17];
    /**
     横线
     */
    //    UILabel *horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0 , tilteLabel.frame.size.height-1, self.selectView.frame.size.width, 0.5)];
    //    horizontal1.hidden = _isShowTitle?NO:YES;
    //    horizontal1.backgroundColor = [UIColor grayColor];
    //    [tilteLabel addSubview:horizontal1];
    
    if(_choose_type == MORECHOOSETITLETYPE) {
        /**
         *  注册tableview
         */
        self.table_view.frame = CGRectMake(0, _title_height, self.selectView.frame.size.width, self.collectionViewHeight);
    }else {
        /**
         注册contentLabel
         */
        self.lab_content.frame = CGRectMake(_content_width==0?20:_content_width, _title_height, self.selectView.frame.size.width-(_content_width==0?40:_content_width*2), self.collectionViewHeight);
        self.lab_content.font = [UIFont systemFontOfSize:_contentTextFount==0? kSingleContentTextFount:_contentTextFount];
        self.lab_content.textColor = _content_text_color?:hexColor(323232);
        if (self.content_text.length>0) {
            self.lab_content.text = self.content_text;
        }
        if (self.attributedStr.length>0) {
            self.lab_content.attributedText = self.attributedStr;
            
        }
    }
    
    self.topCancelButton.hidden = !_isShowTopCancelBtn;

    /**
     取消Button
     */
    
    self.cancelButton.frame = CGRectMake(0, self.selectView.frame.size.height-50,_isShowSureBtn&&_isShowCancelBtn?self.selectView.frame.size.width/2-1: self.selectView.frame.size.width, kSingleBtnHeight);
    [self.cancelButton setTitle:_cancelBtn_title?:@"取 消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:_cancelBtn_title_color?:hexColor(323232) forState:UIControlStateNormal];
    self.cancelButton.hidden = _isShowCancelBtn?NO:YES;
    
    /**
     确定Button
     */
    self.okButton.frame = CGRectMake(_isShowSureBtn&&_isShowCancelBtn?self.selectView.frame.size.width/2+1:0, self.selectView.frame.size.height-50, _isShowSureBtn&&_isShowCancelBtn?self.selectView.frame.size.width/2-1: self.selectView.frame.size.width, kSingleBtnHeight);
    self.okButton.hidden = _isShowSureBtn?NO:YES;
    [self.okButton setTitle:_sureBtn_title?:@"确 定" forState:UIControlStateNormal];
    [self.okButton setTitleColor:_sureBtn_title_color?:hexColor(323232) forState:UIControlStateNormal];
    
    /**
     竖线
     */
    self.verticalline.frame = CGRectMake(self.cancelButton.frame.size.width, self.cancelButton.frame.origin.y, 0.5, self.cancelButton.frame.size.height);
    self.verticalline.hidden = _isShowCancelBtn&&_isShowSureBtn?NO:YES;
    /**
     横线
     */
    self.horizontal2.frame = CGRectMake(0 , self.cancelButton.frame.origin.y-1, self.selectView.frame.size.width, 0.5);
    self.horizontal2.hidden = _isShowCancelBtn||_isShowSureBtn?NO:YES;
    
    
}

#pragma mark listViewdataSource method and delegate method
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"listviewid";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellid];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = self.titleArray[indexPath.row];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:18.f];
        [cell.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.mas_centerX);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSingleSelectCellHeight;
}
//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UILabel *lab in cell.contentView.subviews) {
        if (self.completionBlock) {
            self.completionBlock(lab.text,indexPath.row);
        }
    }
    [self removeFromSuperview];
}

#pragma make - Action
- (void)topCancelButtonAction {
    [self removeFromSuperview];
}
- (void)cancelButtonAction {
    [self removeFromSuperview];
    if (self.cancelButtonBlock) {
        self.cancelButtonBlock();
    }
}
- (void)okButtonAction {
    if (self.sureButtonBlock) {
        self.sureButtonBlock();
    }
    [self removeFromSuperview];
}
#pragma make - Animation

- (void)addPopAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithDouble:0.f];
    animation.toValue   = [NSNumber numberWithDouble:1.f];
    animation.duration  = .25f;
    animation.fillMode  = kCAFillModeBackwards;
    [self.layer addAnimation:animation forKey:nil];
}
@end
