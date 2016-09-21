//
//  CHChatVIewModel.m
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "NSString+Emoji.h"
#import "CHChatViewModel.h"
#import "CHChatBusinessCommnd.h"
#import "CHChatConfiguration.h"
#import "NSObject+KVOExtension.h"
#define FACE_NAME_HEAD  @"/s"
// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   5


NSString * SwiftDateToString(NSDate *date){
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";

    return   [formatter stringFromDate:date];
}
static const CGFloat kDefaultPlaySoundInterval = 3.0;


@interface CHChatViewModel()

@end


@implementation CHChatViewModel{
    
    NSDate *_lastPlaySoundDate;
}
- (instancetype)initWithMessageList:(CHChatModel *)list{
    
    self = [super init];
    if (self) {
            _refreshName = @"REFRESH_CHAT_UI";
            [self registerForKVO];
           __weak  typeof(self) weakSelf = self;
//            [[CHChatBusinessCommnd standardChatDefaults]setReceiverBlock:^(NSString * message, CHMessageModel * messageModel) {
//                __strong typeof(self) strongSelf = weakSelf;
//
//                [strongSelf receiverMessageWithText:message andMessageModel:messageModel];
//            }];
  
        
        NSMutableArray *cellTempArray = [[NSMutableArray alloc ]initWithCapacity:list.chatContent.count];
        for (int i = 0; i < list.chatContent.count; i++) {
            CHChatCellViewModel *cellViewModel = [[CHChatCellViewModel alloc]initWithModel:list.chatContent[i]];
            if (i != 0) {
            CHChatViewItemModel *last = list.chatContent[i-1];

                
            [cellViewModel sortOutWithTime:last.time];
            }
            [cellTempArray addObject:cellViewModel];
        }
         _cellViewModels = [NSArray arrayWithArray:cellTempArray];
    }

    return self;
}


#pragma mark - KVO

- (NSArray *)registerKeypaths {
    return [NSArray arrayWithObjects:@"cellViewModels", nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}
- (void)updateUIForKeypath:(NSString *)keyPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:_refreshName object:nil];
}
- (void)receiverMessageWithText:(NSString *)text andMessageModel:(CHMessageModel *) messageModel{

//    NSLog(@"%@",text);
    
    CHChatViewItemModel *model = [[CHChatViewItemModel alloc] init];
    model.content = text;
    
    //单聊时对方的头像
    self.receiverIcon = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=5bda8a18a71ea8d38a777c02a73a1c76/5882b2b7d0a20cf4598dc37c77094b36acaf9977.jpg";
    if (messageModel == nil) {
        
        model.icon = self.receiverIcon;
    }else{
        model.icon = messageModel.icon;
        model.name = messageModel.name;
    }
    model.type = CHMessageText;
    model.time = SwiftDateToString([NSDate date]);
    model.others = @(YES);
    CHChatCellViewModel *cellViewModel = [[CHChatCellViewModel alloc]initWithModel:model];
    [cellViewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    [cellTempArray addObject:cellViewModel];
    self.cellViewModels = [NSArray arrayWithArray:cellTempArray];
}
- (void)postMessage:(NSString *)text{
    CHChatViewItemModel *model = [[CHChatViewItemModel alloc] init];
    model.content = text;
    model.icon = _userIcon;
    model.type = CHMessageText;
    model.time = SwiftDateToString([NSDate date]);
    CHChatCellViewModel *cellViewModel = [[CHChatCellViewModel alloc]initWithModel:model];
    [cellViewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    [cellTempArray addObject:cellViewModel];
    self.cellViewModels = [cellTempArray copy];
    
    //如果有网络
    // if ([CHChatBusinessCommnd standardChatDefaults].isSendGet) {
    
    //        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //        [dic setObject:[text stringByReplacingEmojiUnicodeWithCheatCodes] forKey:@"msgContent"];
    
    //判断是发单聊消息还是群聊消息给服务器
    if ([CHChatConfiguration standardChatDefaults].type == CHChatSingle) {
        
        
        [[CHChatBusinessCommnd standardChatDefaults] postMessage:text];
    }else{
        
        //    [[CHChatBusinessCommnd standardChatDefaults] postGroupMessageWithDic:dic];
    }
    // }
    
}
- (void)postVoice:(NSString *)path{
   
    CHChatViewItemModel *model = [[CHChatViewItemModel alloc] init];
    model.time = SwiftDateToString([NSDate date]);
    model.icon = self.userIcon;
    model.voicePath = path;
    model.type = CHMessageVoice;
    CHChatCellViewModel *cellViewModel = [[CHChatCellViewModel alloc]initWithModel:model];
    [cellViewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    [cellTempArray addObject:cellViewModel];
    self.cellViewModels = [NSArray arrayWithArray:cellTempArray];
    [[CHChatBusinessCommnd standardChatDefaults] postSoundWithData:path];
}
- (void)postImage:(UIImage *)image{
    CHChatViewItemModel *model = [[CHChatViewItemModel alloc] init];
    model.time = SwiftDateToString([NSDate date]);
    model.icon = self.userIcon;
    model.type = CHMessageImage;
    CHChatCellViewModel *cellViewModel = [[CHChatCellViewModel alloc]initWithModel:model];
    cellViewModel.imageResource = image;
    [cellViewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    [cellTempArray addObject:cellViewModel];
    self.cellViewModels = [NSArray arrayWithArray:cellTempArray];
}
//-(void)refreshMessage:(NSString*)myID :(refreshBlock)refreshBlock{
//    
//    if ([CHChatConfiguration standardChatDefaults].type == CHChatSingle) {
//
//            
//            NSMutableArray* array = [NSMutableArray array];
//
//            for (CHChatCellViewModel* cellViewModel in self.cellViewModels) {
//                
//                [array addObject:cellViewModel];
//            }
//            
//            for (int i =1; i<array.count; i++) {
//                CHChatCellViewModel* oldCellViewModel = array[i-1];
//                CHChatCellViewModel* nowCellViewModel = array[i];
//                
//                if ([nowCellViewModel.time isEqualToString:oldCellViewModel.date]) {
//                    
//                    nowCellViewModel.visableTime = NO;
//                }
//            }
//            
//            self.cellViewModels = array.copy;
//            refreshBlock();
//            
//     //   }];
//    }else{
//
//    }
//    
//    
//
//    
//}

- (void)dealloc{
     [self unregisterFromKVO];
}

@end
