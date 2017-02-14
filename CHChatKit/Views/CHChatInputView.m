//
//  CHChatInputView.m
//  CHChatDemo
//
//  Created by Chasusson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#define KASSIGANTVIEW_HEIGHT 216
#define KBUTTON_SIZE 35
#define KGAP 5
#define CHATTOOL_FILE_NAME @"ChatResourse"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "CHMessageDatabase.h"
#import "CHChatInputView.h"
#import "CHChatAssistanceView.h"
#import "CHChatViewModel.h"
#import "CHRecordHandler.h"
#import "CHMessageTextEvent.h"
#import "CHMessageVoiceEvent.h"
#import "CHChatViewController.h"
#import "XEBEventBus.h"
#import "UUProgressHUD.h"
#import "CHFaceBoard.h"
#import "NSString+CHExtensions.h"
#import "Masonry.h"
#import "UIImage+CHImage.h"

typedef NS_ENUM(NSUInteger, CHChatInputViewState) {
    CHChatSelectedNone,
    CHChatSelectedText,
    CHChatSelectedEmoji,
    CHChatSelectedVoice,
    CHChatSelectedAssistance
};

static NSString *const bundleName = @"CHChatImage";
static CGFloat const CHTextViewMinHeight = 34.f;
static CGFloat const CHTextViewMaxHeight = 102.f;
@interface CHChatInputView ()<UITextViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate,CHFaceBoardDelegate>
@property (strong ,nonatomic) CHChatAssistanceView *assistanceView;
@property (strong ,nonatomic) CHFaceBoard *faceBoard;
@property (strong ,nonatomic) UIImageView *backgroundView;
@property (strong ,nonatomic) UIButton *messageBtn;
@property (strong ,nonatomic) UIButton *moreItemBtn;
@property (strong ,nonatomic) UIButton *emojiBtn;
@property (strong ,nonatomic) UIButton *talkBtn;
@property (strong ,nonatomic) UIView *chatWindowView;
@property (strong ,nonatomic) UITextView *contentTextView;
@property (strong ,nonatomic) NSString *cacheInputText;

@property (weak   ,nonatomic) NSObject<CHKeyboardActivity> *observer;
@property (assign ,nonatomic) CGRect hiddenKeyboardRect;
@property (assign ,nonatomic) CGSize keyboardSize;
@property (assign ,nonatomic) CGRect showkeyboardRect;
@property (assign ,nonatomic) CHChatInputViewState currentState;// 聊天工具当前选择的按钮
@property (assign ,nonatomic) CGFloat currentScreenHeight;// 当前页面高度
@property (assign ,nonatomic) CGFloat lastTextHeight;// 上次聊天输入框高度


@end
@implementation CHChatInputView

#define imageNamed(name) [UIImage imageNamed:name inBundle:bundleName]

- (instancetype)initWithObserver:(NSObject<CHKeyboardActivity>*)object
                       viewModel:(CHChatViewModel *)viewModel{
    self = [super init];
    if (self) {

         self.currentScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
        if (object) {
            _observer = object;
        }
        if (viewModel) {
            _viewModel = viewModel;
        }
        if (!_viewModel.configuration.fitToNaviation) {
            self.currentScreenHeight -= 64;
        }

        self.backgroundColor = _viewModel.configuration.toolContentBackground;
        [self addSubviewsAndAutoLayout];
        [self maekConstaints];
        [self registerForKeyboardNotifications];

    }
    return self;
}
#pragma mark Layoutsubviews

//- (void)didMoveToSuperview{
//    [super didMoveToSuperview];
//    
//}

