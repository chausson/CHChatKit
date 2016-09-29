//
//  CHChatMessageLocationCell.h
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"
#import "NSObject+KVOExtension.h"

@interface CHChatMessageLocationCell : CHChatMessageCell<CHChatMessageCellCategory>
@property (strong ,nonatomic ) UIView *locationContainer;
@property (strong ,nonatomic ) UIImageView *mapImageView;
@property (strong ,nonatomic ) UILabel *areaName;
@property (strong ,nonatomic ) UILabel *areaDetail;
@property (strong ,nonatomic ) UIView *areaView;
@end
