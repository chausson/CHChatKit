//
//  CHChatTableView.m
//  CHChatDemo
//
//  Created by Chausson on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CHChatTableView.h"

@implementation CHChatTableView
- (instancetype)init{
    self = [super init];
    if (self) {
         [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollEnabled = YES;
    self.allowsSelection = NO;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
}
@end
