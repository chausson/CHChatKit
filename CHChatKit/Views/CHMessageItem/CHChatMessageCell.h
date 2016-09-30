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
#import "CHChatMessageViewModel.h"
@class CHChatMessageCell;
@class CHChatMessageViewModel;

@protocol CHChatMessageCellCategory <NSObject>
@required
/*!
 @return 定义消息类型用来注册TableView
 */
+ (CHChatMessageType )messageCategory;

@end
@protocol CHChatMessageCellDelegate <NSObject>
@optional
@end
@interface CHChatMessageCell : UITableViewCell

@property (strong ,nonatomic) CHChatMessageViewModel *viewModel;
@property (strong ,nonatomic) CHMessageContentView *messageContainer;

@property (strong ,nonatomic ) UIImageView *icon;

@property (strong ,nonatomic ) UILabel *date;
@property (assign ,nonatomic ) CGFloat iconCornerRadius;
@property (strong ,nonatomic ) UILabel *nickName;
@property (weak ,nonatomic ) id <CHChatMessageCellDelegate> delegate;
+ (void)registerSubclass;
+ (void)registerNotificationRefresh:(NSString *)name; // 注册刷新名称

- (void)reloadTableView;
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel;

- (CGSize)boundingRectWithSize:(CGSize)size
                          text:(NSString *)text
                          font:(UIFont *)font;

- (void)layout;
- (BOOL)isOwner;
- ( __kindof CHChatMessageViewModel *)viewModel;
@end
