//
//  CHChatMessageVoiceCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageVoiceCell.h"
#import "Masonry.h"
#import "UIImage+CHImage.h"
#import "CHChatMessageVoiceVM.h"

#define WIDTHMIN 50


@implementation CHChatMessageVoiceCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageVoice;
}
- (void)layout{
    [super layout];
    [self.messageContainer addSubview:self.bubbleBtn];
    [self.messageContainer addSubview:self.time];
}
- (void)updateConstraints{
    [super updateConstraints];
    if ([self.viewModel isKindOfClass:[CHChatMessageVoiceVM class]]) {
        CHChatMessageVoiceVM *vm = (CHChatMessageVoiceVM *)self.viewModel;
        CGFloat width = self.contentView.frame.size.width / 2;
        if (vm.owner) {
            [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messageContainer).offset(5);
                make.bottom.equalTo(self.messageContainer).offset(0);
                make.width.equalTo(@(WIDTHMIN + width / 60 * vm.length));
                make.right.equalTo(self.messageContainer).offset(0);
            }];
            
            [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messageContainer).offset(5);
                make.bottom.equalTo(self.messageContainer).offset(0);
                make.width.equalTo(@25);
                make.right.equalTo(self.bubbleBtn.mas_left).offset(0);
            }];
        }else{
            [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messageContainer).offset(5);
                make.bottom.equalTo(self.messageContainer).offset(0);
                make.width.equalTo(@(WIDTHMIN + width / 60 * vm.length));
                make.left.equalTo(self.messageContainer).offset(0);
            }];
            [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messageContainer).offset(5);
                make.bottom.equalTo(self.messageContainer).offset(0);
                make.width.equalTo(@25);
                make.left.equalTo(self.bubbleBtn.mas_right).offset(0);
            }];
        }
    }
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    [self.bubbleBtn setBackgroundImage:[UIImage avaiableBubbleImage:viewModel.isOwner] forState:UIControlStateNormal];
    if ([viewModel isKindOfClass:[CHChatMessageVoiceVM class]]) {
        CHChatMessageVoiceVM *vm = (CHChatMessageVoiceVM *)viewModel;
        self.time.text = [NSString stringWithFormat:@"%ld''", vm.length];
    }else{
        NSAssert(NO, @"[CHChatMessageVoiceVM class] loadViewModel的类型有问题");
    }
}
- (UILabel *)time{
    if (!_time) {
        _time = [UILabel new];
        _time.font = [UIFont systemFontOfSize:13];
        _time.textColor = [UIColor grayColor];
    }
    return _time;
}
- (UIButton *)bubbleBtn{
    if (!_bubbleBtn) {
        _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bubbleBtn addTarget:self action:@selector(ddd) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _bubbleBtn;
}
- (void)ddd{
    NSLog(@"123123");
}
@end
