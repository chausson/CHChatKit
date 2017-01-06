//
//  CHChatMessageLocationVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageLocationVM.h"
#import <UIKit/UIKit.h>
@implementation CHChatMessageLocationVM
- (CHChatMessageType )category{
    return CHMessageLocation;
}
- (void)setAreaName:(NSString *)areaName{
    _areaName = areaName;
}
- (void)setLatitude:(float)latitude{
    _latitude = latitude;
}
- (void)setLongitude:(float)longitude{
    _longitude = longitude;
}
- (void)setAreaDetail:(NSString *)areaDetail{
    _areaDetail = areaDetail;
}
- (void)setSnapshot:(UIImage *)snapshot{
    _snapshot = snapshot;
}
- (void)setCoor:(CLLocationCoordinate2D)coor{
    _coor = coor;
}
- (void)respondsTapAction{
//    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [[CHLocationService new] openLocation:controller coor:_coor postionTitle:_areaName postionContent:_areaDetail];
}

@end