- (void)addSubviewsAndAutoLayout{
    [self.chatWindowView addSubview:self.talkBtn];
    [self.chatWindowView addSubview:self.messageBtn];
    [self.chatWindowView addSubview:self.moreItemBtn];
    [self.chatWindowView addSubview:self.emojiBtn];
    [self.chatWindowView addSubview:self.contentTextView];
    [self addSubview:self.chatWindowView];
    [self addSubview:self.assistanceView];
    [self addSubview:self.faceBoard];

}
- (void)maekConstaints{
    CGFloat messageWH = _viewModel.configuration.allowRecordVoice?KBUTTON_SIZE:0;
    CGFloat emojiWH = _viewModel.configuration.allowEmoji?KBUTTON_SIZE:0;
    CGFloat assisatanceWH = _viewModel.configuration.allowAssistance?KBUTTON_SIZE:0;
    UIEdgeInsets talkPadding = UIEdgeInsetsMake(KGAP, KGAP, KGAP, KGAP);
    
    [self.talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.with.insets(talkPadding);
    }];

    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KGAP);
        make.bottom.equalTo(self.chatWindowView).offset(-KGAP*1.5);
        make.height.and.width.equalTo(@(messageWH));
    }];
    [self.moreItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.messageBtn.mas_bottom);
        make.height.and.width.equalTo(@(assisatanceWH));
        make.right.equalTo(self).offset(-KGAP);
    }];
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.messageBtn.mas_bottom);
        make.height.and.width.equalTo(@(emojiWH));
        make.right.equalTo(self.moreItemBtn.mas_left).offset(-KGAP);
    }];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, KGAP, 0, KGAP);

    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageBtn.mas_right).with.offset(KGAP);
        make.right.equalTo(self.emojiBtn.mas_left).with.offset(-KGAP);
        make.top.equalTo(self.chatWindowView).with.offset(KGAP+3);
        make.bottom.equalTo(self.chatWindowView).with.offset(-KGAP-3);
        make.height.mas_greaterThanOrEqualTo(CHTextViewMinHeight);
    }];

    [self.assistanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatWindowView.mas_bottom).with.offset(0);
        make.left.and.right.offset(0);
        make.height.mas_equalTo(KASSIGANTVIEW_HEIGHT);
        
    }];
    [self.chatWindowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self).priorityLow();
    }];
    [self.faceBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatWindowView.mas_bottom).with.offset(0);
        make.left.and.right.offset(0);
        make.height.mas_equalTo(KASSIGANTVIEW_HEIGHT);
        
    }];
    
}
#pragma mark 注册通知
- (void)registerForKeyboardNotifications{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}
#pragma mark 键盘显示的监听方法
-(void)keyboardWillShow:(NSNotification *)notif
{
    // 获取键盘的位置和大小
    self.keyboardSize = [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    if (self.keyboardSize.height == 0) {
        return;
    }
    self.currentState = CHChatSelectedText;
//    [self movePostionWithY:height duration:[duration doubleValue] curve:[curve intValue]];
    if ([_observer respondsToSelector:@selector(chatKeyboardWillShow)]) {
        [_observer chatKeyboardWillShow];
    }
}
- (void)keyboardDidShow:(NSNotification *) note{
    if ([_observer respondsToSelector:@selector(chatKeyboardDidShow)]) {
        [_observer chatKeyboardDidShow];
    }
}
#pragma mark 键盘隐藏的监听方法
-(void)keyboardWillHide:(NSNotification *)note
{
    
    self.keyboardSize = CGSizeZero;
    [self updateInputViewConstraints];
    if ([_observer respondsToSelector:@selector(chatKeyboardWillHide)]) {
        [_observer chatKeyboardWillHide];
    }

}
- (void)keyboardDidHide:(NSNotification *) note{
    
    if ([_observer respondsToSelector:@selector(chatKeyboardDidHide)]) {
        [_observer chatKeyboardDidHide];
    }
}
#pragma mark faceDelegat
//点击表情返回的字符
-(void)clickFaceBoard:(NSString *)string
{
    self.contentTextView.text = [NSString stringWithFormat:@"%@%@",self.contentTextView.text,string];
    
}

#pragma mark Button_Action
- (void)messageAction:(UIButton *)sender{
    if (sender.selected) {
        // 语音输入
        self.currentState = CHChatSelectedText;
    
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        sender.selected = NO;
        //选中状态事件
    }else{
        // 文字输入
        self.currentState = CHChatSelectedVoice;
   
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        //未选中状态事件
        sender.selected = YES;
    }
    
}

- (void)moreItemAction:(UIButton *)sender{
    if (sender.selected) {
        self.currentState = CHChatSelectedText;
        sender.selected = NO;
    }else{
        self.currentState = CHChatSelectedAssistance;
        sender.selected = YES;
    }
}

- (void)emojiAction:(UIButton *)sender{

    if (sender.selected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        sender.selected = NO;
        self.currentState = CHChatSelectedText;

    }else{
   
        [sender setBackgroundImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        sender.selected = YES;
        self.currentState = CHChatSelectedEmoji;

    }


}

#pragma mark Private
- (void)setCurrentState:(CHChatInputViewState)currentState{
    _currentState = currentState;
    switch (currentState) {
        case CHChatSelectedText:
            [self.contentTextView  becomeFirstResponder];
            break;
        case CHChatSelectedAssistance:
            self.contentTextView.hidden = FALSE;
            self.talkBtn.hidden = TRUE;
            self.emojiBtn.selected = FALSE;
            self.messageBtn.selected = FALSE;
            self.faceBoard.hidden = TRUE;
            self.assistanceView.hidden = FALSE;
            [self.contentTextView resignFirstResponder];
            break;
        case CHChatSelectedVoice:
            self.contentTextView.hidden = TRUE;
            self.talkBtn.hidden = FALSE;
            self.emojiBtn.selected = FALSE;
            self.moreItemBtn.selected = FALSE;
            [self setKeyboardHidden:TRUE];
            break;
        case CHChatSelectedEmoji:
            [self.contentTextView resignFirstResponder];
            self.contentTextView.hidden = FALSE;
            self.talkBtn.hidden = TRUE;
            self.moreItemBtn.selected = FALSE;
            self.messageBtn.selected = FALSE;
            self.faceBoard.hidden = FALSE;
            self.assistanceView.hidden = FALSE;
            break;
        case CHChatSelectedNone:
            [self.contentTextView resignFirstResponder];
            self.contentTextView.hidden = FALSE;
            self.talkBtn.hidden = TRUE;
            self.emojiBtn.selected = FALSE;
            self.moreItemBtn.selected = FALSE;
            break;
        default:
            break;
    }
    [self updateInputViewConstraints];
    
    if ([_observer respondsToSelector:@selector(chatInputView)]) {
        [_observer chatInputView];
    }

}
- (void)updateInputViewConstraints{
    CGFloat outputHeight = KASSIGANTVIEW_HEIGHT;
    CGFloat keyboardHeight = self.keyboardSize.height;
    CGFloat inputViewHeight = self.chatWindowView.frame.size.height;
    switch (self.currentState) {
        case CHChatSelectedText:
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-keyboardHeight);
            }];
            break;
        case CHChatSelectedAssistance:{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-outputHeight);
            }];
            [self.faceBoard mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            [self.assistanceView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.chatWindowView.mas_bottom).offset(0);
                make.height.mas_equalTo(outputHeight);

            }];
        }break;
        case CHChatSelectedVoice:
            
            [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(CHTextViewMinHeight);
            }];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
            return;
            break;
        case CHChatSelectedEmoji:{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-outputHeight);
            }];
            [self.assistanceView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            [self.faceBoard mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.chatWindowView.mas_bottom).offset(0);
                make.height.mas_equalTo(outputHeight);

            }];
        }break;
        case CHChatSelectedNone:
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-(keyboardHeight));
            }];
            break;
        default:
            break;
    }
    if (self.currentState != CHChatSelectedNone) {
        [self textViewDidChangeFitInpuViewHegiht:self.contentTextView shouldCache:NO];

    }

    [UIView animateWithDuration:.3f animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}


