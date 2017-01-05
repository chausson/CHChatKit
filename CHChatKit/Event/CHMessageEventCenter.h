//
//  CHMessageEventCenter.h
//  CHChatKit
//
//  Created by Chausson on 16/9/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHMessageTextEvent.h"
#import "CHMessageVoiceEvent.h"
#import "CHMessagePictureEvent.h"
#import "CHChatMessageViewModel.h"
@class CHMessageEventCenter;
@class CHChatMessageTextVM;
@class CHChatMessageImageVM;
@class CHChatMessageLocationVM;
@class CHChatMessageVoiceVM;
@class CHChatMessagePacketVM;
@class CHChatAssistance;

@protocol CHMessageInstallHandler <NSObject>

- (void)install;
- (void)login;

@end
@protocol CHMessageEventProtocl <NSObject>
@optional
- (void)executeText:(CHChatMessageTextVM *)viewModel;
- (void)executePicture:(CHChatMessageImageVM *)viewModel;
- (void)executeVoice:(CHChatMessageVoiceVM *)viewModel;
// 发送群聊
- (void)executeGroupText:(CHChatMessageTextVM *)viewModel;
- (void)executeGroupPicture:(CHChatMessageImageVM *)viewModel;
- (void)executeGroupVoice:(CHChatMessageVoiceVM *)viewModel;

- (void)executePacket:(CHChatMessagePacketVM *)viewModel;

// 接收插件事件
- (CHChatMessageViewModel *)executeAssistance:(CHChatAssistance *)assistance;
- (CHChatMessageViewModel *)executeGroupAssistance:(CHChatAssistance *)assistance;


@end

@interface CHMessageEventCenter : NSObject
/**
    处理事件的代理对象
 */
@property (weak ,nonatomic) id <CHMessageEventProtocl> delegate;

+ (instancetype)shareInstance;
- (void)receiveMessage:(CHChatMessageViewModel *)viewModel;// 接收消息
@end
