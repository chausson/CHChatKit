//
//  CHChatMessageLocationVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageLocationVM.h"

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
@end
