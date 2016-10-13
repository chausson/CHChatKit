//
//  CHChatMessageVoiceVM.h
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageFileVM.h"

@interface CHChatMessageVoiceVM : CHChatMessageFileVM<CHChatMessageViewModelProtocol>
@property (nonatomic ,readonly) NSInteger length;
@property (nonatomic ,readonly) BOOL hasRead;
@property (nonatomic ,readonly) CHVoicePlayState voiceState;

- (void)playVoice;
- (void)stopVoice;
@end
