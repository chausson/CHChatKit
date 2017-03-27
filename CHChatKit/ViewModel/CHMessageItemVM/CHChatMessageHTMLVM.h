//
//  CHChatMessageHTMLVM.h
//  Pods
//
//  Created by 黑眼圈 on 2017/2/21.
//
//

#import "CHChatMessageViewModel.h"

@interface CHChatMessageHTMLVM : CHChatMessageViewModel<CHChatMessageViewModelProtocol>

@property (nonatomic ,readonly) NSString *title;
@property (nonatomic ,readonly) NSString *content;
@property (nonatomic ,readonly) NSString *thumbnail;
@property (nonatomic ,readonly) NSString *url;


@end
