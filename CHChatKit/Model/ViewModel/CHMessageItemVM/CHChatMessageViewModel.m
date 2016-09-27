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
- (void)sortOutWithTime:(NSString *)time{
    if (time && time.length != 0) {
        if ([time isEqualToString:_date]){
            _visableTime = NO;
        }
    }
}
- (void)setNickName:(NSString *)nickName{
    _nickName = nickName;
}
- (void)setCategory:(CHChatMessageType)category{
    _category = category;
}
- (void)setDate:(NSString *)date{
    _date = date;
}
- (void)setIcon:(NSString *)icon{
    _icon = icon;
}
- (void)setOwner:(BOOL)owner{
    _owner = owner;
}
- (void)setRetry:(BOOL)retry{
    _retry = retry;
}
- (void)setVisableTime:(BOOL)visableTime{
    _visableTime = visableTime;
}

@end
