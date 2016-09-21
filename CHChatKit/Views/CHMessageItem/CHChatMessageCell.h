//
//  CHChatMessageCell.h
//  CHChatKit
//
//  Created by Chausson on 16/9/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHMessageContentView.h"
#import "CHChatDefinition.h"
@class CHChatMessageCell;
@class CHMessageViewModel;
@protocol CHChatMessageCellCategory <NSObject>
@required
/*!
 @return 定义消息类型用来注册TableView
 */
+ (CHChatMessageType )registerMessageType;

@end
@interface CHChatMessageCell : UITableViewCell

@property (strong ,nonatomic) CHMessageViewModel *viewModel;

@property (strong ,nonatomic) CHMessageContentView *messageContainer;

- (void)loadViewModel:(CHMessageViewModel *)viewModel;
- (void)layout;
@end
