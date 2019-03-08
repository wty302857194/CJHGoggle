//
//  HYMoorShipListViewController.h
//  CJHGoggle
//


#import "HYBaseTableViewController.h"

typedef NS_ENUM(NSInteger, MOORSHIPTYPE) {
    
    MOORSHIPTYPE_CJH_MOOR = 0,  // 长江汇站点靠泊
    MOORSHIPTYPE_MOOR,          // 友商站点靠泊
};

typedef NS_ENUM(NSInteger, MOORQUERYTYPE) {
    
    MOORQUERYTYPE_TOTAL = 0,  // 靠泊总数
    MOORQUERYTYPE_V,          // 靠泊大V
    MOORQUERYTYPE_P,          // 池中靠泊船舶
};

@interface HYMoorShipListViewController : HYBaseTableViewController

// 区域船舶列表类型
@property (nonatomic, assign) MOORSHIPTYPE moor_type;

@property (nonatomic, assign) MOORQUERYTYPE query_type;

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) NSString *startdate;

@property (nonatomic, copy) NSString *enddate;

@end
