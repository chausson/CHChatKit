//
//  CHMessagePacketEvent.h
//  CHChatKit
//
//  Created by Chausson on 2017/1/5.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
#import "CHChatMessagePacketVM.h"
@interface CHMessagePacketEvent : CHMessageEvent
@property (weak ,nonatomic) CHChatMessagePacketVM *packetViewModel;
@end
