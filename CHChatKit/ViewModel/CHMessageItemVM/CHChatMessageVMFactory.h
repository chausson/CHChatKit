//
//  CHChatMessageVMFactory.h
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHChatMessageFileVM.h"
#import "CHChatMessageTextVM.h"
#import "CHChatMessageImageVM.h"
#import "CHChatMessageLocationVM.h"
#import "CHChatMessageVoiceVM.h"
#import "CHChatMessagePacketVM.h"
#import "CHChatDefinition.h"
#import "CHChatMessageHTMLVM.h"

@interface CHChatMessageVMFactory : NSObject

+ (CHChatMessageTextVM *)factoryTextOfUserIcon:(NSString *)avatar
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                         content:(NSString *)content
                                         isOwner:(BOOL)owner;

+ (CHChatMessageFileVM *)factoryFileOfUserIcon:(NSString *)avatar
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        filePath:(NSString *)file
                                         isOwner:(BOOL)owner
                                        category:(CHChatMessageType )category;

+ (CHChatMessageLocationVM *)factoryLoactionOfUserIcon:(NSString *)avatar
                                              timeDate:(NSString *)date
                                              nickName:(NSString *)name
                                              areaName:(NSString *)title
                                            areaDetail:(NSString *)detail
                                              resource:(NSString *)path
                                              snapshot:(UIImage *)map
                                              location:(CLLocationCoordinate2D)coor
                                               isOwner:(BOOL)owner;
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)avatar
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                            size:(CGSize )size
                                  thumbnailImage:(UIImage *)thumbnail
                                       fullImage:(UIImage *)image
                                         isOwner:(BOOL)owner;

+ (CHChatMessageVoiceVM *)factoryVoiceOfUserIcon:(NSString *)avatar
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        fileName:(NSString *)fileName
                                        resource:(NSString *)path
                                     voiceLength:(NSInteger )length
                                         isOwner:(BOOL)owner;
+ (CHChatMessagePacketVM *)factoryPacketOfUserIcon:(NSString *)avatar
                                          timeDate:(NSString *)date
                                          nickName:(NSString *)name
                                          packetId:(NSInteger )identifer
                                          blessing:(NSString *)blessing
                                           isOwner:(BOOL)owner;

+ (CHChatMessageHTMLVM *)factoryHTMLOfUserIcon:(NSString *)avatar
                                      timeDate:(NSString *)date
                                      nickName:(NSString *)name
                                         title:(NSString *)title
                                       content:(NSString *)content
                                     thumbnail:(NSString *)thumbnail
                                           url:(NSString *)url
                                       isOwner:(BOOL)owner;

+ (NSArray <CHChatMessageViewModel *>*)testData;


@end
