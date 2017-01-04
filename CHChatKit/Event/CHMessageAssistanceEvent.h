//
//  CHMessageAssistanceEvent.h
//  CHChatKit
//
//  Created by Chausson on 2017/1/4.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
#import "CHChatAssistance.h"
@interface CHMessageAssistanceEvent : CHMessageEvent
@property (strong ,nonatomic) CHChatAssistance *item;
@end
