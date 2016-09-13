//
//  CHChatViewController.m
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//


#import "CHChatViewController.h"
#import "Masonry.h"
#import "CHChatCell.h"
#import "MJRefresh.h"


@interface CHChatViewController()

@property(nonatomic,strong)MJRefreshHeader*  header;


@end

@implementation CHChatViewController{
    NSMutableArray *messageList;
    NSMutableDictionary *sizeList;
}


- (instancetype)initWithViewModel:(CHChatViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        self.title = viewModel.chatControllerTitle;
        self.view.backgroundColor = [UIColor whiteColor];
        [self layOutsubviews];

    }
    return self;
}
#pragma mark Lazy Init
- (CHChatToolView *)chatView{
    if (!_chatView) {
        _chatView = [[CHChatToolView alloc]initWithObserver:self];

    }
    return _chatView;
}
- (CHChatTableView *)chatTableView{
    if (!_chatTableView) {
        _chatTableView = [[CHChatTableView alloc] init];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
    }
    return _chatTableView;
}
#pragma mark activity
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotificationCenter];
    [self autoRollToLastRow];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
- (void)registerNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:_viewModel.refreshName object:nil];
}
- (void)updateUI{
        [self.chatTableView reloadData];
        if (self.viewModel.cellViewModels.count >5) {
            [self.chatTableView scrollToRowAtIndexPath:
             [NSIndexPath indexPathForRow:[self.viewModel.cellViewModels count]-1 inSection:0]
                                      atScrollPosition: UITableViewScrollPositionBottom
                                              animated:NO];
    
            [self.chatTableView reloadData];
            
        }
}

#pragma mark  LayoutSubViews

- (void)layOutsubviews
{
    UITapGestureRecognizer *keyBoardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerKeyBoardTap:)];
    [_chatTableView addGestureRecognizer:keyBoardTap];
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatView];
//    [_chatView autoLayoutView];
    [_chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.and.right.offset(0);
        make.bottom.equalTo(self.chatView.mas_top).with.offset(0);
    }];

}
#pragma mark UITableViewDelagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHChatCellViewModel *cellViewModel = self.viewModel.cellViewModels[indexPath.row];
    CHChatCell *cell = [tableView dequeueReusableCellWithIdentifier:[CHChatCell chatIdentifierWithType:cellViewModel.type]];
    if (cell == nil) {
        cell = [[CHChatCell alloc] initWithType:cellViewModel.type];
    }

    [cell loadViewModel:cellViewModel];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CHChatCell getHeightWithViewModel:self.viewModel.cellViewModels[indexPath.row]];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.viewModel.cellViewModels.count < 10) {

        return;
    }
    
    //当第一个 cell 出现的时候实现下拉刷新
    if (indexPath.row == 0) {
        
        //下拉刷新
        self.chatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

                NSInteger count = 0;
                if (self.viewModel.cellViewModels.count%10 != 0) {
                    count = self.viewModel.cellViewModels.count%10;
                }else{
                    count = 10;
                }
                    [self.chatTableView scrollToRowAtIndexPath:
                     [NSIndexPath indexPathForRow:count inSection:0]
                                              atScrollPosition: UITableViewScrollPositionBottom
                                                      animated:NO];
        }];
        
    }
    
}
#pragma mark Private
// list滚动至最后一行
- (void)autoRollToLastRow
{
     [self.view layoutIfNeeded];
    
    if (self.viewModel.cellViewModels.count > 5) {
        
        [self.chatTableView scrollToRowAtIndexPath:
         [NSIndexPath indexPathForRow:[self.viewModel.cellViewModels count]-1 inSection:0]
                                  atScrollPosition: UITableViewScrollPositionBottom
                                          animated:NO];
    }
    
}
#pragma mark CHChatToolView_Delegate
- (void)chatKeyboardWillShow{

    [self autoRollToLastRow];

}
#pragma mark - 发送消息到服务器

- (void)sendMessage:(NSString *)text{
    [self.viewModel postMessage:text];
}
- (void)sendSound:(NSString *)path{
    [self.viewModel postVoice:path];
}
- (void)sendImage:(UIImage *)image{
    [self.viewModel postImage:image];
}
- (void)chatInputView{
    [self autoRollToLastRow];
}
#pragma mark 给数据源增加内容
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_chatView setKeyboardHidden:YES];
   
}
#pragma mark private click tableview
- (void)registerKeyBoardTap:(UITapGestureRecognizer *)tap
{
    [_chatView setKeyboardHidden:YES];
   
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
////    [self.chatTableView ];
//    
//    //滑动到最顶端的时候
//    if (scrollView.contentOffset.y == 0) {
//        
//       
//    }
//   
//    
//}

-(void)dealloc{
   
    NSLog(@"聊天界面被销毁了");
    
}


@end