#pragma mark 声音处理
- (void)startRecord:(UIButton *)button{
    [UUProgressHUD show];
    // 1.获取沙盒地址
    [[CHRecordHandler standardDefault] startRecording];
    
}

- (void)endRecordVoice:(UIButton *)button
{
   NSString *filePath = [[CHRecordHandler standardDefault] stopRecording];
    [UUProgressHUD dismissWithSuccess:nil];
//    NSLog(@"endrecord=%g",self.recordTime);
    if ([CHRecordHandler standardDefault].recordSecs < 1) {
        [UUProgressHUD dismissWithError:@"时间太短"];
        [[CHRecordHandler standardDefault] destory];
        return;
    }
    CHMessageVoiceEvent *e = [CHMessageVoiceEvent new];
    e.file = filePath;
    e.fileName = [NSString stringWithFormat:@"CHVoice_%@",[[NSDate date] description]];
    if([_observer isKindOfClass:[CHChatViewController class]]){
        CHChatViewModel *vm = [(CHChatViewController *)_observer valueForKey:@"viewModel"];
        e.receiverId = vm?vm.receiveId:0;
        e.userId = vm?vm.userId:0;
        e.groupId = vm?vm.groupId:0;
    }

    e.length = [CHRecordHandler standardDefault].recordSecs;
    [[XEBEventBus defaultEventBus] postEvent:e];
}

