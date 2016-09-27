//
//  CHChatConfiguration.h
//
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHChatDefinition.h"

@interface CHAssistanceItem : NSObject

@property (copy ,nonatomic) NSString *iconTitle;
@property (copy ,nonatomic) NSString *iconImageName;
@property (assign ,nonatomic) CHAssistanceType itemType;
@end

@interface CHChatConfiguration : NSObject

+ (CHChatConfiguration *)defultConfigruration;

@property (nonatomic ,strong) UIColor *mainBackground;
@property (nonatomic ,strong) UIColor *toolContentBackground;
@property (nonatomic ,strong) UIColor *toolInputViewBackground;
@property (nonatomic ,readonly) NSArray <CHAssistanceItem *>* assistanceItems;
@property (nonatomic ,assign) UIKeyboardAppearance keyboardAppearance;
@property (nonatomic ,assign) CGFloat iconCornerRadius; // default is zero
@property (nonatomic ,assign) BOOL allowRecordVoice;
@property (nonatomic ,assign) BOOL allowEmoji;
@property (nonatomic ,assign) BOOL allowAssistance;
@property (nonatomic ,assign) BOOL fitToNaviation; // 适配导航栏
@property (nonatomic ,assign) CHChatConversationType type;

- (void)addAssistanceItem:(CHAssistanceType )item;
- (void)addAssistanceItems:(NSArray  <NSNumber *>*)items;
- (void)removeAssistanceItem:(CHAssistanceType )item;
@end
