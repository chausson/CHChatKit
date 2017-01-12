//
//  CHLocationService.h
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/19.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class UIImage;
@class UIViewController;
@class CHLocationService;
typedef void(^LocationCompletion)(CHLocationService *info);

@interface CHLocationService : NSObject
@property (nonatomic, assign)CLLocationCoordinate2D coor;
@property (nonatomic, copy)NSString *postionTitle;
@property (nonatomic, copy)NSString *postionContent;
@property (nonatomic, copy)LocationCompletion finish;
@property (nonatomic, weak)UIImage *snapshot;


- (void)fetchLocationInfo:(UIViewController *)controller;
- (void)openLocation:(UIViewController *)controller
                coor:(CLLocationCoordinate2D)coor
        postionTitle:(NSString *)postionTitle
      postionContent:(NSString *)postionContent;
@end
