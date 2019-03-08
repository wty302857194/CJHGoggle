//
//  HYHomeCenterViewController.m
//  CJHGoggle
//
//  Created by 吴棒棒 on 2018/8/2.
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

#import "HYHomeCenterViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "DPMonitorAlertView.h"

#import "HYLogInViewController.h"
#import "HYSelectView.h"

typedef NS_ENUM(NSInteger,MapPointEnum)
{
    MapPointNormal,//普通大头针
    MapPointShip,//自定义大头针
};
@interface HYHomeCenterViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKPoiSearchDelegate>{
    BMKMapView *_map_view;
    BOOL canRequest;
    BOOL editing;
//    //定位服务类
//    BMKLocationService *_locService;
//
//    //提供位置搜索服务
//
//    BMKPoiSearch *poi_search;
//    NSMutableArray *_locationArr;
    
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate1;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate2;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate3;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate4;

@property (nonatomic, strong) CLLocation *locMin;
@property (nonatomic, strong) CLLocation *locMax;

@property (nonatomic, assign) MapPointEnum mapPointEnum;

@property (nonatomic, strong) HYSelectView *selectView;
@end

@implementation HYHomeCenterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [_map_view viewWillAppear];
    _map_view.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_map_view viewWillDisappear];
    _map_view.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    
    [self initBaiDuMap];
}
#pragma mark - 地图初始化
- (void)initBaiDuMap {
    _mapPointEnum = MapPointShip;
    
    _map_view = [[BMKMapView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight-kLayoutViewMarginTop-kTableBarHeight)];
    _map_view.delegate = self;
    _map_view.mapType = BMKMapTypeStandard;
    [self.view addSubview:_map_view];
    // 兴隆洲服务区
    BMKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(32.19039724509582, 119.03086213172625);
    region.span.latitudeDelta  = 0.05;
    region.span.longitudeDelta = 0.05;
    _map_view.region = region;
    // 卫星地图
    _map_view.mapType = BMKMapTypeSatellite;
    _map_view.showsUserLocation = YES;
    
    //    //百度地图上添加大头针
    
    BMKPointAnnotation *ann = [[BMKPointAnnotation alloc] init];
    ann.coordinate = CLLocationCoordinate2DMake(32.19039724509582, 119.03086213172625);
    ann.title = @"天安门";
    ann.subtitle = @"我爱北京天安门";
    [_map_view addAnnotation:ann];
    
    // 长按地图新增坐标点
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(threeClicked:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 3;
    [_map_view addGestureRecognizer:tap];
}
#pragma mark - 导航栏初始化
- (void)initNavigationBar {
    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"兴隆洲站" titleColor:hexColor(323232) font:[UIFont systemFontOfSize:15] imageName:@"hy_station_img" target:self action:@selector(chooseStation)];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 20, 10);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
//    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [leftBtn setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:0];
    
    
    UIButton *rightBtn = [UIButton buttonWithTitle:@"消息" titleColor:hexColor(323232) font:[UIFont systemFontOfSize:15] imageName:@"message_center_index" target:self action:@selector(seeMessage)];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 20, 10);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [rightBtn setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:0];
    
    UIImageView *back_imgView = [[UIImageView alloc] init];
    back_imgView.image = [UIImage imageNamed:@"hy_search_backImg"];
    back_imgView.userInteractionEnabled = YES;
    self.navigationItem.titleView = back_imgView;
    [back_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightBtn.mas_left);
        make.left.equalTo(leftBtn.mas_right);
        make.height.mas_equalTo(34);
    }];
    
    UIImageView *searchImg = [[UIImageView alloc] init];
    
    searchImg.image = [UIImage imageNamed:@"hy_search_img"];
    searchImg.userInteractionEnabled = YES;
    [back_imgView addSubview:searchImg];
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back_imgView.mas_left).offset(8);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(searchImg.mas_height);
    }];
    
    UITextField *m_textfieldSearchWords = [[UITextField alloc] init];
    m_textfieldSearchWords.returnKeyType = UIReturnKeySearch;
    m_textfieldSearchWords.clearButtonMode = UITextFieldViewModeWhileEditing;
    m_textfieldSearchWords.placeholder = @"搜索长江汇商品";
    m_textfieldSearchWords.borderStyle = UITextBorderStyleNone;
//    [m_textfieldSearchWords addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [back_imgView addSubview:m_textfieldSearchWords];
    [m_textfieldSearchWords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImg.mas_right).offset(5);
        make.right.equalTo(back_imgView.mas_right).offset(-5);
    }];

    
}
#pragma mark - 初始化弹框

