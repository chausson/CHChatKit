//
//  RimMapViewController.m
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import "CHRimMapViewController.h"
#import "ChRimMapViewModel.h"
#import "CHRimMapTableViewCell.h"

@interface CHRimMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geoCodeSearch;
@property (nonatomic, strong)BMKReverseGeoCodeOption *reverseGeoCodeOption;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CHRimMapViewModel *viewModel;
@property (nonatomic, strong)BMKPointAnnotation* annotation;
@property (nonatomic, strong)UIImageView* imageV;

@end

@implementation CHRimMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[CHRimMapViewModel alloc] init];
    [self loadUI];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.geoCodeSearch.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
    self.geoCodeSearch.delegate = nil;
}
- (void)loadUI{
    self.title = self.viewModel.title;
    self.view.backgroundColor = [UIColor whiteColor];
    self.geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    
    self.reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    
    self.annotation = [[BMKPointAnnotation alloc] init];
    
    self.locService = [[BMKLocationService alloc] init];
   // self.locService.delegate = self;
    [self.locService startUserLocationService];
    //先关闭显示的定位图层
    self.mapView.showsUserLocation = false;
    //设置定位的状态
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    //显示定位图层
    self.mapView.showsUserLocation = true;
    
    self.mapView = [[BMKMapView alloc] init];
    if (self.navigationController.navigationBar.translucent) {
        self.mapView.frame = CGRectMake(0, 64, self.view.frame.size.width, 250);
    }else{
        self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
    }
    self.mapView.zoomLevel = 17;
    self.mapView.mapType = 1;
    [self.view addSubview:self.mapView];
//    
//    self.mapView.delegate = self;
//    self.geoCodeSearch.delegate = self;
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.mapView.frame.size.width / 2 - 15, self.mapView.frame.size.height / 2 - 30, 30, 30)];
    self.imageV.image = [UIImage imageNamed:@"serach_Map"];
    [self.mapView addSubview:self.imageV];


    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mapView.frame.origin.y + self.mapView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.mapView.frame.origin.y - self.mapView.frame.size.height) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:(UIBarButtonItemStyleDone) target:self action:@selector(sendAction)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CLLocationCoordinate2D mapCoordinate = [self.mapView convertPoint:self.imageV.center toCoordinateFromView:self.mapView];
        self.reverseGeoCodeOption.reverseGeoPoint = mapCoordinate;
        [self.geoCodeSearch reverseGeoCode:self.reverseGeoCodeOption];
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.viewModel.cellViewModle.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    CHRimMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[CHRimMapTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellStr];
    }
    [cell loadCellViewModel:[self.viewModel.cellViewModle objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < self.viewModel.cellViewModle.count; i ++) {
        CHRimMapCellViewModel *model = [self.viewModel.cellViewModle objectAtIndex:i];
        model.isChoose = NO;
        if (i == indexPath.row) {
            model.isChoose = YES;
        }
    }
    self.viewModel.isClick = YES;
    BMKCoordinateRegion region;
    region.center = [self.viewModel.cellViewModle objectAtIndex:indexPath.row].coor;
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.004;
    span.longitudeDelta = 0.004;
    region.span = span;
    [self.mapView setRegion:region];

    [self.tableView reloadData];
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (!self.viewModel.isClick) {
        [self.viewModel.cellViewModle removeAllObjects];
        for (int i = 0; i < result.poiList.count; i ++) {
            BMKPoiInfo *info = [result.poiList objectAtIndex:i];
            CHRimMapCellViewModel *cellModle = [[CHRimMapCellViewModel alloc] init];
            cellModle.name = info.name;
            cellModle.address = info.address;
            cellModle.coor = info.pt;
            if (i == 0) {
                cellModle.isChoose = YES;
            }
            [self.viewModel.cellViewModle addObject:cellModle];
        }
        [self.tableView reloadData];
    }
    self.viewModel.isClick = NO;

}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D mapCoordinate = [mapView convertPoint:self.imageV.center toCoordinateFromView:self.mapView];
    self.reverseGeoCodeOption.reverseGeoPoint = mapCoordinate;
    [self.geoCodeSearch reverseGeoCode:self.reverseGeoCodeOption];
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    self.mapView.showsUserLocation = true;
    [self.mapView updateLocationData:userLocation];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"%@", userLocation.location);
    self.mapView.showsUserLocation = true;
    [self.locService stopUserLocationService];
    [self.mapView updateLocationData:userLocation];
    [self.mapView setCenterCoordinate:userLocation.location.coordinate];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)sendAction{
    self.mapView.showsUserLocation = false;
    //开启图形上下文
    CGFloat sclae = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0.0);
    [[UIApplication sharedApplication].keyWindow drawViewHierarchyInRect:self.view.frame afterScreenUpdates:true];
    UIImage *ima =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    int width = self.view.frame.size.width/4*3;
    ima = [[UIImage alloc] initWithCGImage:CGImageCreateWithImageInRect(ima.CGImage, CGRectMake((self.view.frame.size.width / 2 - width / 2) * sclae, (64 + self.mapView.frame.size.height / 2) *sclae, width * sclae, 80 *sclae))];
    self.service.snapshot = ima;
    for (CHRimMapCellViewModel *model in self.viewModel.cellViewModle) {
        if (model.isChoose) {
            self.service.coor = model.coor;
            self.service.postionTitle = model.name;
            self.service.postionContent = model.address;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    if (self.service.finish ) {
        self.service.finish(self.service);
    }
    
}
- (void)dealloc{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
