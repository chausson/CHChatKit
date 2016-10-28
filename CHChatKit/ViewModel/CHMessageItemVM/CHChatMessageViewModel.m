//
//  CHMessageViewModel.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"

@implementation CHChatMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _visableTime = YES;

    }
    return self;
}

- (void)respondsTapAction{
    
}
- (void)sortOutWithTime:(NSString *)time{
    if (time && time.length != 0) {
        if ([time isEqualToString:_date]){
            _visableTime = NO;
        }
    }
}

- (void)resend{
    NSLog(@"重发消息");
}
- (void)setNickName:(NSString *)nickName{
    _nickName = nickName;
}
- (void)setSendingState:(CHMessageSendState)sendingState{
    _sendingState = sendingState;
}
- (void)setCategory:(CHChatMessageType)category{
    _category = category;
}
- (void)setDate:(NSString *)date{
    _date = date;
}
- (void)setOwner:(BOOL)owner{
    _owner = owner;
}
- (void)setVisableTime:(BOOL)visableTime{
    _visableTime = visableTime;
}


@end
