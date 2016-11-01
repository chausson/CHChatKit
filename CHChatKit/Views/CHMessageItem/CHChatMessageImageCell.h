//
//  CHChatMessageImage.h
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"

@interface CHChatMessageImageCell : CHChatMessageCell<CHChatMessageCellCategory>
@property (strong ,nonatomic ) UIImageView *imageContainer;
@property (strong ,nonatomic ) UIView *prettyUploadMask;
@property (strong ,nonatomic ) UILabel *progress;
@end
