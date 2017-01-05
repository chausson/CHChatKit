//
//  CHChatMessagePacketCell.h
//  CHChatKit
//
//  Created by Chausson on 2017/1/4.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"

@interface CHChatMessagePacketCell : CHChatMessageCell<CHChatMessageCellCategory>

@property (strong ,nonatomic) UIButton *redPacketBtn;
@property (strong ,nonatomic) UILabel *blessingTitle;
@end
