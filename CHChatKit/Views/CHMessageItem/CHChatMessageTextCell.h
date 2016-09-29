//
//  CHChatMessageText.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"

@interface CHChatMessageTextCell : CHChatMessageCell<CHChatMessageCellCategory>
@property (strong ,nonatomic ) UILabel  *message;
@property (strong ,nonatomic ) UIButton *bubbleBtn;
@end
