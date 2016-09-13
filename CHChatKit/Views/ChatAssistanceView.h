//
//  ChatAssistanceView.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/21.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatAssistanceView;
@protocol ChatAssistanceViewDelegate <NSObject>

- (void)didSelectedItem:(NSInteger )index;

@end
@interface ChatAssistanceView : UIView

@property (nonatomic ,weak) id <ChatAssistanceViewDelegate>delegate;

@end
