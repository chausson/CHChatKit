//
//  CHChatMessageHTMLCell.h
//  Pods
//
//  Created by 黑眼圈 on 2017/2/21.
//
//

#import "CHChatMessageCell.h"

@interface CHChatMessageHTMLCell : CHChatMessageCell<CHChatMessageCellCategory>

@property (strong ,nonatomic ) UILabel  *titleLabel;
@property (strong ,nonatomic ) UILabel  *contentLabel;
@property (strong ,nonatomic ) UIButton *htmlBtn;
@property (strong ,nonatomic ) UIImageView *thumbnailView;

@end
