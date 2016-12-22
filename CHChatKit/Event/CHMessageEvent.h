//
//  CHMessageEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/9/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHMessageEvent : NSObject

@property (copy ,nonatomic ) NSString *eventName;
@property (copy ,nonatomic ) NSString *timestamp;
@property (copy ,nonatomic ) NSString *date;
@property (assign ,nonatomic ) long long receiverId;
@property (assign ,nonatomic ) long long userId;
@property (assign ,nonatomic ) long long groupId;

@property (assign ,nonatomic ,getter=isGroup) BOOL group; // 群聊
@property (weak ,nonatomic ) id handler; // 作为保留字段

@end
