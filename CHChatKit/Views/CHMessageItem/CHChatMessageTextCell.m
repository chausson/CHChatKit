//
//  CHChatMessageText.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageTextCell.h"
#import "CHChatMessageTextVM.h"
#import "UIImage+CHImage.h"
#import "NSString+CHExtensions.h"
#import "Masonry.h"

@implementation CHChatMessageTextCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageText;
}
- (void)layout{
    [self.messageContainer addSubview:self.bubbleBtn];
    [self.messageContainer addSubview:self.message];
    [super layout];
}
- (void)updateConstraints{
    [super updateConstraints];
    [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageContainer).offset(0);
        make.left.right.equalTo(self.messageContainer).offset(0);
        make.bottom.equalTo(self.messageContainer).offset(0);
    }];
    if ([self isOwner]){
        [self.message mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.left.equalTo(self.messageContainer).offset(15);
            make.right.equalTo(self.messageContainer).offset(-20);
            make.bottom.equalTo(self.messageContainer).offset(-5);
        }];
    }else{
        [self.message mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.left.equalTo(self.messageContainer).offset(20);
            make.right.equalTo(self.messageContainer).offset(-15);
            make.bottom.equalTo(self.messageContainer).offset(-5);
        }];
    }
    
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    [self.bubbleBtn setBackgroundImage:[UIImage avaiableBubbleImage:viewModel.isOwner] forState:UIControlStateNormal];
    if ([viewModel isKindOfClass:[CHChatMessageTextVM class]]) {
        CHChatMessageTextVM *vm = (CHChatMessageTextVM *)viewModel;
        self.message.text = [vm.content stringByReplacingEmojiCheatCodesWithUnicode];
    }else{
        NSAssert(NO, @"[CHChatMessageTextCell class] loadViewModel的类型有问题");
    }

}
#pragma mark 懒加载
- (UILabel *)message{
    if (!_message) {
        _message = [UILabel new];
        _message.numberOfLines = 0;
        if ([UIScreen mainScreen].bounds.size.width == 320) {
            _message.font = [UIFont systemFontOfSize:13];
        }else{
            _message.font = [UIFont systemFontOfSize:15];
        }

        _message.textColor = [UIColor blackColor];
        _message.backgroundColor = [UIColor clearColor];
    }
    return _message;
}
- (UIButton *)bubbleBtn{
    if (!_bubbleBtn) {
        _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bubbleBtn.backgroundColor = self.contentView.backgroundColor;
        
    }
    return _bubbleBtn;
}

@end
