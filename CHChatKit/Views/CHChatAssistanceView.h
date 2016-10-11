//
//  ChatAssistanceView.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/21.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHChatAssistanceView;
@class CHChatConfiguration;

@interface CHChatAssistanceView : UIView
@property (nonatomic ,weak) id observer;
@property (nonatomic ,strong) CHChatConfiguration *config;
@end
