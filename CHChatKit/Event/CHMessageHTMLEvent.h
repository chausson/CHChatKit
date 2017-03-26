//
//  CHMessageHTMLEvent.h
//  Pods
//
//  Created by 黑眼圈 on 2017/2/22.
//
//

#import "CHMessageEvent.h"
#import "CHChatMessageHTMLVM.h"

@interface CHMessageHTMLEvent : CHMessageEvent

@property(nonatomic,weak)CHChatMessageHTMLVM*  htmlViewModel;

@end
