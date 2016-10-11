//
//  CHChatAssistanceItem.h
//  CHChatKit
//
//  Created by Chausson on 16/10/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHChatDefinition.h"
#import "XEBEventBus.h"

@class CHChatAssistance;
@protocol CHChatAssistanceProtocol <NSObject>
@required
+ (NSString *)registerAssistance;

@end
@interface CHChatAssistance : NSObject<CHChatAssistanceProtocol>

@property (nonatomic , readonly) NSString *title;
@property (nonatomic , readonly) NSString *picture;
@property (nonatomic , readonly) NSString *identifier;

+ (void)registerSubclass;
/* 事件处理方法，参数是事件响应者 */
- (void)executeEvent:(id )responder;

@end
