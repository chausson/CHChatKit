//
//  CHFaceBoard+EmojiHash.h
//  CHChatKit
//
//  Created by Chausson on 15/12/15.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CHFaceBoard.h"

@interface CHFaceBoard ()
@property (strong ,nonatomic) NSArray <UIImage *>*emojiArray;
@property (strong ,nonatomic) NSArray <NSString *>*symbolArray;
/**
 * @brief 配置emoji表情和图片
 */

@end
@interface CHFaceBoard (EmojiHash)
- (void)configurationEmoji;
@end
