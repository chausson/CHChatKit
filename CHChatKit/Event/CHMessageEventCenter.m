//
//  CHMessageEventCenter.m
//  CHChatKit
//
//  Created by Chausson on 16/9/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEventCenter.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"
#import "CHMessageEvent.h"
#import "CHMessageTextEvent.h"
#import "CHMessagePictureEvent.h"
#import "CHMessageReceiveEvent.h"
#import "CHChatMessageVMFactory.h"
#import "CHMessageVoiceEvent.h"
#import "CHMessageAssistanceEvent.h"
#import "CHMessagePacketEvent.h"
#import "CHChatMessageViewModel+Protocol.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CHMessageEventCenter ()<XEBSubscriber>

@end
@implementation CHMessageEventCenter{
    XEBEventBus* _eventBus;
    NSString *_host;
}
+ (void)load{
    [CHMessageEventCenter shareInstance] ->_eventBus = [XEBEventBus defaultEventBus];
    [[CHMessageEventCenter shareInstance] ->_eventBus registerSubscriber: [CHMessageEventCenter shareInstance]];
    
}
+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
- (void)onEvent: (CHMessageEvent *)event{
    if ([event isKindOfClass:[CHMessageTextEvent class]]) {
        [self executeTextEvent:(CHMessageTextEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessagePictureEvent class]]){
        [self executePictureEvent:(CHMessagePictureEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessageVoiceEvent class]]){
        [self executeVoiceEvent:(CHMessageVoiceEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessageAssistanceEvent class]]){
        [self executeAssistanceEvent:(CHMessageAssistanceEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessagePacketEvent class]]){
        [self executePacket:(CHMessagePacketEvent *)event];
        return;
    }
}


- (void)executeTextEvent:(CHMessageTextEvent *)event{
    CHChatMessageTextVM *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeDate:event.date  nickName:nil content:event.text isOwner:YES];
    viewModel.receiveId = event.receiverId;
    viewModel.sendingState = CHMessageSending;
    viewModel.senderId = event.userId;
    viewModel.groupId = event.groupId;
    [self receiveMessage:viewModel];

    if ([self.delegate respondsToSelector:@selector(executeText:)]) {
        if (event.isGroup) {
            [self.delegate executeGroupText:viewModel];
        }else{
            [self.delegate executeText:viewModel];
        }

    }
}
- (void)executePictureEvent:(CHMessagePictureEvent *)event{
    CHChatMessageImageVM *viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:nil timeDate:event.date nickName:nil resource:event.fullLocalPath size:event.fullPicture.size thumbnailImage:event.thumbnailPicture fullImage:event.fullPicture isOwner:YES];
    viewModel.receiveId = event.receiverId;
    viewModel.sendingState = CHMessageSending;
    viewModel.senderId = event.userId;
    viewModel.groupId = event.groupId;
    [self receiveMessage:viewModel];
    if ([self.delegate respondsToSelector:@selector(executePicture:)]) {
        if (event.isGroup) {
            [self.delegate executeGroupPicture:viewModel];
        }else{
            [self.delegate executePicture:viewModel];
        }
    }
}

- (void)executeVoiceEvent:(CHMessageVoiceEvent *)event{
    CHChatMessageVoiceVM *viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:nil timeDate:event.date nickName:nil fileName:event.fileName resource:event.file voiceLength:event.length isOwner:YES];
    viewModel.receiveId = event.receiverId;
    viewModel.sendingState = CHMessageSending;
    viewModel.senderId = event.userId;
    viewModel.groupId = event.groupId;
    [self receiveMessage:viewModel];
    if ([self.delegate respondsToSelector:@selector(executeVoice:)]) {
        if (event.isGroup) {
            [self.delegate executeGroupVoice:viewModel];
        }else{
            [self.delegate executeVoice:viewModel];
        }
    }
}
- (void)executePacket:(CHMessagePacketEvent *)event{
    if ([self.delegate respondsToSelector:@selector(executePacket:)]) {

        [self.delegate executePacket:event.packetViewModel];
    }
}
- (void)executeAssistanceEvent:(CHMessageAssistanceEvent *)event{
    if ([self.delegate respondsToSelector:@selector(executeAssistance:)]) {
        CHChatMessageViewModel *viewModel;
        if (event.isGroup) {
            viewModel = [self.delegate executeAssistance:event.item];
        }else{
            viewModel = [self.delegate executeGroupAssistance:event.item];
        }
        [self receiveMessage:viewModel];
    }else{
        NSLog(@"插件事件需要在EventCenter的代理里面实现");
    }
}
- (void)receiveMessage:(CHChatMessageViewModel *)viewModel{
    CHMessageReceiveEvent *r = [CHMessageReceiveEvent new];
    r.item = viewModel;

    if([_eventBus hasSubscriberForEventClass:[CHMessageReceiveEvent class]]){
        [_eventBus postEvent:r];
    }

}
- (void)dealloc {
    [_eventBus unregisterSubscriber: self];
}
+ (NSArray<Class>*)handleableEventClasses {
    return @[ [CHMessageTextEvent class],[CHMessagePictureEvent class],[CHMessageVoiceEvent class],[CHMessageAssistanceEvent class],[CHMessagePacketEvent class]];
}
@end
