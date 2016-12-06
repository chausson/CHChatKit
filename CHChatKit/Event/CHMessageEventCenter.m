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
#import "CHMessageLocationEvent.h"
#import "CHMessageReceiveEvent.h"
#import "CHChatMessageVMFactory.h"
#import "CHMessageVoiceEvent.h"
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
    }else if ([event isKindOfClass:[CHMessageLocationEvent class]]){
        [self executeLocationEvent:(CHMessageLocationEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessageVoiceEvent class]]){
        [self executeVoiceEvent:(CHMessageVoiceEvent *)event];
        return;
    }
}


- (void)executeTextEvent:(CHMessageTextEvent *)event{
    CHChatMessageTextVM *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeDate:event.date  nickName:nil content:event.text isOwner:YES];
    viewModel.receiveId = event.receiverId;
    [viewModel changeSendingState:CHMessageSending];
    viewModel.senderId = event.userId;
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
 //   viewModel.sendingState = CHMessageSending;
    viewModel.senderId = event.userId;
    [self receiveMessage:viewModel];
    if ([self.delegate respondsToSelector:@selector(executePicture:)]) {
        if (event.isGroup) {
            [self.delegate executePicture:viewModel];
        }else{
            [self.delegate executePicture:viewModel];
        }
    }
}
- (void)executeLocationEvent:(CHMessageLocationEvent *)event{
    CHChatMessageLocationVM *viewModel = [CHChatMessageVMFactory factoryLoactionOfUserIcon:nil timeDate:event.date nickName:nil areaName:event.title areaDetail:event.detail resource:event.file snapshot:event.map location:event.location.coordinate isOwner:YES];
    [self receiveMessage:viewModel];
    if ([self.delegate respondsToSelector:@selector(executeLocation:)]) {
        if (event.isGroup) {
            [self.delegate executeGroupLocation:viewModel];
        }else{
            [self.delegate executeLocation:viewModel];
        }
    }
}
- (void)executeVoiceEvent:(CHMessageVoiceEvent *)event{
    CHChatMessageVoiceVM *viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:nil timeDate:event.date nickName:nil fileName:event.fileName resource:event.file voiceLength:event.length isOwner:YES];
    viewModel.receiveId = event.receiverId;
 //   viewModel.sendingState = CHMessageSending;
    viewModel.senderId = event.userId;
    [self receiveMessage:viewModel];
    if ([self.delegate respondsToSelector:@selector(executeVoice:)]) {
        if (event.isGroup) {
            [self.delegate executeGroupVoice:viewModel];
        }else{
            [self.delegate executeVoice:viewModel];
        }
    }
}
- (void)save:(CHChatMessageTextVM *)viewModel{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSLog(@"realm =%@",realm.configuration.fileURL.absoluteString);
    [realm transactionWithBlock:^{
        [realm addObject:viewModel];
    }];
}
- (void)receiveMessage:(CHChatMessageViewModel *)viewModel{
    CHMessageReceiveEvent *r = [CHMessageReceiveEvent new];
    r.item = viewModel;
    r.receiverId = viewModel.receiveId;
    if([_eventBus hasSubscriberForEventClass:[CHMessageReceiveEvent class]]){
        [_eventBus postEvent:r];
    }

}
- (void)dealloc {
    [_eventBus unregisterSubscriber: self];
}
+ (NSArray<Class>*)handleableEventClasses {
    return @[ [CHMessageTextEvent class],[CHMessagePictureEvent class],[CHMessageLocationEvent class] ,[CHMessageVoiceEvent class]];
}
@end
