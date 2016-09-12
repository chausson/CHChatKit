//
//  FaceBoard+EmojiHash.h
//  CSChatDemo
//
//  Created by XiaoSong on 15/12/15.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "FaceBoard.h"

@interface FaceBoard ()
@property (strong ,nonatomic) NSArray *emojiArray;
@property (strong ,nonatomic) NSArray *symbolArray;
/**
 * @brief 配置emoji表情和图片
 */

@end
@interface FaceBoard (EmojiHash)
- (void)configurationEmoji;
@end