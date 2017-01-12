//
//  CHLocationService.m
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/19.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import "CHLocationService.h"
#import "CHMapViewController.h"
#import "CHRimMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
static CHLocationService *service = nil;
@interface CHLocationService()<BMKGeneralDelegate>
@end

@implementation CHLocationService
+ (void)initialize{
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    service = [[CHLocationService alloc]init];
    
    BOOL ret = [mapManager start:@"sX5CDLsb7eO8LTuP9nN7xiTgLThznYur"  generalDelegate:service];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
- (instancetype)init
{
    if (service) {
        return service;
    }
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)onGetNetworkState:(int)iError{
    if (0 == iError) {
        NSLog(@"Map联网成功");
    }
    else{
        NSLog(@"Map联网失败，错误代码：Error\(%d)",iError);
    }
}
- (void)onGetPermissionState:(int)iError{
    if (0 == iError) {
        NSLog(@"Map授权成功");
    }
    else{
        NSLog(@"Map授权失败，错误代码：Error\(%d)",iError);
    }
}
- (void)fetchLocationInfo:(UIViewController *)controller{
    CHRimMapViewController *map = [[CHRimMapViewController alloc] init];
    map.service = self;
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller pushViewController:map animated:YES];
    }else{
        [controller.navigationController pushViewController:map animated:YES];
    }
    
}
- (void)openLocation:(UIViewController *)controller
                coor:(CLLocationCoordinate2D)coor
        postionTitle:(NSString *)postionTitle
      postionContent:(NSString *)postionContent
{
    CHMapViewController *map = [[CHMapViewController alloc] init];
    map.service.coor = coor;
    map.service.postionTitle = postionTitle;
    map.service.postionContent = postionContent;
    
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller pushViewController:map animated:YES];
    }else{
        [controller.navigationController pushViewController:map animated:YES];
    }
}

@end
