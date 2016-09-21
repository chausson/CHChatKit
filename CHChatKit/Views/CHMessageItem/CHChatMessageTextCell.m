//
//  CHChatMessageText.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageTextCell.h"
@interface CHChatMessageTextCell ()
@property (strong ,nonatomic ) UILabel *message;
@property (strong ,nonatomic ) UIButton *bubbleBtn;
@end
@implementation CHChatMessageTextCell

+ (CHChatMessageType )registerMessageType{
    
    return CHMessageText;
}
- (void)layout{
    [super layout];
    _message = [UILabel new];

    _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.messageContainer addSubview:_bubbleBtn];
    [self.messageContainer addSubview:_message];
    
    _message.numberOfLines = 0;
    _message.font = [UIFont systemFontOfSize:15];
    _message.textColor = [UIColor blackColor];
    _message.backgroundColor = [UIColor clearColor];
}
#pragma mark 懒加载
@end
