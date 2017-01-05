//
//  CHChatMessagePacketVM.h
//  CHChatKit
//
//  Created by Chausson on 2017/1/5.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"
typedef NS_ENUM(NSUInteger, CHChatPacketState) {
    CHChatPacketNormal,
    CHChatPacketInvalid,
    CHChatPacketUsed
};
@interface CHChatMessagePacketVM : CHChatMessageViewModel<CHChatMessageViewModelProtocol>

@property (readonly ,nonatomic) NSString *blessing;
@property (readonly ,nonatomic) NSInteger packetIdentifier;
@property (assign ,nonatomic) CHChatPacketState packetState;

@end
