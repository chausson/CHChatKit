//
//  CHChatMessageImageVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageFileVM.h"
#import "CHRecordHandler.h"
@implementation CHChatMessageFileVM
- (BOOL)isLocalFile{

    return ![_filePath hasPrefix:@"http"];

}
- (void)setFilePath:(NSString *)filePath{
    _filePath = filePath;
}
- (void)setState:(CHMessageSendState)state{
    _state = state;
}

- (void)playVoice{
    if (_filePath.length != 0) {
        
        dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(dispatchQueue, ^(void) {
            [[CHRecordHandler standardDefault] playRecordWithKey:@""];
        });
        
    }
    
}
@end
