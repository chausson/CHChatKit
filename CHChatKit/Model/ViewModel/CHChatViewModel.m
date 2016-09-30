//
//  CHChatVIewModel.m
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "NSString+Emoji.h"
#import "CHChatViewModel.h"
#import "CHChatConfiguration.h"
#import "CHChatMessageViewModel.h"
#import "CHChatMessageVMFactory.h"
#import "CHMessageTextEvent.h"
#import "XEBEventBus.h"
#import "NSObject+KVOExtension.h"

static NSString *SwiftDateToString(NSDate *date){
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";

    return   [formatter stringFromDate:date];
}


@implementation CHChatViewModel{
    
    NSDate *_lastPlaySoundDate;
}
- (instancetype)initWithMessageList:(CHChatModel *)list
                      configuration:(CHChatConfiguration *)config{
    
    self = [super init];
    if (self) {
        _refreshName = @"CHCHAT_REFRESH_TABLEVIEW";
        _configuration = config;
        [self ch_registerForKVO];
        NSMutableArray *cellTempArray = [[NSMutableArray alloc ]initWithCapacity:list.chatContent.count];

        for (int i = 0; i < list.chatContent.count; i++) {
            CHChatViewItemModel *item = list.chatContent[i];
            CHChatMessageViewModel *viewModel ;
            switch (item.type) {
                case 1:
                    viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:item.icon timeData:item.time nickName:item.name content:item.content isOwner:[item.owner boolValue]];
                    break;
                case 2:
                    viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:item.icon timeData:item.time nickName:item.name resource:item.image thumbnailImage:nil fullImage:nil size:0 width:0 height:0 isOwner:[item.owner boolValue]];
                    break;
                case 3:
                    viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:item.icon timeData:item.time nickName:item.name resource:item.path voiceLength:[item.length integerValue] isOwner:[item.owner boolValue]];
                    break;
                case 5:
                    viewModel = [CHChatMessageVMFactory factoryLoactionOfUserIcon:item.icon timeData:item.time nickName:item.name areaName:item.title areaDetail:item.detail resource:item.path longitude:[item.lon floatValue] latitude:[item.lat floatValue] isOwner:[item.owner boolValue]];
                    break;
                    
                default:
                    break;
            }

            if (i != 0) {
            CHChatViewItemModel *last = list.chatContent[i-1];

                
            [viewModel sortOutWithTime:last.time];
            }
            [cellTempArray addObject:viewModel];
        }
        
        
         _cellViewModels = [NSArray arrayWithArray:cellTempArray];
    }

    return self;
}


#pragma mark - KVO

- (NSArray *)ch_registerKeypaths {
    return [NSArray arrayWithObjects:@"cellViewModels", nil];
}
- (void)ch_ObserveValueForKey:(NSString *)key
                     ofObject:(id )obj
                       change:(NSDictionary *)change{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:key waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:key];
    }
}
- (void)updateUIForKeypath:(NSString *)keyPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:_refreshName object:nil];
}
- (void)postMessage:(NSString *)text{
    CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:self.userIcon timeData:SwiftDateToString([NSDate date]) nickName:nil content:text isOwner:YES];
    [viewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    [cellTempArray addObject:viewModel];
    self.cellViewModels = [cellTempArray copy];

    //判断是发单聊消息还是群聊消息给服务器
    if (self.configuration.type == CHChatSingle) {
        XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
        
        [eventBus postEvent: [CHMessageTextEvent new]];
        
    }else{
        
    }

    
}
- (void)postVoice:(NSString *)path
           second:(NSInteger )sec{
        CHChatMessageVoiceVM  *cellViewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:self.userIcon timeData:SwiftDateToString([NSDate date]) nickName:nil resource:path voiceLength:sec isOwner:YES];
        [cellViewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
        NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
        [cellTempArray addObject:cellViewModel];
        self.cellViewModels = [NSArray arrayWithArray:cellTempArray];
//        [[CHChatBusinessCommnd standardChatDefaults] postSoundWithData:path];
}

- (void)postImage:(NSString *)path
        fullImage:(UIImage *)image{
    
    CHChatMessageImageVM  *cellViewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:self.userIcon timeData:SwiftDateToString([NSDate date]) nickName:nil resource:path fullImage:image isOwner:YES];
    [cellViewModel sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    [cellTempArray addObject:cellViewModel];
    self.cellViewModels = [NSArray arrayWithArray:cellTempArray];
}

- (void)dealloc{
     [self ch_unregisterFromKVO];
}

@end
