//
//  RimMapCellViewModel.h
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface CHRimMapCellViewModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, assign)BOOL isChoose;
@property (nonatomic, assign)CLLocationCoordinate2D coor;
@end
