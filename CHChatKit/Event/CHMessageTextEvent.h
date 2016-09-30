//
//  CHMessageTextEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/9/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"

@interface CHMessageTextEvent : CHMessageEvent

@property (nonatomic ,copy) NSString *text;

@end
