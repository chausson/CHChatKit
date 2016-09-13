//
//  CHChatVIewModel.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CHChatCellViewModel.h"
#import <Foundation/Foundation.h>
#import "CHChatModel.h"
@class UIImage;

typedef void(^chatBlock)(CHChatModel* list);
typedef void(^refreshBlock)();


@interface CHChatViewModel : NSObject
- (instancetype)init __unavailable;
- (instancetype)initWithMessageList:(CHChatModel *)list;
/** 聊天列表VM*/
@property (nonatomic ,strong ) NSArray <CHChatCellViewModel *>*cellViewModels;
/** 自己用户图标*/
@property (nonatomic ,copy ) NSString *userIcon;
/** 接收图标*/
@property (nonatomic ,copy ) NSString *receiverIcon;
/** 显示标题*/
@property (nonatomic ,copy ) NSString *chatControllerTitle;

@property (nonatomic ,readonly ) NSString *refreshName;

- (void)postMessage:(NSString *)text;
- (void)postVoice:(NSString *)path;
- (void)postImage:(UIImage *)image;
- (void)refreshMessage:(NSString*)myID :(refreshBlock)refreshBlock;

@end
