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



@end
