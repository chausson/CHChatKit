//
//  CHMessageViewModel.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"

@implementation CHChatMessageViewModel{
    void(^ stateCallBack)() ;
}

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
- (CHChatMessageType )category{
    return CHMessageNone;
}
- (CHMessageSendState )sendState{
    return [self.sendingState intValue];
}
- (void)changeSendingState:(CHMessageSendState )state{
    _sendingState = @(state);
    if (stateCallBack) {
        stateCallBack();
    }
}
- (void)setSendingStateCallBack:(void(^)())stateChange{
    stateCallBack = stateChange;
}
- (void)resend{
    NSLog(@"重发消息");
}

+ (NSArray *)ignoredProperties {
    return @[@"sendingState"];
}
// *Realm 默认值
+ (NSDictionary *)defaultPropertyValues {
    return @{@"createDate" :[NSDate date]};
}



@end
