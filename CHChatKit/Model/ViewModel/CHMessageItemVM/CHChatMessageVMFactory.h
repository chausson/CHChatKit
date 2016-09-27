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
#import "CHChatDefinition.h"
@interface CHChatMessageVMFactory : NSObject

+ (CHChatMessageTextVM *)factoryTextVMOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                         content:(NSString *)content
                                         isOwner:(BOOL)owner;

+ (CHChatMessageFileVM *)factoryFileVMOfUserIcon:(NSString *)icon
                                        timeData:(NSString *)date
                                        nickName:(NSString *)name
                                        filePath:(NSString *)file
                                         isOwner:(BOOL)owner
                                        category:(CHChatMessageType )category;



@end
