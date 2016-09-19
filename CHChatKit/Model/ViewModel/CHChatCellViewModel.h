//
//  CHChatCellViewModel.h
//  CHChatDemo
//
//  Created by Chausson on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CHChatModel.h"
#import <Foundation/Foundation.h>
@class UIImage;
typedef NS_ENUM(NSUInteger, CHChatMessageType) {
    CHMessageText,
    CHMessageImage,
    CHMessageVoice,
    CHMessageVideo,
    CHMessageLocation
};
@interface CHChatCellViewModel : NSObject
@property (nonatomic ,copy) NSString *voicePath;
@property (nonatomic ,copy) NSString *content;
@property (nonatomic ,copy) NSString *icon;
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *image;
@property (nonatomic ,copy) NSString *location;
@property (nonatomic ,weak) UIImage *imageResource;
@property (nonatomic ,assign , getter= isVisableTime) BOOL visableTime;
@property (nonatomic ,assign , getter= isProcessing) BOOL processing;
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
