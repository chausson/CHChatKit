//
//  CHChatConfiguration.h
//
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHChatDefinition.h"


@interface CHChatConfiguration : NSObject

+ (CHChatConfiguration *)defultConfigruration;

@property (nonatomic ,strong) UIColor *mainBackground;
@property (nonatomic ,strong) UIColor *toolContentBackground;
@property (nonatomic ,strong) UIColor *toolInputViewBackground;

@property (nonatomic ,readonly) NSArray <Class>* assistances;
@property (nonatomic ,assign) UIKeyboardAppearance keyboardAppearance;
/* default is zero */
@property (nonatomic ,assign) CGFloat iconCornerRadius;
@property (nonatomic ,assign) BOOL allowRecordVoice;
@property (nonatomic ,assign) BOOL allowEmoji;
@property (nonatomic ,assign) BOOL allowAssistance;
/* 开始接受消息震动*/
@property (nonatomic ,assign) BOOL allowDeviceShock;
/* 开始接受消息声音*/
@property (nonatomic ,assign) BOOL allowDeviceTone;
/* 适配导航栏*/
@property (nonatomic ,assign) BOOL fitToNaviation;
@property (nonatomic ,assign) CHChatConversationType type;
/** 显示标题*/
@property (nonatomic ,copy ) NSString *title;

- (void)addAssistance:(Class )aClass; // 添加插件
- (void)addAssistances:(NSArray  <Class >*)identifiers;
- (void)removeAssistanceItem:(Class )aClass;
@end
