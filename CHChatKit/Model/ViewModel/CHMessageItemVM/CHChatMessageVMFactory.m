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
                                              timeDate:(NSString *)date
                                              nickName:(NSString *)name
                                              areaName:(NSString *)title
                                            areaDetail:(NSString *)detail
                                              resource:(NSString *)path
                                              snapshot:(UIImage *)map
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
    locationVM.snapshot = map;
    return locationVM;
}
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                  thumbnailImage:(UIImage *)thumbnail
                                       fullImage:(UIImage *)full
                                         isOwner:(BOOL)owner{
    CHChatMessageImageVM *imageVM = [CHChatMessageImageVM new];
    imageVM.nickName = name;
    imageVM.thumbnailImage = thumbnail;
    imageVM.fullImage = full;
    imageVM.date = date;
    imageVM.owner = owner;
    imageVM.icon = icon;
    imageVM.filePath = path;
    return imageVM;
}
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                       fullImage:(UIImage *)image
                                         isOwner:(BOOL)owner{
    CHChatMessageImageVM *imageVM = [CHChatMessageImageVM new];
    imageVM.nickName = name;
    imageVM.date = date;
    imageVM.owner = owner;
    imageVM.icon = icon;
    imageVM.fullImage = image;
    imageVM.filePath = path;
    return imageVM;
}
+ (CHChatMessageVoiceVM *)factoryVoiceOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                     voiceLength:(NSInteger )length
                                         isOwner:(BOOL)owner{
    CHChatMessageVoiceVM *voiceVM = [CHChatMessageVoiceVM new];
    voiceVM.nickName = name;
    voiceVM.date = date;
    voiceVM.owner = owner;
    voiceVM.icon = icon;
    voiceVM.length = length;
    voiceVM.filePath = path;
    return voiceVM;
}
@end