- (void)chooseStation {
    HYLogInViewController *loginVC = [[HYLogInViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (void)seeMessage {
    self.selectView.hidden = NO;
}

- (void)threeClicked:(UIGestureRecognizer *)gestureRecognizer {
    
    _mapPointEnum = MapPointNormal;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        editing = YES;
        
        [_map_view removeAnnotations:_map_view.annotations];
        
        //坐标转换
        CGPoint touchPoint = [gestureRecognizer locationInView:_map_view];
        
        {
            // 第一个点
            CLLocationCoordinate2D coordinate_setting = [_map_view convertPoint:touchPoint toCoordinateFromView:_map_view];
            
            NSString *title = [NSString stringWithFormat:@"%f, %f", coordinate_setting.longitude, coordinate_setting.latitude];
            
            BMKPointAnnotation *pointAnnotation1 = [[BMKPointAnnotation alloc] init];
            pointAnnotation1.coordinate = coordinate_setting;
            pointAnnotation1.title = title;
            
            [_map_view addAnnotation:pointAnnotation1];
        }
        
        {
            CGPoint point = CGPointMake(touchPoint.x + 100, touchPoint.y);
            // 第二个点
            CLLocationCoordinate2D coordinate_setting = [_map_view convertPoint:point toCoordinateFromView:_map_view];
            
            NSString *title = [NSString stringWithFormat:@"%f, %f", coordinate_setting.longitude, coordinate_setting.latitude];
            
            BMKPointAnnotation *pointAnnotation2 = [[BMKPointAnnotation alloc] init];
            pointAnnotation2.coordinate = coordinate_setting;
            pointAnnotation2.title = title;
            
            [_map_view addAnnotation:pointAnnotation2];
        }
        
        {
            CGPoint point = CGPointMake(touchPoint.x, touchPoint.y + 100);
            // 第三个点
            CLLocationCoordinate2D coordinate_setting = [_map_view convertPoint:point toCoordinateFromView:_map_view];
            
            NSString *title = [NSString stringWithFormat:@"%f, %f", coordinate_setting.longitude, coordinate_setting.latitude];
            
            BMKPointAnnotation *pointAnnotation3 = [[BMKPointAnnotation alloc] init];
            pointAnnotation3.coordinate = coordinate_setting;
            pointAnnotation3.title = title;
            
            [_map_view addAnnotation:pointAnnotation3];
        }
        
        {
            CGPoint point = CGPointMake(touchPoint.x + 100, touchPoint.y + 100);
            // 第四个点
            CLLocationCoordinate2D coordinate = [_map_view convertPoint:point toCoordinateFromView:_map_view];
            
            NSString *title = [NSString stringWithFormat:@"%f, %f", coordinate.longitude, coordinate.latitude];
            
            BMKPointAnnotation *pointAnnotation4 = [[BMKPointAnnotation alloc] init];
            pointAnnotation4.coordinate = coordinate;
            pointAnnotation4.title = title;
            
            [_map_view addAnnotation:pointAnnotation4];
        }
        
        _map_view.scrollEnabled = NO;
        
        [self drawRectangleArea];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(commit:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    }
}
- (void)commit:(id)sender {
    
    editing = NO;
    
    _map_view.scrollEnabled = YES;
    
    // 经度（竖）
    CGFloat latitude = _map_view.region.center.latitude;
    // 纬度（横）
    CGFloat longitude = _map_view.region.center.longitude;
    
    CGFloat latitudeDelta = _map_view.region.span.latitudeDelta;
    CGFloat longitudeDelta = _map_view.region.span.longitudeDelta;
    
    CGFloat minLat = latitude - (latitudeDelta / 2.0);
    CGFloat minLng = longitude - (longitudeDelta / 2.0);
    
    CGFloat maxLat = latitude + (latitudeDelta / 2.0);
    CGFloat maxLng = longitude + (longitudeDelta / 2.0);
    
    self.locMin = [[CLLocation alloc] initWithLatitude:minLat longitude:minLng];
    
    self.locMax = [[CLLocation alloc] initWithLatitude:maxLat longitude:maxLng];
    
    double distance = [self.locMin distanceFromLocation:self.locMax];
    
    if (distance > 15000) {
        
//        [DPFoundationCommon promotDialogWithTitle:@"设置" message:@"区域过大，请缩小后再试！"];
        return;
    }
    
    
    BMKPointAnnotation *pointAnnotation1 = _map_view.annotations[0];
    BMKPointAnnotation *pointAnnotation2 = _map_view.annotations[1];
    BMKPointAnnotation *pointAnnotation3 = _map_view.annotations[2];
    BMKPointAnnotation *pointAnnotation4 = _map_view.annotations[3];
    
   _coordinate1 = pointAnnotation1.coordinate;
   _coordinate2 = pointAnnotation2.coordinate;
   _coordinate3 = pointAnnotation3.coordinate;
   _coordinate4 = pointAnnotation4.coordinate;
   
    {
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:_coordinate1.latitude longitude:_coordinate1.longitude];
        
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:_coordinate4.latitude longitude:_coordinate4.longitude];
        
        double distance = [loc1 distanceFromLocation:loc2];
        
        if (distance > 15000) {
            
//            [DPFoundationCommon promotDialogWithTitle:@"设置" message:@"区域过大，请缩小后再试！"];
            return;
        }
    }
    
    // 清除图上所有点
    [_map_view removeAnnotations:_map_view.annotations];
    // 清楚图上覆盖
    [_map_view removeOverlays:_map_view.overlays];
    // 重新设置图上元素
    [self initNavigationBar];
    
    DPMonitorAlertView *alertView = [[DPMonitorAlertView alloc] init];

    alertView.frame = Window_.bounds;

    alertView.delegate = self;

    [Window_ addSubview:alertView];
}

- (void)cancel:(id)sender {
    
    editing = NO;
    
    self.locMin = nil;
    self.locMax = nil;
    
    _map_view.scrollEnabled = YES;
    // 清除图上所有点
    [_map_view removeAnnotations:_map_view.annotations];
    // 清楚图上覆盖
    [_map_view removeOverlays:_map_view.overlays];
    // 重新设置图上元素
    [self initNavigationBar];
}

- (void)drawRectangleArea {
    
    [_map_view removeOverlays:_map_view.overlays];
    
    BMKPointAnnotation *pointAnnotation1 = _map_view.annotations[0];
    BMKPointAnnotation *pointAnnotation2 = _map_view.annotations[1];
    BMKPointAnnotation *pointAnnotation3 = _map_view.annotations[2];
    BMKPointAnnotation *pointAnnotation4 = _map_view.annotations[3];
    
    _coordinate1 = pointAnnotation1.coordinate;
    _coordinate2 = pointAnnotation2.coordinate;
    _coordinate3 = pointAnnotation3.coordinate;
    _coordinate4 = pointAnnotation4.coordinate;
    
    CLLocationCoordinate2D coords[4] = {0};
    coords[0] = _coordinate1;
    coords[1] = _coordinate2;
    coords[2] = _coordinate4;
    coords[3] = _coordinate3;
   
    BMKPolygon *polygon = [BMKPolygon polygonWithCoordinates:coords count:4];
    [_map_view addOverlay:polygon];
}

#pragma mark - method
/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[BMKPolygon class]]){
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor alloc] initWithRed:0.0 green:0 blue:0.5 alpha:1];
        polygonView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:0.2];
        polygonView.lineWidth =2.0;
        polygonView.lineDash = YES;
        return polygonView;
    }
    return nil;
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    NSString *AnnotationViewID = @"annotationViewId";
    
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
    }
    
    if (_mapPointEnum == MapPointNormal) {//普通状态
        annotationView.pinColor = BMKPinAnnotationColorPurple;
    }else {
        //设置大头针图标
        annotationView.image = [UIImage imageNamed:@"hy_bigV_img"];
        
        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        //设置弹出气泡图片
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi"]];
        image.frame = CGRectMake(0, 0, 100, 60);
        [popView addSubview:image];
    }
    
    return annotationView;
}

