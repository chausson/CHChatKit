//
//  CHLocationAssistance.m
//  CHChatKit
//
//  Created by Chausson on 16/10/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHLocationAssistance.h"
#import <CoreLocation/CoreLocation.h>
#import "CHLocationService.h"

@interface CHLocationAssistance()

@property(nonatomic,strong)CHLocationService*  service;

@end

@implementation CHLocationAssistance
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
        strongSelf.postionTitle = info.postionTitle;
        strongSelf.snapshot = info.snapshot;
        strongSelf.postionDetail = info.postionContent;
        strongSelf.latitude = (double)info.coor.latitude;
        strongSelf.longitude =  (double)info.coor.longitude;
        [strongSelf postEvent];
    };
    [self.service fetchLocationInfo:responder];
}

@end
