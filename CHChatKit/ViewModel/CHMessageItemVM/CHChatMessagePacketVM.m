//
//  CHChatMessagePacketVM.m
//  CHChatKit
//
//  Created by Chausson on 2017/1/5.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHChatMessagePacketVM.h"

@implementation CHChatMessagePacketVM
- (CHChatMessageType )category{
    return CHMessagePacket;
}
- (void)setBlessing:(NSString *)blessing{
    _blessing = blessing;
}

- (void)setPacketIdentifier:(NSInteger)packetIdentifier{
    _packetIdentifier = packetIdentifier;
}
@end
