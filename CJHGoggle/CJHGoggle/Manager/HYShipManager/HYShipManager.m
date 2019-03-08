//
//  HYShipManager.m
//  CJHGoggle
//
//  Created by 耿建峰 on 2018/8/10.
//  Copyright © 2018年 CJH. All rights reserved.
//

#import "HYShipManager.h"

@interface HYShipManager ()

@property (nonatomic, strong) NSDictionary *dictionary_cargoType;

@property (nonatomic, strong) NSDictionary *dictionary_state;

@end

@implementation HYShipManager

+ (instancetype)sharedManager {
    
    static HYShipManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[HYShipManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        self.dictionary_cargoType = @{
                                      @"50" : @"引航船",
                                      @"51" : @"搜救船",
                                      @"52" : @"拖轮",
                                      @"53" : @"港口供应船",
                                      @"54" : @"其他",
                                      @"55" : @"执法艇",
                                      @"56" : @"备用",
                                      @"57" : @"备用",
                                      @"58" : @"医疗船",
                                      @"59" : @"其他",
                                      @"30" : @"捕捞",
                                      @"31" : @"拖引",
                                      @"32" : @"拖引",
                                      @"33" : @"疏浚",
                                      @"34" : @"潜水",
                                      @"35" : @"军用",
                                      @"36" : @"帆船",
                                      @"37" : @"娱乐",
                                      @"20" : @"地效应船",
                                      @"21" : @"地效应船",
                                      @"22" : @"地效应船",
                                      @"23" : @"地效应船",
                                      @"24" : @"地效应船",
                                      @"25" : @"地效应船",
                                      @"26" : @"地效应船",
                                      @"27" : @"地效应船",
                                      @"28" : @"地效应船",
                                      @"29" : @"地效应船",
                                      @"40" : @"高速船",
                                      @"41" : @"高速船",
                                      @"42" : @"高速船",
                                      @"43" : @"高速船",
                                      @"44" : @"高速船",
                                      @"45" : @"高速船",
                                      @"46" : @"高速船",
                                      @"47" : @"高速船",
                                      @"48" : @"高速船",
                                      @"49" : @"高速船",
                                      @"60" : @"客船",
                                      @"61" : @"客船",
                                      @"62" : @"客船",
                                      @"63" : @"客船",
                                      @"64" : @"客船",
                                      @"65" : @"客船",
                                      @"66" : @"客船",
                                      @"67" : @"客船",
                                      @"68" : @"客船",
                                      @"69" : @"客船",
                                      @"70" : @"货船",
                                      @"71" : @"货船",
                                      @"72" : @"货船",
                                      @"73" : @"货船",
                                      @"74" : @"货船",
                                      @"75" : @"货船",
                                      @"76" : @"货船",
                                      @"77" : @"货船",
                                      @"78" : @"货船",
                                      @"79" : @"货船",
                                      @"80" : @"油轮",
                                      @"81" : @"油轮",
                                      @"82" : @"油轮",
                                      @"83" : @"油轮",
                                      @"84" : @"油轮",
                                      @"85" : @"油轮",
                                      @"86" : @"油轮",
                                      @"87" : @"油轮",
                                      @"88" : @"油轮",
                                      @"89" : @"油轮",
                                      @"90" : @"其他",
                                      @"91" : @"其他",
                                      @"92" : @"其他",
                                      @"93" : @"其他",
                                      @"94" : @"其他",
                                      @"95" : @"其他",
                                      @"96" : @"其他",
                                      @"97" : @"其他",
                                      @"98" : @"其他",
                                      @"99" : @"其他",
                                      @"100" : @"集装箱"
                                      };
        
        self.dictionary_state = @{
                                  @"0" : @"在航",
                                  @"1" : @"锚泊",
                                  @"2" : @"失控",
                                  @"3" : @"操纵受限",
                                  @"4" : @"吃水受限",
                                  @"5" : @"靠泊",
                                  @"6" : @"搁浅",
                                  @"7" : @"捕捞作业",
                                  @"8" : @"帆船",
                                  @"9" : @"HSC",
                                  @"10" : @"WIG",
                                  @"11" : @"保留",
                                  @"12" : @"保留",
                                  @"13" : @"保留",
                                  @"14" : @"保留",
                                  };
    }
    
    return self;
}

// 船舶类型中文
- (NSString *)cargoTypeCh:(NSInteger)type {
    
    NSString *key = [NSString stringWithFormat:@"%ld", type];
    NSString *value = [NSString dp_stringWithDictionary:self.dictionary_cargoType key:key];
    return [NSString dp_isEmptyString:value] ? @"未知" : value;
}

// 船舶状态中文
- (NSString *)stateCh:(NSInteger)state {
    
    NSString *key = [NSString stringWithFormat:@"%ld", state];
    NSString *value = [NSString dp_stringWithDictionary:self.dictionary_state key:key];
    return [NSString dp_isEmptyString:value] ? @"未知" : value;
}

@end