/**
 *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
 *@param mapView 地图View
 *@param view annotation view
 *@param newState 新状态
 *@param oldState 旧状态
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {
    
    [self drawRectangleArea];
}

// 地图区域即将改变时会调用此接口
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    canRequest = NO;
    
//    if(self.timer_auto && self.timer_auto.isValid) {
//
//        [self.timer_auto invalidate];
//        self.timer_auto = nil;
//    }
}
// 地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if(editing) return;
    
    canRequest = YES;
    
//    [self performSelector:@selector(fetchAreaShips) withObject:nil afterDelay:0.2];
}

#pragma mark - requestData


#pragma mark - Action methods

- (void)gotoShipDetailViewController:(DPShipInfo *)ship {
    
    DPShipDetailViewController *viewController = [[DPShipDetailViewController alloc] init];
    viewController.ship = ship;
    viewController.navigationItem.leftBarButtonItems = [DPFoundationCommon barButtonItemWithTarget:viewController select:@selector(backToLastViewController:) withImage:[UIImage imageNamed:@"common_ico_back"] withRect:DPBarItemRect];
    [self pushNewViewController:viewController];
}


#pragma mark - Properties


- (HYSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[[NSBundle mainBundle] loadNibNamed:@"HYSelectView" owner:nil options:nil] lastObject];
        _selectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _selectView.hidden = YES;
        MJWeakSelf;
        _selectView.selectBlock = ^(NSString *str) {
            weakSelf.selectView.hidden = YES;
        };
        [self.view addSubview:_selectView];
    }
    return _selectView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
