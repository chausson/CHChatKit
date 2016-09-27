//
//  CHChatMessageRegister.h
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHChatTableView;
@class CHChatMessageCell;
@class CHChatMessageViewModel;

@interface CHChatMessageHelper : NSObject
+ (void)registerCellForTableView:(CHChatTableView *)tableView;
+ (CHChatMessageCell *)fetchMessageCell:(__kindof CHChatTableView *)tableView
                          cellViewModel:(CHChatMessageViewModel *)vm
                            atIndexPath:(NSIndexPath *)indexPath;

+ (NSString *)fetchMessageIdentifier:(__kindof CHChatTableView *)tableView
                       cellViewModel:(CHChatMessageViewModel *)vm;

@end
