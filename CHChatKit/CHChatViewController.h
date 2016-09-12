//
//  CHChatViewController.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHChatVIewModel.h"
#import "CHChatToolView.h"
#import "CHChatTableView.h"
@interface CHChatViewController : UIViewController<CHChatToolViewKeyboardProtcol, UITableViewDataSource, UITableViewDelegate>
- (instancetype)init __unavailable;
- (instancetype)initWithViewModel:(CHChatViewModel *)viewModel;

@property (strong ,nonatomic) CHChatToolView *chatView;
@property (strong ,nonatomic) CHChatTableView *chatTableView;
@property (strong ,nonatomic) CHChatViewModel *viewModel;
@end
