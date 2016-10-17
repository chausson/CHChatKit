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

@property (nonatomic ,readonly) NSArray <NSString *>* assistances;
@property (nonatomic ,assign) UIKeyboardAppearance keyboardAppearance;
@property (nonatomic ,assign) CGFloat iconCornerRadius; // default is zero
@property (nonatomic ,assign) BOOL allowRecordVoice;
@property (nonatomic ,assign) BOOL allowEmoji;
@property (nonatomic ,assign) BOOL allowAssistance;
@property (nonatomic ,assign) BOOL allowAudioServices;
@property (nonatomic ,assign) BOOL fitToNaviation; // 适配导航栏
@property (nonatomic ,assign) CHChatConversationType type;
/** 显示标题*/
@property (nonatomic ,copy ) NSString *title;

- (void)addAssistance:(NSString *)identifier;
- (void)addAssistances:(NSArray  <NSString *>*)identifiers;
- (void)removeAssistanceItem:(NSString *)identifier;
@end
