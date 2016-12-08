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
#import "CHChatDefinition.h"
@interface CHChatMessageVMFactory : NSObject

+ (CHChatMessageTextVM *)factoryTextOfUserIcon:(NSString *)icon
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                         content:(NSString *)content
                                         isOwner:(BOOL)owner;

+ (CHChatMessageFileVM *)factoryFileOfUserIcon:(NSString *)icon
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        filePath:(NSString *)file
                                         isOwner:(BOOL)owner
                                        category:(CHChatMessageType )category;

+ (CHChatMessageLocationVM *)factoryLoactionOfUserIcon:(NSString *)icon
                                              timeDate:(NSString *)date
                                              nickName:(NSString *)name
                                              areaName:(NSString *)title
                                            areaDetail:(NSString *)detail
                                              resource:(NSString *)path
                                              snapshot:(UIImage *)map
                                              location:(CLLocationCoordinate2D)coor
                                               isOwner:(BOOL)owner;
+ (CHChatMessageImageVM *)factoryImageOfUserIcon:(NSString *)icon
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        resource:(NSString *)path
                                            size:(CGSize )size
                                  thumbnailImage:(UIImage *)thumbnail
                                       fullImage:(UIImage *)image
                                         isOwner:(BOOL)owner;

+ (CHChatMessageVoiceVM *)factoryVoiceOfUserIcon:(NSString *)icon
                                        timeDate:(NSString *)date
                                        nickName:(NSString *)name
                                        fileName:(NSString *)fileName
                                        resource:(NSString *)path
                                     voiceLength:(NSInteger )length
                                         isOwner:(BOOL)owner;



@end
