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

+ (CHChatMessageTextVM *)factoryTextOfUserIcon:(NSString *)avatar
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                         content:(NSString *)content
                                         isOwner:(BOOL)owner{
    CHChatMessageTextVM *textVM = [CHChatMessageTextVM new];
    textVM.content = content;
    textVM.nickName = name;
    textVM.date = date;
    textVM.owner = owner;
    textVM.avatar = avatar;
    return textVM;
}

+ (CHChatMessageFileVM *)factoryFileOfUserIcon:(NSString *)avatar
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
    fileVM.avatar = avatar;
//    fileVM.category = category;
    return fileVM;
}
+ (CHChatMessageLocationVM *)factoryLoactionOfUserIcon:(NSString *)avatar
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
    locationVM.avatar = avatar;
    locationVM.filePath = path;
    locationVM.areaDetail = detail;
    locationVM.areaName = title;
    locationVM.snapshot = map;
    locationVM.coor = coor;
    return locationVM;
}
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)avatar
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
    imageVM.avatar = avatar;
    imageVM.thumbnailImage = thumbnail;
    imageVM.size = size;
    imageVM.fullImage = image;
    imageVM.filePath = path;
    return imageVM;
}
+ (CHChatMessageVoiceVM *)factoryVoiceOfUserIcon:(NSString *)avatar
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
    voiceVM.avatar = avatar;
    voiceVM.length = length;
    voiceVM.filePath = path;
    return voiceVM;
}
@end
