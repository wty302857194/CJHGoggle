//
//  HYBaseViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/1.
//  Copyright © 2018年 CJH. All rights reserved.
//
/**
 *　　　　　　　 ┏┓       ┏┓+ +
 *　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　 ┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 █████━█████  ┃+
 *　　　　　　　┃　　　　　　 ┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　 ┃ + +
 *　　　　　　　┗━━┓　　　 ┏━┛
 *               ┃　　  ┃
 *　　　　　　　　　┃　　  ┃ + + + +
 *　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　 ┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
 *　　　　　　　　　 ┃┫┫　 ┃┫┫
 *　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +
 */

#import "HYBaseViewController.h"
#import "UIButton+ImageTitleStyle.h"

@interface HYBaseViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

@end

@implementation HYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self isEqual:self.navigationController.childViewControllers[0]]) {
        
    }else {
        GO_BACK;
    }
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            tableView.emptyDataSetSource = self;
            tableView.emptyDataSetDelegate = self;
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        }
    }
}

- (void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)keyboardManagerEnabled {
    
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 默认开启键盘管理
    if([self keyboardManagerEnabled]) {
        
        self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
        self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
        
        self.returnKeyHandler.delegate = self;
    }
    else {
        
        if(self.returnKeyHandler) {
            
            self.returnKeyHandler.delegate = nil;
        }
        self.returnKeyHandler = nil;
    }
    
    [IQKeyboardManager sharedManager].enable = [self keyboardManagerEnabled];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignKeyBoard];
}


- (NSMutableArray *)addNavigationItemWithImageNames:(NSArray *)imageNames titles:(NSArray *)titles textClolr:(UIColor *)textColor isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags{
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSMutableArray *buttonArray = [NSMutableArray new];
    
    
    if (!imageNames || (imageNames.count <=0) || !titles ||(titles.count <=0) || imageNames.count != titles.count) {
        
        [Global promptMessage:@"请输入正确的Image和title信息" inView:self.view];
        return items;
    }
    
   
    
    [imageNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0,0,40,44)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonView addSubview:btn];
        btn.frame = CGRectMake(0, 0, 40, 44);
        btn.tag = [tags[idx] integerValue];
        [btn setImage:[UIImage imageNamed:imageNames[idx]] forState:UIControlStateNormal];
        [btn setTitle:titles[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:3];

        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        [items addObject:[[UIBarButtonItem alloc] initWithCustomView:buttonView]];
        
    }];

    if (isLeft) {
        
        self.navigationItem.leftBarButtonItems = items;
        
    }else{
        
       self.navigationItem.rightBarButtonItems = items;
    }
    
    
    return buttonArray;
}

- (UILabel *)createLabelWithTextAligment:(NSTextAlignment)aligment font:(UIFont *)font textClolr:(UIColor *)textColor andText:(NSString *)text {
    
    UILabel *label = [[UILabel alloc] init] ;
    label.textAlignment = aligment ;
    label.font = font ;
    label.textColor = textColor;
    label.text  =  text;
    return label;
    
}


- (void)pushNewViewController:(UIViewController *)viewController {
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)backToLastViewController:(Class)viewControllerClass {
    
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^{
        STRONGSELF
        
        // 返回之前将键盘隐藏
        [strongSelf resignKeyBoard];
        
        NSArray *array = [strongSelf.navigationController viewControllers];
        
        if(array && [array count] > 1) {
            
            UIViewController *viewController = nil;
            
            if(viewControllerClass) {
                
                for (UIViewController *vc in array) {
                    
                    if([vc isKindOfClass:viewControllerClass]) {
                        viewController = vc;
                        break;
                    }
                }
            }
            
            if(viewController) {
                [strongSelf.navigationController popToViewController:viewController animated:YES];
            }
            else {
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    });
}

- (void)dismissViewController {
    
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^{
        
        double delayInSeconds = 0.2;
        
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        
        dispatch_after(delay, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (![weakSelf.presentedViewController isBeingDismissed]) {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
            });
        });
    });
}

- (void)resignKeyBoard {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view endEditing:YES];
        
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    });
}

#pragma mark - 视图为空
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"hy_emptyImg"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
// 向上偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -150;
}


- (void)dealloc {
    
    // 关闭键盘管理
    if(self.returnKeyHandler) {
        
        self.returnKeyHandler.delegate = nil;
    }
    self.returnKeyHandler = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
