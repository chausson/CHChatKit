//
//  CHChatVIewModel.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CHChatMessageViewModel.h"
#import "CHChatConfiguration.h"
#import <Foundation/Foundation.h>

@class UIImage;



@interface CHChatViewModel : NSObject
- (instancetype)init __unavailable;
- (instancetype)initWithMessageHistroy:(NSArray <CHChatMessageViewModel *>*)histroyMessage
                         configuration:(CHChatConfiguration *)config;
/** 聊天列表VM*/
@property (nonatomic ,strong ) NSArray <CHChatMessageViewModel *>*cellViewModels;
/** 自己用户图标*/
@property (nonatomic ,copy ) NSString *userIcon;
/** 接收图标*/
@property (nonatomic ,copy ) NSString *receiverIcon;

@property (nonatomic ,assign) long long receiveId;
@property (nonatomic ,assign) long long userId;
/** UI配置类*/
@property (nonatomic ,readonly ) CHChatConfiguration *configuration;
@property (nonatomic ,readonly ) NSString *refreshName;
/** 草稿信息*/
@property (nonatomic ,copy ) NSString *draft;

@end
