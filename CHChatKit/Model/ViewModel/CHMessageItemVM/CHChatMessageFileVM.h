//
//  CHChatMessageImageVM.h
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"

@interface CHChatMessageFileVM : CHChatMessageViewModel
/* 如果有http代表访问远程不是的话则是本地路径.
 */
@property (nonatomic ,readonly) NSString *filePath;
@property (nonatomic ,readonly) CHMessageSendState state;
//@property (nonatomic ,readonly) NSPrgoress *progress;

- (BOOL)isLocalFile;

@end
