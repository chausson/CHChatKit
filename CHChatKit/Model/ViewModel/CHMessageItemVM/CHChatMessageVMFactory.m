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
+ (CHChatMessageTextVM *)factoryTextOfUserIcon:(NSString *)icon
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

+ (CHChatMessageFileVM *)factoryFileOfUserIcon:(NSString *)icon
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
+ (CHChatMessageLocationVM *)factoryLoactionOfUserIcon:(NSString *)icon
                                              timeData:(NSString *)date
                                              nickName:(NSString *)name
                                              areaName:(NSString *)title
                                            areaDetail:(NSString *)detail
                                              resource:(NSString *)path
                                             longitude:(float )lon
                                              latitude:(float )lat
                                               isOwner:(BOOL)owner{
    CHChatMessageLocationVM *locationVM = [CHChatMessageLocationVM new];
    locationVM.nickName = name;
    locationVM.date = date;
    locationVM.owner = owner;
    locationVM.icon = icon;
    locationVM.longitude = lon;
    locationVM.latitude = lat;
    locationVM.filePath = path;
    locationVM.areaDetail = detail;
    locationVM.areaName = title;
    return locationVM;
}
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                            size:(float )size
                                           width:(float )aWidth
                                          height:(BOOL)aHeight
                                         isOwner:(BOOL)owner{
    CHChatMessageImageVM *locationVM = [CHChatMessageImageVM new];
    locationVM.nickName = name;
    locationVM.date = date;
    locationVM.owner = owner;
    locationVM.icon = icon;
    locationVM.size = size;
    locationVM.width = aWidth;
    locationVM.filePath = path;
    locationVM.height = aHeight;
    return locationVM;
}

@end
