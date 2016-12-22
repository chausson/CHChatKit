//
//  CHLocationAssistance.m
//  CHChatKit
//
//  Created by Chausson on 16/10/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHLocationAssistance.h"
#import "CHMessageLocationEvent.h"
#import <CoreLocation/CoreLocation.h>
#import "CHLocationService.h"

@interface CHLocationAssistance()

@property(nonatomic,strong)CHLocationService*  service;

@end

@implementation CHLocationAssistance

+ (NSString *)registerAssistance{
    return CHLocationAssistanceIdentifer;
}

+ (void)load{
    [self registerSubclass];
}
- (NSString *)title{
    return @"位置";
}
- (NSString *)picture{
    return @"sharemore_loc";
}
- (void)executeEvent:(id )responder{
    self.service = [[CHLocationService alloc] init];
    __weak typeof(self) weakSelf = self;
    self.service.finish = ^(CHLocationService *info){
        //        NSLog(@"%@", info.postionContent);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CHMessageLocationEvent *event = [CHMessageLocationEvent new];
        event.title = info.postionTitle;
        event.receiverId = strongSelf.receiveId;
        event.userId = strongSelf.userId;
        event.groupId = strongSelf.groupId;
        event.map = info.snapshot;
        event.detail = info.postionContent;
        event.location = [[CLLocation alloc]initWithLatitude:info.coor.latitude longitude:info.coor.longitude];
        [[XEBEventBus defaultEventBus] postEvent:event];
    };
    [self.service fetchLocationInfo:responder];
}

@end
