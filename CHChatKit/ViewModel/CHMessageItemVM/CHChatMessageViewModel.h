//
//  CHMessageViewModel.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHChatDefinition.h"
#import "CHChatModel.h"
@class CHChatMessageViewModel;
@protocol CHChatMessageViewModelProtocol <NSObject>
@required
- (CHChatMessageType )category;
@end
@interface CHChatMessageViewModel : NSObject

@property (nonatomic ,copy) NSString *icon;
@property (nonatomic ,readonly) NSString *date;
@property (nonatomic ,readonly) NSString *nickName;
@property (nonatomic ,readonly) CHChatMessageType category;
@property (nonatomic ,readonly , getter= isVisableTime) BOOL visableTime;
@property (nonatomic ,readonly , getter= isRetry) BOOL retry;
@property (nonatomic ,readonly , getter= isOwner) BOOL owner;
@property (nonatomic ,readonly , getter= isVisableNickName) BOOL visableNickName;


- (void)sortOutWithTime:(NSString *)time;
/* 处理响应事件  */
- (void)respondsTapAction;
@end
