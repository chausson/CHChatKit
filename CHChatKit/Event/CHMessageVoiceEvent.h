//
//  CHMessageVoiceEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/10/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
#import "CHChatDefinition.h"

@interface CHMessageVoiceEvent : CHMessageEvent
@property (nonatomic ,assign) NSInteger length;
@property (nonatomic ,copy) NSString *file;
@property (nonatomic ,copy) NSString *fileName;
@property (nonatomic ,assign) BOOL hasRead;
@end
