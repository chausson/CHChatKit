//
//  CHChatMessageVMFactory.m
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageVMFactory.h"
#import "CHChatMessageViewModel+Protocol.h"
@implementation CHChatMessageVMFactory
+ (CHChatMessageTextVM *)factoryTextVMOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                         content:(NSString *)content
                                         isOwner:(BOOL)owner{
    CHChatMessageTextVM *textVM = [CHChatMessageTextVM new];
    textVM.content = content;
    textVM.nickName = name;
    textVM.date = date;
    textVM.owner = owner;
    textVM.icon = icon;
    return textVM;
}

+ (CHChatMessageFileVM *)factoryFileVMOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        filePath:(NSString *)file
                                         isOwner:(BOOL)owner
                                        category:(CHChatMessageType )category{
    CHChatMessageFileVM *fileVM = [CHChatMessageFileVM new];
    fileVM.filePath = file;
    fileVM.nickName = name;
    fileVM.date = date;
    fileVM.owner = owner;
    fileVM.icon = icon;
    fileVM.category = category;
    return fileVM;
}
@end
