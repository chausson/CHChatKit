//
//  CHChatDefinition.h
//  CHChatKit
//
//  Created by Chausson on 16/9/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#pragma mark Private

#define KCHChatColorExchange(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <Foundation/Foundation.h>


static NSString *const CHChatCellOwnerIdentifier = @"OwnerIdentifier";
static NSString *const CHChatCellOthersIdentifier = @"OthersIdentifier";

static NSString *const CHLocationAssistanceIdentifer = @"CHLocationIdentifier";// 位置
static NSString *const CHPictureAssistanceIdentifer = @"CHPictureIdentifer"; // 图片
static NSString *const CHPickPhotoAssistanceIdentifer = @"CHPickPhotoIdentifer";// 照片机

FOUNDATION_EXTERN NSMutableDictionary <NSString *,Class>const* ChatCellMessageCatagory ;
FOUNDATION_EXTERN NSMutableDictionary <NSString *,Class>const* AssistanceDic ;
#pragma mark ENUM
/**
 *  消息类型
 */
typedef NS_ENUM(NSUInteger, CHChatMessageType) {
    CHMessageNone,
    CHMessageText,
    CHMessageImage,
    CHMessageVoice,
    CHMessageVideo,
    CHMessageLocation,
    CHMessageSystem,
};
/**
 *  聊天的模式
 */
typedef NS_ENUM(NSUInteger, CHChatConversationType) {
    CHChatSingle,         //单聊
    CHChatGrounp     //群聊
} ;

/**
 *  添加辅助功能的类型
 */
//typedef NS_ENUM(NSUInteger, CHAssistanceType) {
//    CHNoneAssistance,
//    CHPhotoAssistance,  // 图片
//    CHCaremaAssistance, // 照片机
//    CHLocationAssistance
//} ;
/**
 *  消息发送的状态
 */
typedef NS_ENUM(NSUInteger, CHMessageSendState){
    CHMessageSendNone = 0,
    CHMessageSending = 1, // 发送中
    CHMessageSendSuccess, // 发送成功
    CHMessageSendReciver, // 已送达
    CHMessageSendFailure, // 发送失败
};
/**
 *  录音状态
 */
typedef NS_ENUM(NSUInteger, CHVoicePlayState){
    CHVoicePlayNormal,// 正常
    CHVoicePlaying,// 正在播放
    CHVoiceFinish,// 正在播放
    CHVoicePlayCancel,// 取消
};

