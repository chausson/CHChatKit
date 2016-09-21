//
//  CHChatCell.h
//  CHChatDemo
//
//  Created by XiaoSong on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHChatCellViewModel.h"




@interface CHChatCell : UITableViewCell

@property (strong ,nonatomic) CHChatCellViewModel *viewModel;

+ (CGFloat)getHeightWithViewModel:(CHChatCellViewModel *)viewModel;
+ (NSString *)chatIdentifierWithType:(CHChatMessageType )type;
- (instancetype )initWithType:(CHChatMessageType )type;
- (instancetype)init __unavailable;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;

- (void)loadViewModel:(CHChatCellViewModel *)viewModel;




@end
