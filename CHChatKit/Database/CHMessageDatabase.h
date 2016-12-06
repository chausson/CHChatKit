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
+ (CHMessageDatabase *)databaseWithName:(NSString *)name;

- (void)saveMessage:(CHChatMessageViewModel *)viewModel;
- (void)editMessage:(CHChatMessageViewModel *)viewModel;
- (void)deleteMessage:(CHChatMessageViewModel *)viewModel;
- (NSArray <CHChatMessageViewModel *>*)fetchAllMessageWithUser:(long long)userId
                                                       receive:(long long)receiveId;
- (NSArray <CHChatMessageViewModel *>*)fetchIn:(CHChatMessageViewModel *)viewModel
                                          user:(long long)userId
                                       receive:(long long)receiveId
                                         count:(NSInteger )count;
- (NSArray <CHChatMessageViewModel *>*)fetchLastMessage:(NSInteger )count
                                                   user:(long long)userId
                                                receive:(long long)receiveId;

- (void)removeAll;

@end
