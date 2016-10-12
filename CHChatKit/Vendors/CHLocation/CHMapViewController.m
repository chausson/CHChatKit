//
//  MapViewController.m
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import "CHMapViewController.h"

@interface CHMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geoCodeSearch;
@property (nonatomic, strong)BMKReverseGeoCodeOption *reverseGeoCodeOption;
@end

@implementation CHMapViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    // Do any additional setup after loading the view.
}
- (void)loadUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    self.geoCodeSearch.delegate = self;
    
    self.reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    
    self.mapView = [[BMKMapView alloc] init];
    self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.mapView.zoomLevel = 17;
    self.mapView.mapType = 1;
    self.mapView.delegate = self;
    BMKCoordinateRegion region;
    region.center = self.service.coor;
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.004;
    span.longitudeDelta = 0.004;
    region.span = span;
    [self.mapView setRegion:region];
    self.reverseGeoCodeOption.reverseGeoPoint = self.service.coor;
    [self.geoCodeSearch reverseGeoCode:self.reverseGeoCodeOption];
    self.view = self.mapView;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 80)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, whiteView.frame.size.width - 20, 40)];
    nameLabel.text = self.service.postionTitle;
    nameLabel.font = [UIFont systemFontOfSize:22];
    [whiteView addSubview:nameLabel];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, whiteView.frame.size.width - 20, 20)];
    addressLabel.text = self.service.postionContent;
    addressLabel.textColor = [UIColor lightGrayColor];
    addressLabel.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:addressLabel];
    
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = self.service.coor;
    annotation.title = result.address;
    [self.mapView addAnnotation:annotation];
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CHLocationService *)service{
    if (!_service) {
        _service = [[CHLocationService alloc]init];
        
    }
    return _service;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
