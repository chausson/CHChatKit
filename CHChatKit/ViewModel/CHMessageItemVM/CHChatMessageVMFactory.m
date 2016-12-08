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
                                        timeDate:(NSString *)date
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
                                        timeDate:(NSString *)date
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
//    fileVM.category = category;
    return fileVM;
}
+ (CHChatMessageLocationVM *)factoryLoactionOfUserIcon:(NSString *)icon
                                              timeDate:(NSString *)date
                                              nickName:(NSString *)name
                                              areaName:(NSString *)title
                                            areaDetail:(NSString *)detail
                                              resource:(NSString *)path
                                              snapshot:(UIImage *)map
                                              location:(CLLocationCoordinate2D)coor
                                               isOwner:(BOOL)owner{
    CHChatMessageLocationVM *locationVM = [CHChatMessageLocationVM new];
    locationVM.nickName = name;
    locationVM.date = date;
    locationVM.owner = owner;
    locationVM.icon = icon;
    locationVM.filePath = path;
    locationVM.areaDetail = detail;
    locationVM.areaName = title;
    locationVM.snapshot = map;
    locationVM.coor = coor;
    return locationVM;
}
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)icon
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                            size:(CGSize )size
                                  thumbnailImage:(UIImage *)thumbnail
                                       fullImage:(UIImage *)image
                                         isOwner:(BOOL)owner{
    CHChatMessageImageVM *imageVM = [CHChatMessageImageVM new];
    imageVM.nickName = name;
    imageVM.date = date;
    imageVM.owner = owner;
    imageVM.icon = icon;
    imageVM.thumbnailImage = thumbnail;
    imageVM.size = size;
    imageVM.fullImage = image;
    imageVM.filePath = path;
    return imageVM;
}
+ (CHChatMessageVoiceVM *)factoryVoiceOfUserIcon:(NSString *)icon
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        fileName:(NSString *)fileName
                                        resource:(NSString *)path
                                     voiceLength:(NSInteger )length
                                         isOwner:(BOOL)owner{
    CHChatMessageVoiceVM *voiceVM = [CHChatMessageVoiceVM new];
    voiceVM.nickName = name;
    voiceVM.fileName = fileName;
    voiceVM.date = date;
    voiceVM.owner = owner;
    voiceVM.icon = icon;
    voiceVM.length = length;
    voiceVM.filePath = path;
    return voiceVM;
}
@end
