//
//  CHChatMessageRegister.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageHelper.h"
#import "CHChatTableView.h"
#import "CHChatDefinition.h"
#import "CHChatMessageCell.h"
#import "CHChatViewModel.h"
#import "CHChatMessageViewModel.h"
#import "CHChatMessageTextCell.h"
@implementation CHChatMessageHelper
+ (void)registerCellForTableView:(CHChatTableView *)tableView{
    [ChatCellMessageCatagory.allValues enumerateObjectsUsingBlock:^(Class  _Nonnull aClass, NSUInteger idx, BOOL * _Nonnull stop) {
        [tableView registerClass:aClass forCellReuseIdentifier:[NSStringFromClass(aClass) stringByAppendingString:CHChatCellOthersIdentifier]];
        [tableView registerClass:aClass forCellReuseIdentifier:[NSStringFromClass(aClass) stringByAppendingString:CHChatCellOwnerIdentifier]];
    }];

}
+ (CHChatMessageCell *)fetchMessageCell:(__kindof CHChatTableView *)tableView
                          cellViewModel:(CHChatViewModel *)viewModel
                            atIndexPath:(NSIndexPath *)indexPath{
    CHChatMessageViewModel *cellViewModel = viewModel.cellViewModels[indexPath.row];
    __block CHChatMessageCell *cell;
    [CHChatMessageCell registerNotificationRefresh:viewModel.refreshName];

    NSString *identifier = cellViewModel.isOwner?CHChatCellOwnerIdentifier:CHChatCellOthersIdentifier;
    [ChatCellMessageCatagory.allValues enumerateObjectsUsingBlock:^(Class  _Nonnull aClass, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([aClass messageCategory] == cellViewModel.category) {
            cell =  [tableView dequeueReusableCellWithIdentifier:[NSStringFromClass(aClass) stringByAppendingString:identifier] forIndexPath:indexPath];
            *stop = YES;
        }
    }];
    cell.iconCornerRadius = viewModel.configuration.iconCornerRadius;
    NSAssert(cell, @"没有注册和实现相应的CHChatMessageCell类型");
 
    return cell;

}
+ (NSString *)fetchMessageIdentifier:(__kindof CHChatTableView *)tableView
                       cellViewModel:(CHChatMessageViewModel *)cellViewModel{
    __block NSString *cellIdentifier ;
     NSString *identifier = cellViewModel.isOwner?CHChatCellOwnerIdentifier:CHChatCellOthersIdentifier;
    [ChatCellMessageCatagory.allValues enumerateObjectsUsingBlock:^(Class  _Nonnull aClass, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([aClass messageCategory] == cellViewModel.category) {
            cellIdentifier = [NSStringFromClass(aClass) stringByAppendingString:identifier];
            
            *stop = YES;
        }
    }];
    return cellIdentifier;
}
@end
