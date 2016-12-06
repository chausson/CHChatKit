//
//  CHChatMessageImageVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageFileVM.h"
#import "CHRecordHandler.h"
#import "CHChatMessageViewModel+Protocol.h"

@implementation CHChatMessageFileVM
+ (NSArray *)ignoredProperties {
    return @[@"progress"];
}
- (CHChatMessageType )category{
    return CHMessageFile;
}
- (BOOL)isLocalFile{

    return ![_filePath hasPrefix:@"http"];

}
- (void)setFilePath:(NSString *)filePath{
    _filePath = filePath;
}
- (void)setFileName:(NSString *)fileName{
    _fileName = fileName;
}
- (NSProgress *)progress{
    if (!_progress) {
        _progress = [NSProgress progressWithTotalUnitCount:100];
        [_progress setCompletedUnitCount:100];
    }
    return _progress;
}

@end
