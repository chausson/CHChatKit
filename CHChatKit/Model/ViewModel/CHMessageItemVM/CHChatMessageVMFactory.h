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
#import "CHChatDefinition.h"
@interface CHChatMessageVMFactory : NSObject

+ (CHChatMessageTextVM *)factoryTextOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                         content:(NSString *)content
                                         isOwner:(BOOL)owner;

+ (CHChatMessageFileVM *)factoryFileOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        filePath:(NSString *)file
                                         isOwner:(BOOL)owner
                                        category:(CHChatMessageType )category;

+ (CHChatMessageLocationVM *)factoryLoactionOfUserIcon:(NSString *)icon
                                              timeData:(NSString *)date
                                              nickName:(NSString *)name
                                              areaName:(NSString *)title
                                            areaDetail:(NSString *)detail
                                              resource:(NSString *)path
                                             longitude:(float )lon
                                              latitude:(float )lat
                                               isOwner:(BOOL)owner;

+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)icon
                                         imeData:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                            size:(float )size
                                           width:(float )aWidth
                                          height:(BOOL)aHeight
                                         isOwner:(BOOL)owner;



@end
