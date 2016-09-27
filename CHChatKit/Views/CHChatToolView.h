//
//  CHChatToolView.h
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CHChatConfiguration.h"
#import <UIKit/UIKit.h>
@class CHChatToolView;
@protocol CHKeyboardActivity <NSObject>
@optional
- (void)chatKeyboardWillShow;
- (void)chatKeyboardDidShow;
- (void)chatKeyboardWillHide;
- (void)chatKeyboardDidHide;
- (void)chatInputView;
@end
@protocol CHKeyboardEvent <NSObject>
- (void)sendMessage:(NSString *)text;
- (void)sendSound:(NSString *)path;
- (void)sendImage:(UIImage *)image;
@end

@interface CHChatToolView : UIView

@property (nonatomic , readonly) CHChatConfiguration *config;
- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;
/**
 * @brief 初始化toolView并设计观察对象
 * @return toolview实例对象
 */
- (instancetype)initWithObserver:(NSObject<CHKeyboardActivity,CHKeyboardEvent>*)object
                   configuration:(CHChatConfiguration *)config;
/**
 * @brief 是否隐藏键盘
 */
- (void)setKeyboardHidden:(BOOL)hidden;

/**
 * @brief 在视图添加到父视图之后调用 约束布局
 */
- (void)autoLayoutView __attribute((deprecated("这个接口等实现约束以后再启用")));

///**
// * @brief 拓展事件调用
// */
//- (void)assistanceActionWithIndex:(NSInteger )index
//                         andBlock:(void (^)())block;
@end
