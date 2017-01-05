//
//  CHChatMessagePacketCell.m
//  CHChatKit
//
//  Created by Chausson on 2017/1/4.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHChatMessagePacketCell.h"
#import "CHChatMessagePacketVM.h"
#import "CHMessagePacketEvent.h"
#import <XEBEventBus/XEBEventBus.h>
#import <Masonry/Masonry.h>
@implementation CHChatMessagePacketCell
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessagePacket;
}

- (void)layout{
    [super layout];
    [self.messageContainer addSubview:self.redPacketBtn];
    [self.redPacketBtn addSubview:self.blessingTitle];
    
    CGFloat gap = [self isOwner]?58:63;
    [self.blessingTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageContainer).offset(15);
        make.height.equalTo(@(20));
        make.left.equalTo(self.messageContainer).offset(gap);
        make.right.equalTo(self.messageContainer).offset(-5);
        
    }];
    [self.redPacketBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageContainer).offset(0);
        make.bottom.equalTo(self.messageContainer).offset(0);
        make.height.equalTo(@(90));
        make.width.equalTo(@(200));
        make.left.equalTo(self.messageContainer).offset(0);
        make.right.equalTo(self.messageContainer).offset(0);
    }];
}
- (void)updateConstraints{
    [super updateConstraints];

}
- (void)loadViewModel:(CHChatMessagePacketVM *)viewModel{
    [super loadViewModel:viewModel];
    self.blessingTitle.text = viewModel.blessing;
}
- ( __kindof CHChatMessagePacketVM *)viewModel{
    return super.viewModel;
}
- (void)packetAction:(UIButton *)sender{
    sender.alpha = 1;
    CHMessagePacketEvent *event = [CHMessagePacketEvent new];
    event.packetViewModel = self.viewModel;
    [[XEBEventBus defaultEventBus] postEvent:event];
}
- (void)packetActionHighlighted:(UIButton *)sender
{
    sender.alpha = 0.45;
}
- (void)packetActionOutside:(UIButton *)sender
{
    sender.alpha = 1;
}
- (UIButton *)redPacketBtn{
    if (!_redPacketBtn) {
        _redPacketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_redPacketBtn addTarget:self action:@selector(packetAction:) forControlEvents:UIControlEventTouchUpInside];
        [_redPacketBtn addTarget:self action:@selector(packetActionHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_redPacketBtn addTarget:self action:@selector(packetActionOutside:) forControlEvents:UIControlEventTouchDragOutside];
        if ([self isOwner]) {
            [_redPacketBtn setBackgroundImage:[UIImage imageNamed:@"RedPacket_Right"] forState:UIControlStateNormal];
        }else{
            [_redPacketBtn setBackgroundImage:[UIImage imageNamed:@"RedPacket_Left"] forState:UIControlStateNormal];
        }


    }
    return _redPacketBtn;
}
- (UILabel *)blessingTitle{
    if (!_blessingTitle) {
        _blessingTitle = [UILabel new];
        _blessingTitle.font = [UIFont systemFontOfSize:15];
        _blessingTitle.textColor = [UIColor whiteColor];

    }
    return _blessingTitle;
}
@end
