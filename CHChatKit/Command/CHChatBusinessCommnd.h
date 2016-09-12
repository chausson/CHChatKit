//
//  CHChatCommnd.h
//  CHChatDemo
//
//  Created by Chausson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHChatModel.h"
#import "CHMessageModel.h"
@class CHChatBusinessCommnd;




@interface CHChatBusinessCommnd : NSObject

//有无网络
+ (instancetype)standardChatDefaults;
// 发送单聊消息
- (void)postMessage:(NSString *)message;


- (void)postSoundWithData:(NSString *)path;



@end
