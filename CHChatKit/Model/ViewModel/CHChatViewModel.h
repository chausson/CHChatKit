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
#import "CHChatModel.h"
@class UIImage;

typedef void(^chatBlock)(CHChatModel* list);
typedef void(^refreshBlock)();


@interface CHChatViewModel : NSObject
- (instancetype)init __unavailable;
- (instancetype)initWithMessageList:(CHChatModel *)list
                      configuration:(CHChatConfiguration *)config;
/** 聊天列表VM*/
@property (nonatomic ,strong ) NSArray <CHChatMessageViewModel *>*cellViewModels;
/** 自己用户图标*/
@property (nonatomic ,copy ) NSString *userIcon;
/** 接收图标*/
@property (nonatomic ,copy ) NSString *receiverIcon;
/** 显示标题*/
@property (nonatomic ,copy ) NSString *chatControllerTitle;
/** UI配置类*/
@property (nonatomic ,readonly ) CHChatConfiguration *configuration;
@property (nonatomic ,readonly ) NSString *refreshName;


@end
