//
//  CHChatMessageVoiceCell.h
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"

@interface CHChatMessageVoiceCell : CHChatMessageCell<CHChatMessageCellCategory>
@property (strong ,nonatomic ) UILabel  *time;
@property (strong ,nonatomic ) UIButton *bubbleBtn;
@end
