//
//  CHMessageLocationEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/10/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
@class CLLocation;
@interface CHMessageLocationEvent : CHMessageEvent

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *file;


@end
