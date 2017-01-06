
//
//  CHChatMessageVoiceVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageVoiceVM.h"
#import "CHRecordHandler.h"
#import "NSObject+KVOExtension.h"
@implementation CHChatMessageVoiceVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[CHRecordHandler standardDefault] addObserver:self forKeyPath:@"recordFileUrl" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (CHChatMessageType )category{
    return CHMessageVoice;
}
- (void)setLength:(NSInteger)length{
    _length  = length;
}
- (void)setHasRead:(BOOL)hasRead{
    _hasRead = hasRead;
}
- (void)setVoiceState:(CHVoicePlayState)voiceState{
    _voiceState = voiceState;
}
- (void)playVoice
{
    self.hasRead = YES;
    if (_voiceState == CHVoicePlaying) {
        [self stopVoice];
    }else{
        self.voiceState = CHVoicePlaying;
        __weak typeof(self) weakSelf = self;

        [[CHRecordHandler standardDefault] playRecordWithPath:self.filePath
         finsh:^(NSString *path, NSInteger duration) {
             __strong typeof(self) strongSelf = weakSelf;
                strongSelf.voiceState = CHVoiceFinish;
         }];
    }

}
- (void)stopVoice
{
    self.voiceState = CHVoicePlayCancel;
    [[CHRecordHandler standardDefault] stopPlaying];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"recordFileUrl"] && self.voiceState == CHVoicePlaying) {
        
        NSURL *url = [change objectForKey:@"new"];
        if (![url.absoluteString isEqualToString:self.filePath]) {
            self.voiceState = CHVoicePlayCancel;
        }
        
    }
}
- (void)dealloc{
    [[CHRecordHandler standardDefault] removeObserver:self forKeyPath:@"recordFileUrl"];
    [[CHRecordHandler standardDefault] stopPlaying];
}
@end
