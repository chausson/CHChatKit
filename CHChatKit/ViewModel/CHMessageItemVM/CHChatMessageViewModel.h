//
//  CHMessageViewModel.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "CHChatDefinition.h"

@class CHChatMessageViewModel;
@protocol CHChatMessageViewModelProtocol <NSObject>
@required
- (CHChatMessageType )category;
@end
@interface CHChatMessageViewModel : RLMObject<CHChatMessageViewModelProtocol>

@property NSString *icon;
@property NSString *date;
@property NSString *nickName;
@property NSDate *createDate;
@property BOOL visableTime;
@property BOOL owner;
@property BOOL visableNickName;
@property long long receiveId; /* 消息接收人的id 没有的话默认是0 */
@property long long senderId; /* 发送消息者的id 没有的话默认是0 */
@property NSNumber<RLMInt> *sendingState;

- (CHMessageSendState )sendState;
- (void)setSendingStateCallBack:(void(^)())stateChange;
- (void)changeSendingState:(CHMessageSendState )state;

- (void)sortOutWithTime:(NSString *)time;
/* 处理响应事件  */
- (void)respondsTapAction;
/* 重发消息  */
- (void)resend;

@end
