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
@property (nonatomic , readwrite) NSString *identifier;
@property (nonatomic , assign) long long receiveId;
@property (nonatomic , assign) long long userId;
@property (nonatomic , assign) long long groupId;
@property (assign ,nonatomic ,getter=isGroup) BOOL group; // 群聊
+ (void)registerSubclass;
/* 事件处理方法，参数是事件响应者 */
- (void)executeEvent:(id )responder;

@end