- (void)cancelRecordVoice:(UIButton *)button
{
    [[CHRecordHandler standardDefault] destory];
    [UUProgressHUD dismissWithError:@"取消"];
}

- (void)remindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"松开取消发送"];
}

- (void)remindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"向上滑动,取消发送"];
}

#pragma mark Public
- (void)setKeyboardHidden:(BOOL)hidden{
    if(hidden){
        self.emojiBtn.selected = FALSE;
        self.messageBtn.selected =FALSE;
        self.moreItemBtn.selected = FALSE;
        self.keyboardSize = CGSizeZero;
        [self.contentTextView resignFirstResponder];

    }else{
        [self.contentTextView becomeFirstResponder];
    }
    [self updateInputViewConstraints];
}




#pragma mark TextView_Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //按下send 键
    
    if ([text isEqualToString:@"\n"]) {
        [self sendText];
        
        return NO;
    } else if ([text isEqualToString:@"@"]) {
       //TO DO 发送@Event 事件
        return YES;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    
    [self textViewDidChangeFitInpuViewHegiht:textView shouldCache:YES];
    if([_observer isKindOfClass:[CHChatViewController class]]){
        if (self.viewModel.dataBase) {
            [self.viewModel.dataBase saveAndUpdateDraft:textView.text receive:(int)_viewModel.receiveId group:self.viewModel.groupId];
        }
    }

}
- (void)textViewDidChangeFitInpuViewHegiht:(UITextView *)textView
                               shouldCache:(BOOL)cache{

    CGRect textViewFrame = self.contentTextView.frame;
    CGSize textSize = [self.contentTextView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    textView.scrollEnabled = (textSize.height > CHTextViewMinHeight);
    CGFloat newTextViewHeight = MAX(CHTextViewMinHeight, MIN(CHTextViewMaxHeight, textSize.height));
    BOOL textViewHeightChanged = (self.lastTextHeight != newTextViewHeight);
    if (textViewHeightChanged || !cache) {
        self.lastTextHeight = newTextViewHeight;
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat height = newTextViewHeight;
            make.height.mas_equalTo(height);
        }];
        //        [self :YES];
    }
    if (textView.scrollEnabled ) {
        if (newTextViewHeight == CHTextViewMaxHeight) {
            [textView setContentOffset:CGPointMake(0, textView.contentSize.height - newTextViewHeight) animated:YES];
        } else {
            [textView setContentOffset:CGPointZero animated:YES];
        }
    }
    
}
- (void)sendText{
    if (self.contentTextView.text.length > 0) {
        CHMessageTextEvent *e = [CHMessageTextEvent new];
        e.groupId = _viewModel.groupId;
        e.text = self.contentTextView.text;
        e.receiverId = _viewModel.receiveId;
        e.userId = _viewModel.userId;
        [[XEBEventBus defaultEventBus] postEvent:e];
        
        if ([_observer conformsToProtocol:@protocol(CHKeyboardEvent)] && [_observer respondsToSelector:@selector(sendMessage:)]) {
            [_observer performSelector:@selector(sendMessage:) withObject:self.contentTextView.text];
        }
        if (self.viewModel.dataBase) {
            [self.viewModel.dataBase deleteDraftWithReceive:self.viewModel.receiveId];

        }

        self.contentTextView.text = nil;
    }
}
- (void)sendFaceMessage
{
    [self sendText];
}
#pragma mark - 点击删除键 判断如果是表情 就删除表情字符
- (void)cancelFaceMessage{
    [self deleteEmojiString];
}
/**
 *  光标位置删除
 */
- (void)deleteEmojiString{
    NSRange range = self.contentTextView.selectedRange;

    if (self.contentTextView.text.length > 0) {
        NSUInteger location  = self.contentTextView.selectedRange.location;
        NSString *head = [self.contentTextView.text substringToIndex:location];
        if (range.length ==0) {
            
        }else{
            self.contentTextView.text =@"";
        }
        
        if (location > 0) {
            //            NSUInteger location  = self.inputView.toolBar.textView.selectedRange.location;
            NSMutableString *str = [NSMutableString stringWithFormat:@"%@",self.contentTextView.text];
            [self lastRange:head];

            
            [str deleteCharactersInRange:[self lastRange:head]];
            
            self.contentTextView.text = str;
            self.contentTextView.selectedRange = NSMakeRange([self lastRange:head].location,0);
            
        } else {
            self.contentTextView.selectedRange = NSMakeRange(0,0);
        }
    }
}
/**
 *  计算选中的最后一个是字符还是表情所占长度
 *
 *  @param str 要计算的字符串
 *
 *  @return 返回一个 NSRange
 */
