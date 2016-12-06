//
//  CHChatMessageImageVM.h
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"

@interface CHChatMessageFileVM : CHChatMessageViewModel<CHChatMessageViewModelProtocol>
/* 如果有http代表访问远程不是的话则是本地路径.*/
@property (nonatomic ,readonly) NSString *filePath;
/* 默认是100进度*/
@property (nonatomic ,readwrite) NSProgress *progress;

@property (nonatomic ,readonly) NSString *fileName;

- (BOOL)isLocalFile;

@end
