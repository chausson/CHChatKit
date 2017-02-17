//
//  CHChatInputView.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CHChatViewModel.h"
#import <UIKit/UIKit.h>
@class CHChatInputView;
@protocol CHKeyboardActivity <NSObject>
@optional
- (void)chatKeyboardWillShow;
- (void)chatKeyboardDidShow;
- (void)chatKeyboardWillHide;
- (void)chatKeyboardDidHide;
- (void)chatInputView;
@end
/* 废弃该代理方法发送内容，通过EventBus 发送 */

@protocol CHKeyboardEvent <NSObject>
- (void)sendMessage:(NSString *)text;
- (void)sendSound:(NSString *)path
           second:(NSInteger )sec;
- (void)sendOriginPath:(NSString *)path
                 photo:(UIImage *)image;
@end

@interface CHChatInputView : UIView
//@property (nonatomic , assign) BOOL editableState; // 默认为NO，YES显示正在输入的状态

@property (nonatomic , readonly) CHChatViewModel *viewModel;
- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;
/**
 * @brief 初始化toolView并设计观察对象
 * @return toolview实例对象
 */
- (instancetype)initWithObserver:(NSObject<CHKeyboardActivity>*)object
                       viewModel:(CHChatViewModel *)viewModel;
/**
 * @brief 是否隐藏键盘,如果不隐藏显示正在输入的状态
 */
- (void)setKeyboardHidden:(BOOL)hidden;


@end
