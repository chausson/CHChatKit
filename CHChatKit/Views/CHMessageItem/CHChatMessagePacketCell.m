//
//  CHChatMessagePacketCell.m
//  CHChatKit
//
//  Created by Chausson on 2017/1/4.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHChatMessagePacketCell.h"

@implementation CHChatMessagePacketCell
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessagePacket;
}

- (void)layout{
    [super layout];
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    
}

@end
