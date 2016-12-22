//
//  CHMessageDatabase.h
//  CHChatKit
//
//  Created by Chausson on 16/12/6.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHChatMessageViewModel.h"
@interface CHMessageDatabase : NSObject
@property (nonatomic , readonly) int userId;

+ (instancetype)new __unavailable;
- (instancetype)init __unavailable;

+ (CHMessageDatabase *)databaseWithUserId:(int )identifier;

- (void)saveMessage:(CHChatMessageViewModel *)viewModel;
- (void)editMessage:(CHChatMessageViewModel *)viewModel;
- (void)deleteMessage:(CHChatMessageViewModel *)viewModel;
/**
 @brief 获取数据接口
 */
- (NSArray <CHChatMessageViewModel *>*)fetchAllMessageWithGroupId:(long long)identifier;
- (NSArray <CHChatMessageViewModel *>*)fetchAllMessageWithReceive:(long long)receiveId;
- (NSArray <CHChatMessageViewModel *>*)fetchIn:(CHChatMessageViewModel *)viewModel
                                       receive:(long long)receiveId
                                         count:(NSInteger )count;
- (NSArray <CHChatMessageViewModel *>*)fetchLastMessage:(NSInteger )count
                                                receive:(long long)receiveId;
- (void)removeAllMessages;
- (void)saveAndUpdateDraft:(NSString *)draft
                   receive:(long long)receiveId
                     group:(long long)groupId;
- (void)deleteDraftWithReceive:(long long)receiveId;
- (NSString *)fetchDraftWithReceive:(long long)receiveId; // 获取草稿信息
- (void)deleteDraftWithGroup:(long long)groupId;
- (NSString *)fetchDraftWithGroup:(long long)groupId;
@end