- (NSRange)lastRange:(NSString *)str {
    NSRange lastRange = [str rangeOfComposedCharacterSequenceAtIndex:str.length-1];
    return lastRange;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.emojiBtn.selected =  NO;
    self.moreItemBtn.selected = NO;
    self.contentTextView.hidden = FALSE;
    self.talkBtn.hidden = TRUE;
    return YES;
}
#pragma mark Lazy
- (UIButton *)emojiBtn{
    if (!_emojiBtn) {
        _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiBtn setBackgroundImage:imageNamed(@"ToolViewEmotion") forState:UIControlStateNormal];
        [_emojiBtn setBackgroundImage:imageNamed(@"ToolViewKeyboard") forState:UIControlStateSelected];
        [_emojiBtn setBackgroundImage:imageNamed(@"ToolViewEmotionHL") forState:UIControlStateHighlighted];
        [_emojiBtn addTarget:self action:@selector(emojiAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiBtn;
}
- (CHFaceBoard *)faceBoard{
    if (!_faceBoard) {
        _faceBoard = [[CHFaceBoard alloc] init];
        _faceBoard.delegate = self;
//        _faceBoard.backgroundColor = self.backgroundColor;
    }
    return _faceBoard;
}
- (CHChatAssistanceView *)assistanceView{
    if (!_assistanceView) {
        _assistanceView = [[CHChatAssistanceView alloc] init];
        _assistanceView.observer = _observer;
        _assistanceView.config = _viewModel.configuration;
        _assistanceView.backgroundColor = self.backgroundColor;
    }
    
    return _assistanceView;
}
- (UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setBackgroundImage:imageNamed(@"ToolViewInputVoice") forState:UIControlStateNormal];
        [_messageBtn setBackgroundImage:imageNamed(@"ToolViewKeyboard") forState:UIControlStateSelected];
        [_messageBtn setBackgroundImage:imageNamed(@"ToolViewInputVoiceHL") forState:UIControlStateHighlighted];
        [_messageBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}
- (UIButton *)moreItemBtn{
    if (!_moreItemBtn) {
        _moreItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreItemBtn setBackgroundImage:imageNamed(@"mail_add_normal") forState:UIControlStateNormal];
        [_moreItemBtn addTarget:self action:@selector(moreItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreItemBtn;
}
- (UIView *)chatWindowView{
    if (!_chatWindowView) {
        _chatWindowView = [[UIView alloc]init];

    }
    return _chatWindowView;
}
- (UIButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_talkBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [_talkBtn setTitle:@"松开结束" forState:UIControlStateHighlighted];
        [_talkBtn setTitleColor:[UIColor colorWithRed:65.0/ 255.0 green:65.0/255.0 blue:65.0 /255.0  alpha:1] forState:UIControlStateNormal];
        [_talkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _talkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_talkBtn setBackgroundColor:[UIColor clearColor]];
        
        [_talkBtn addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchDown];
        [_talkBtn addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [_talkBtn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_talkBtn addTarget:self action:@selector(remindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [_talkBtn addTarget:self action:@selector(remindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        
        [_talkBtn setHidden:TRUE];
    }
    return _talkBtn;
}
- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc]init];
//        _contentTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 0, 0.0f);
        _contentTextView.font = [UIFont systemFontOfSize:16.0f];
        _contentTextView.delegate = self;
        _contentTextView.layer.cornerRadius = 4.0f;
        _contentTextView.textColor = self.viewModel.configuration.inputViewTextFieldTextColor;
        _contentTextView.backgroundColor = self.viewModel.configuration.inputViewTextFieldBackgroundColor;
        _contentTextView.layer.borderColor = [UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1.0f].CGColor;
        _contentTextView.returnKeyType = UIReturnKeySend;
        _contentTextView.layer.borderWidth = .5f;
        _contentTextView.layer.masksToBounds = YES;
        _contentTextView.scrollsToTop = NO;
        _contentTextView.keyboardAppearance = _viewModel.configuration.keyboardAppearance;
        _contentTextView.text = _viewModel.draft;

    }
    return _contentTextView;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
