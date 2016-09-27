//
//  CHChatMessageVoiceCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageVoiceCell.h"

@implementation CHChatMessageVoiceCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageVoice;
}
- (void)layout{
    
    [super layout];
    
}
- (void)updateConstraints{
    [super updateConstraints];
    
}
@end
