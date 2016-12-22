//
//  CHMessageReceiveEvent
//  CHChatKit
//
//  Created by Chausson on 16/10/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
@class CHChatMessageViewModel;
@interface CHMessageReceiveEvent : NSObject
@property (nonatomic ,strong ) CHChatMessageViewModel *item;
@end
