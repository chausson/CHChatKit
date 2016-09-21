//
//  CHChatCellViewModel.h
//  CHChatDemo
//
//  Created by Chausson on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CHChatModel.h"
#import "CHChatDefinition.h"
#import <Foundation/Foundation.h>
@class UIImage;

@interface CHChatCellViewModel : NSObject
/* 如果有http代表访问远程不是的话则是本地路径.
 */
@property (nonatomic ,copy) NSString *voice;
@property (nonatomic ,copy) NSString *image;

@property (nonatomic ,copy) NSString *content;
@property (nonatomic ,copy) NSString *icon;
@property (nonatomic ,copy) NSString *date;
@property (nonatomic ,copy) NSString *nickName;
@property (nonatomic ,copy) NSString *location;
@property (nonatomic ,strong)UIImage* imageResource;
@property (nonatomic ,assign , getter= isVisableTime) BOOL visableTime;
@property (nonatomic ,assign , getter= isProcessing) BOOL processing;
@property (nonatomic ,assign , getter= isOwner) BOOL owner;
@property (nonatomic ,assign , getter= isVisableLeftDirection) BOOL visableLeftDirection;
@property (nonatomic ,assign) CHChatMessageType type;

- (instancetype)initWithModel:(CHChatViewItemModel *)model;
/**
 * @brief 时间分组规则
 */
- (void)sortOutWithTime:(NSString *)time;
/**
 * @brief 播放声音
 */
- (void)respondsUserTap;
@end
