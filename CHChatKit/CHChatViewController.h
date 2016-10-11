//
//  CHChatViewController.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHChatViewModel.h"
#import "CHChatToolView.h"
#import "CHChatTableView.h"
#import "CHChatConfiguration.h"
@interface CHChatViewController : UIViewController<CHKeyboardActivity, UITableViewDelegate,UITableViewDataSource>
- (instancetype)init __unavailable;
- (instancetype)initWithViewModel:(CHChatViewModel *)viewModel;
@property (strong ,nonatomic) CHChatToolView *chatView;
@property (strong ,nonatomic) CHChatTableView *chatTableView;
@property (strong ,nonatomic) CHChatViewModel *viewModel;
@end
