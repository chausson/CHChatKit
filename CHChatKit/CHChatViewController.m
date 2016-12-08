//
//  CHChatViewController.m
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//


#import "CHChatViewController.h"
#import "CHChatMessageHelper.h"
#import "CHChatMessageCell.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface CHChatViewController()<CHChatMessageCellDelegate>

@property(nonatomic,strong)MJRefreshHeader*  header;


@end

@implementation CHChatViewController

- (instancetype)initWithViewModel:(CHChatViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        self.title = viewModel.configuration.title;
        self.view.backgroundColor = [UIColor colorWithRed:235.0/ 255.0 green:235.0/255.0 blue:235.0 / 255.0 alpha:1];
    }
    return self;
}

#pragma mark Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    [self registerNotificationCenter];
    [self autoScrolleTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
#pragma mark Notification
- (void)registerNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:self.viewModel.refreshName object:nil];
}
- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.viewModel.refreshName object:nil];
}

#pragma mark  LayoutSubViews

- (void)layout
{
    UITapGestureRecognizer *keyBoardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerKeyBoardTap:)];
    [self.chatTableView addGestureRecognizer:keyBoardTap];
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatView];

//    [_chatView autoLayoutView];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.and.right.offset(0);
        make.bottom.equalTo(self.chatView.mas_top).with.offset(0);
    }];
    if (self.viewModel.draft.length > 0) {
        [_chatView setKeyboardHidden:NO];
    }
    [CHChatMessageHelper registerCellForTableView:self.chatTableView];
}
#pragma mark TableView Delagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CHChatMessageCell *cell = [CHChatMessageHelper fetchMessageCell:(CHChatTableView *)tableView cellViewModel:self.viewModel atIndexPath:indexPath];
    CHChatMessageViewModel *cellViewModel = self.viewModel.cellViewModels[indexPath.row];
    [cell loadViewModel:cellViewModel];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHChatMessageViewModel *cellViewModel = self.viewModel.cellViewModels[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:[CHChatMessageHelper fetchMessageIdentifier:(CHChatTableView *)tableView cellViewModel:cellViewModel] cacheByIndexPath:indexPath configuration:^(CHChatMessageCell *cell) {
            [cell loadViewModel:cellViewModel];
    }];
}

#pragma mark CHChatToolView_Delegate
- (void)chatKeyboardWillShow{
    
    [self autoScrolleTableView];
    
}

#pragma mark Private
- (void)updateUI{
    [self.chatTableView reloadData];
    [self autoScrolleTableView];
}
// list滚动至最后一行
- (void)autoScrolleTableView
{
    [self.view layoutIfNeeded];
    if (self.viewModel.cellViewModels.count >= 2) {
        
        [self.chatTableView scrollToRowAtIndexPath:
         [NSIndexPath indexPathForRow:[self.viewModel.cellViewModels count]-1 inSection:0]
                                  atScrollPosition: UITableViewScrollPositionBottom
                                          animated:NO];
    }
    
}
- (void)registerKeyBoardTap:(UITapGestureRecognizer *)tap
{
    [_chatView setKeyboardHidden:YES];
    
}
#pragma mark - 发送消息到服务器

- (void)chatInputView{
    [self autoScrolleTableView];
}
#pragma mark 给数据源增加内容
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_chatView setKeyboardHidden:YES];
   
}
#pragma mark Lazy Init
- (CHChatToolView *)chatView{
    if (!_chatView) {
        _chatView = [[CHChatToolView alloc]initWithObserver:self viewModel:self.viewModel];
        
    }
    return _chatView;
}
- (CHChatTableView *)chatTableView{
    if (!_chatTableView) {
        _chatTableView = [[CHChatTableView alloc] init];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.backgroundColor = self.view.backgroundColor;
    }
    return _chatTableView;
}
-(void)dealloc{
    [self removeNotification];
    NSLog(@"聊天界面被销毁了");
}


@end
