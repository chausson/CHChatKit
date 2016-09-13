//
//  CHChatToolView.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHChatToolView;
@protocol CHChatToolViewKeyboardProtcol <NSObject>
@optional
- (void)chatKeyboardWillShow;
- (void)chatKeyboardDidShow;
- (void)chatKeyboardWillHide;
- (void)chatKeyboardDidHide;
- (void)chatInputView;

- (void)sendMessage:(NSString *)text;
- (void)sendSound:(NSString *)path;
- (void)sendImage:(UIImage *)image;
@end
//@protocol CHChatToolDataProtcol <NSObject>
//@end
@interface CHChatToolView : UIView

- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;
/**
 * @brief 初始化toolView并设计观察对象
 * @return toolview实例对象
 */
- (instancetype)initWithObserver:(NSObject<CHChatToolViewKeyboardProtcol>*)object;
/**
 * @brief 是否隐藏键盘
 */
- (void)setKeyboardHidden:(BOOL)hidden;
/**
 * @brief 拓展事件调用
 */
- (void)assistanceActionWithIndex:(NSInteger )index
                         andBlock:(void (^)())block;
/**
 * @brief 在视图添加到父视图之后调用 约束布局
 */
- (void)autoLayoutView __attribute((deprecated("这个接口等实现约束以后再启用")));
@end
