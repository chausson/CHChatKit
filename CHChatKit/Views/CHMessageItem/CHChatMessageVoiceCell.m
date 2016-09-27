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

#define WIDTHMIN 40
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

}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [self.bubbleBtn setBackgroundImage:[UIImage avaiableBubbleImage:viewModel.isOwner] forState:UIControlStateNormal];
    if (viewModel.owner) {
        [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@(WIDTHMIN));
            make.right.equalTo(self.messageContainer).offset(0);
        }];
        
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@30);
            make.right.equalTo(self.bubbleBtn.mas_left).offset(- 5);
        }];
    }else{
        [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@(WIDTHMIN));
            make.left.equalTo(self.messageContainer).offset(0);
        }];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@30);
            make.left.equalTo(self.bubbleBtn.mas_right).offset(5);
        }];
    }
    
}
- (UILabel *)time{
    if (!_time) {
        _time = [UILabel new];
        _time.font = [UIFont systemFontOfSize:15];
        _time.textColor = [UIColor grayColor];
    }
    return _time;
}
- (UIButton *)bubbleBtn{
    if (!_bubbleBtn) {
        _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _bubbleBtn;
}
@end
