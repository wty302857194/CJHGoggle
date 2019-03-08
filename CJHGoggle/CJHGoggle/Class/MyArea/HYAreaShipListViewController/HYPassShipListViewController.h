//
//  HYAreaShipListViewController.h
//  CJHGoggle
//


#import "HYBaseTableViewController.h"

typedef NS_ENUM(NSInteger, PASSSHIPTYPE) {
    
    PASSSHIPTYPE_CJH_PASS = 0,  // 长江汇站点途径
    PASSSHIPTYPE_ENCLOSURE,     // 电子围栏途径
};

typedef NS_ENUM(NSInteger, PASSQUERYTYPE) {
    
    PASSQUERYTYPE_TOTAL = 0,  // 途径总数
    PASSQUERYTYPE_UPPER,      // 途径上水
    PASSQUERYTYPE_DOWN,       // 途径下水
    PASSQUERYTYPE_V,          // 途径大V
    PASSQUERYTYPE_P,          // 途径池中船舶
};

@interface HYPassShipListViewController : HYBaseTableViewController

// 区域船舶列表类型
@property (nonatomic, assign) PASSSHIPTYPE pass_type;

@property (nonatomic, assign) PASSQUERYTYPE query_type;

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) NSString *startdate;

@property (nonatomic, copy) NSString *enddate;

@end
