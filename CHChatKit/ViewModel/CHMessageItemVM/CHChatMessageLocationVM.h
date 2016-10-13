//
//  CHChatMessageLocationVM.h
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageFileVM.h"
#import <CoreLocation/CoreLocation.h>

@class UIImage;

@interface CHChatMessageLocationVM : CHChatMessageFileVM<CHChatMessageViewModelProtocol>
@property (nonatomic ,readonly) double longitude;
@property (nonatomic ,readonly) double latitude;
@property (nonatomic ,readonly) CLLocationCoordinate2D coor;
@property (nonatomic ,readonly) NSString *areaDetail;
@property (nonatomic ,readonly) NSString *areaName;
@property (nonatomic ,readonly) UIImage *snapshot;
@end
