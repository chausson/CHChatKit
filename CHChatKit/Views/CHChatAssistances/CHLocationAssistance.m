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
    CHMessageLocationEvent *event = [CHMessageLocationEvent new];
    
    [[XEBEventBus defaultEventBus] postEvent:event];
}

@end
