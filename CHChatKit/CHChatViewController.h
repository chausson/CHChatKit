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
#import "CHChatConfiguration.h"
@interface CHChatViewController : UIViewController<CHKeyboardEvent, CHKeyboardActivity, UITableViewDelegate,UITableViewDataSource>
- (instancetype)init __unavailable;
- (instancetype)initWithViewModel:(CHChatViewModel *)viewModel;
- (instancetype)initWithViewModel:(CHChatViewModel *)viewModel
                    configuration:(CHChatConfiguration *)info;
@property (strong ,nonatomic) CHChatToolView *chatView;
@property (strong ,nonatomic) CHChatTableView *chatTableView;
@property (strong ,nonatomic) CHChatViewModel *viewModel;
@end
