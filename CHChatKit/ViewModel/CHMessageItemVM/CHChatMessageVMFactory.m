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
+ (CHChatMessagePacketVM *)factoryPacketOfUserIcon:(NSString *)avatar
                                          timeDate:(NSString *)date
                                          nickName:(NSString *)name
                                          packetId:(NSInteger )identifer
                                          blessing:(NSString *)blessing
                                           isOwner:(BOOL)owner{
    CHChatMessagePacketVM *packet = [CHChatMessagePacketVM new];
    packet.packetIdentifier = identifer;
    packet.avatar = avatar;
    packet.date = date;
    packet.nickName = name;
    packet.blessing = blessing;
    packet.owner = owner;
    return packet;
}
+ (NSArray <CHChatMessageViewModel *>*)testData{
    NSMutableArray <CHChatMessageViewModel *>*viewModels = [NSMutableArray array];
    NSString *userIcon = @"http://p3.music.126.net/36br0Mrxoa38WFBTfqiu3g==/7834020348630828.jpg";
    NSString *receiverIcon = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=5bda8a18a71ea8d38a777c02a73a1c76/5882b2b7d0a20cf4598dc37c77094b36acaf9977.jpg";
    CHChatMessageTextVM *textVM = [self factoryTextOfUserIcon:userIcon timeDate:@"2015年10月12日 14:35" nickName:nil content:@"欢迎来到我们的大家庭！" isOwner:YES];
    CHChatMessageTextVM *textVMO = [self factoryTextOfUserIcon:receiverIcon timeDate:@"2015年10月12日 14:55" nickName:nil content:@"新人报道，多多待见和指教，以后希望有机会多多向前辈们学习学习，下面我先自曝照片，哈哈" isOwner:NO];
    CHChatMessageImageVM *imageVM = [self factoryImageOfUserIcon:receiverIcon timeDate:@"2015年10月12日 15:05" nickName:nil resource:@"http://p3.music.126.net/36br0Mrxoa38WFBTfqiu3g==/7834020348630828.jpg" size:CGSizeZero thumbnailImage:nil fullImage:nil isOwner:NO];
    CHChatMessagePacketVM *packetVM = [self factoryPacketOfUserIcon:receiverIcon timeDate:@"2015年10月12日 16:05" nickName:nil packetId:10001 blessing:@"新人红包，嘿嘿" isOwner:NO];
    
    
    [viewModels addObject:textVM];
    [viewModels addObject:textVMO];
    [viewModels addObject:imageVM];
    [viewModels addObject:packetVM];

    return [viewModels copy];
}
@end
