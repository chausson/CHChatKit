//
//  CHChatVIewModel.m
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//


#import "CHChatViewModel.h"
#import "CHChatConfiguration.h"
#import "CHChatMessageViewModel.h"
#import "CHChatMessageVMFactory.h"
#import "CHMessageTextEvent.h"
#import "CHMessageReceiveEvent.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"
#import "NSObject+KVOExtension.h"
#import "NSString+CHExtensions.h"

@interface CHChatViewModel ()<XEBSubscriber>

@end
@implementation CHChatViewModel{

    XEBEventBus* _eventBus;

    NSDate *_lastPlaySoundDate;
}
- (instancetype)initWithMessageList:(CHChatModel *)list
                      configuration:(CHChatConfiguration *)config{
    
    self = [super init];
    if (self) {
        _eventBus = [XEBEventBus defaultEventBus];
        [_eventBus registerSubscriber:self];
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
                    viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:item.icon timeData:item.time nickName:item.name resource:item.image thumbnailImage:nil fullImage:nil  isOwner:[item.owner boolValue]];
                    break;
                case 3:
                    viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:item.icon timeData:item.time nickName:item.name resource:item.path voiceLength:[item.length integerValue] isOwner:[item.owner boolValue]];
                    break;
                case 5:
                    viewModel = [CHChatMessageVMFactory factoryLoactionOfUserIcon:item.icon timeDate:item.time nickName:item.name areaName:item.title areaDetail:item.detail resource:item.path snapshot:nil longitude:[item.lon floatValue] latitude:[item.lat floatValue] isOwner:[item.owner boolValue]];
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
+ (NSArray<Class>*)handleableEventClasses {
    return @[[CHMessageReceiveEvent class]];
}
- (void)onEvent:(CHMessageReceiveEvent *)event{
    NSMutableArray *cellTempArray = [NSMutableArray arrayWithArray:[_cellViewModels copy]];
    event.item.icon = self.userIcon;
    [event.item sortOutWithTime:[_cellViewModels lastObject]?[_cellViewModels lastObject].date:nil];
    [cellTempArray addObject:event.item];
    self.cellViewModels = [cellTempArray copy];
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

- (void)dealloc{
    [self ch_unregisterFromKVO];
    [_eventBus unregisterSubscriber: self];
}

@end
