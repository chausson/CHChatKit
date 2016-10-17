//
//  CHNoticeEventHandler.h
//  CHChatKit
//
//  Created by Chausson on 16/10/13.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XEBSubscriber.h"


@interface CHNoticeEventHandler<EventType> : NSObject
@property(nonatomic) Class eventClass;
@property(nonatomic, copy) void (^handleBlock)(EventType event);
@property(nonatomic, assign) BOOL autoUnregisterHandler; // defult is YES
- (void)registerHandler;
- (void)unregisterHandler;

@end
