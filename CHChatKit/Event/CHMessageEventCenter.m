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
#import "CHEMChatAccountEvent.h"
#import "CHEMChatInstallEvent.h"
#import <EMSDK.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CHMessageEventCenter ()<XEBSubscriber,EMChatManagerDelegate>

@end
@implementation CHMessageEventCenter{
    XEBEventBus* _eventBus;
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
    }else if ([event isKindOfClass:[CHEMChatInstallEvent class]]){
        [self executeEMChatInstallEvent:(CHEMChatInstallEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHEMChatAccountEvent class]]){
        [self executeEMChatAccountEvent:(CHEMChatAccountEvent *)event];
        return;
    }
}
- (void)executeEMChatAccountEvent:(CHEMChatAccountEvent *)event{
    if (!event.isLogout) {
        [[EMClient sharedClient] loginWithUsername:event.userName password:event.password completion:^(NSString *aUsername, EMError *aError) {
            if (aError == nil) {
                [[EMClient sharedClient].chatManager removeDelegate:self];
                [[EMClient sharedClient].chatManager addDelegate:self];
            }
        }];
    }else{
        [[EMClient sharedClient] logout:YES];
    }
}
- (void)executeEMChatInstallEvent:(CHEMChatInstallEvent *)event{
    EMOptions *options = [EMOptions optionsWithAppkey:event.appKey];
    options.apnsCertName = event.apnsCertName;
    [[EMClient sharedClient]initializeSDKWithOptions:options];
    
}
- (void)executeTextEvent:(CHMessageTextEvent *)event{

    CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeData:event.date  nickName:nil content:event.text isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)executePictureEvent:(CHMessagePictureEvent *)event{
  
    CHChatMessageImageVM *viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:nil timeData:event.date nickName:nil resource:event.file thumbnailImage:nil fullImage:event.fullPicture  isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)executeLocationEvent:(CHMessageLocationEvent *)event{
    CHChatMessageLocationVM *viewModel = [CHChatMessageVMFactory factoryLoactionOfUserIcon:nil timeDate:event.date nickName:nil areaName:event.title areaDetail:event.detail resource:event.file longitude:event.location.coordinate.longitude latitude:event.location.coordinate.latitude isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)executeVoiceEvent:(CHMessageVoiceEvent *)event{
    CHChatMessageVoiceVM *viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:nil timeData:event.date nickName:nil resource:event.file voiceLength:event.length isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)postReceiveEvent:(CHChatMessageViewModel *)viewModel{
    CHMessageReceiveEvent *r = [CHMessageReceiveEvent new];
    r.item = viewModel;
    [_eventBus postEvent:r];
}
- (void)messagesDidReceive:(NSArray *)aMessages{
    [aMessages enumerateObjectsUsingBlock:^(EMMessage *msg, NSUInteger idx, BOOL *  stop) {
        switch (msg.body.type) {
            case EMMessageBodyTypeText:{
                EMTextMessageBody *body = (EMTextMessageBody *)msg.body;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"HH:mm";
                NSTimeInterval interval = msg.timestamp/1000.0f;
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
                CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeData:[formatter stringFromDate:date]  nickName:nil content:body.text isOwner:YES];
                [self postReceiveEvent:viewModel];
            }break;
                
            default:
                
                break;
        }
    }];
}
- (void)dealloc {
    [_eventBus unregisterSubscriber: self];
}
+ (NSArray<Class>*)handleableEventClasses {
    return @[[CHEMChatInstallEvent class],[CHEMChatAccountEvent class], [CHMessageTextEvent class],[CHMessagePictureEvent class],[CHMessageLocationEvent class] ,[CHMessageVoiceEvent class]];
}
@end
