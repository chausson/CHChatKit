//
//  CHChatConfiguration.m
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatConfiguration.h"

@implementation CHAssistanceItem

@end

@implementation CHChatConfiguration

+ (CHChatConfiguration *)defultConfigruration{
    CHChatConfiguration *instance = [CHChatConfiguration new];
    instance = [CHChatConfiguration new];
    instance.mainBackground = [UIColor blackColor];
    instance.iconCornerRadius = 0;
    instance.allowEmoji = YES;
    instance.allowAssistance = YES;
    instance.allowRecordVoice = YES;
    instance.toolInputViewBackground = [UIColor clearColor];
    instance.toolContentBackground = [UIColor colorWithRed:241.0/ 255.0 green:241.0/255.0 blue:244.0 / 255.0 alpha:1];
    return instance;
}

//- (NSArray <CHAssistanceItem *>*)asstemblyDefultItems{
//    NSMutableArray *items = [NSMutableArray array];
//    CHAssistanceItem *pickPhoto = [self avaiableItemWithType:CHAssistancePhoto];
//    CHAssistanceItem *photo =  [self avaiableItemWithType:CHAssistanceCarema];
//    CHAssistanceItem *location =  [self avaiableItemWithType:CHAssistanceLocation];
//
//    [items addObject:pickPhoto];
//    [items addObject:photo];
//    [items addObject:location];
//
//    return [items copy];
//}
- (CHAssistanceItem *)avaiableItemWithType:(CHAssistanceType )type{
    CHAssistanceItem *item = [[CHAssistanceItem alloc]init];
    switch (type) {
        case CHAssistancePhoto:
            item.iconTitle = @"照片";
            item.iconImageName = @"sharemore_pic";
            item.itemType = CHAssistanceCarema;
            break;
        case CHAssistanceCarema:
            item.iconTitle = @"拍照";
            item.iconImageName = @"sharemore_video";
            item.itemType = CHAssistancePhoto;
            break;
        case CHAssistanceLocation:
            item.iconTitle = @"位置";
            item.iconImageName = @"sharemore_pic";
            item.itemType = CHAssistanceLocation;
            break;
            
        default:
            NSAssert(false, @"CHAssistanceType 没有配置相应的类型");
            break;
    }
    return item;
}
- (void)addAssistanceItem:(CHAssistanceType )item{
    @synchronized (self) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:_assistanceItems];
        
        [items addObject:[self avaiableItemWithType:item]];
        
        _assistanceItems = [items copy];
    }

}
- (void)addAssistanceItems:(NSArray  <NSNumber *>*)items{
    @synchronized (self) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:_assistanceItems];
        [items enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *  stop) {
            [array addObject:[self avaiableItemWithType:[number integerValue]]];
        }];
        _assistanceItems = [array copy];
    }
}
- (void)removeAssistanceItem:(CHAssistanceType )item{
    @synchronized (self) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:_assistanceItems];
        [items enumerateObjectsUsingBlock:^(CHAssistanceItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.itemType == item) {
                [items removeObject:obj];
                *stop = YES;
            }
        }];
        _assistanceItems = [items copy];
    }
}
@end
