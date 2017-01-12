//
//  RimMapViewController.h
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLocationService.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface CHRimMapViewController : UIViewController
@property (nonatomic, strong)CHLocationService *service;
@end
