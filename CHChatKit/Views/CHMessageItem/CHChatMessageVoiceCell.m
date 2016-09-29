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
#import "NSObject+KVOExtension.h"
#define WIDTHMIN 50
@interface CHChatMessageVoiceCell()
@property (strong ,nonatomic ) UIView *unreadContainer;
@property (strong ,nonatomic ) CAShapeLayer *unreadLayer;
@end
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
    [self.messageContainer addSubview:self.secondsLabel];
    [self.messageContainer addSubview:self.bubbleBtn];
    [self.messageContainer addSubview:self.voiceImageView];
    [self.messageContainer addSubview:self.unreadContainer];
    [self.unreadContainer.layer addSublayer:self.unreadLayer];
    [self.messageContainer addSubview:self.stateIndicatorView];
    [self ch_registerForKVO];

    
    if ([self isOwner]) {
        [ self.voiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageContainer);
            make.right.equalTo(self.messageContainer).offset(-12);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];

        [self.secondsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@25);
            make.height.equalTo(@40);
            make.right.equalTo(self.bubbleBtn.mas_left).offset(-3);
        }];
        
        [self.stateIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@25);
            make.right.equalTo(self.bubbleBtn.mas_left).offset(-3);
        }];
    }else{
        [ self.voiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageContainer);
            make.left.equalTo(self.messageContainer).offset(12);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];

        [self.secondsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@25);
            make.left.equalTo(self.bubbleBtn.mas_right).offset(3);
        }];
        [self.unreadContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(5);
            make.height.equalTo(@10);
            make.width.equalTo(@10);
            make.left.equalTo(self.bubbleBtn.mas_right).offset(3);
        }];
        
    }

}
- (void)updateConstraints{
    [super updateConstraints];
    CHChatMessageVoiceVM *vm = (CHChatMessageVoiceVM *)self.viewModel;
    CGFloat width = 50+self.contentView.frame.size.width/2/60*vm.length;
    if ([self isOwner]) {

        [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@(width));
            make.left.equalTo(self.messageContainer).offset(0);
            make.right.equalTo(self.messageContainer).offset(0);
        }];
        
    }else{
        [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.width.equalTo(@(width));
            make.left.equalTo(self.messageContainer).offset(0);
            make.right.equalTo(self.messageContainer).offset(0);
            
        }];
    }
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    [self setAnimationImage];
    [self.bubbleBtn setBackgroundImage:[UIImage avaiableBubbleImage:viewModel.isOwner] forState:UIControlStateNormal];
    if ([viewModel isKindOfClass:[CHChatMessageVoiceVM class]]) {
        CHChatMessageVoiceVM *vm = (CHChatMessageVoiceVM *)viewModel;
        self.secondsLabel.text = [NSString stringWithFormat:@"%ld''", vm.length];
    }else{
        NSAssert(NO, @"[CHChatMessageVoiceVM class] loadViewModel的类型有问题");
    }
    
}
- (void)setAnimationImage{
    NSString *voiceName = ({
        self.viewModel.isOwner ? @"SenderVoice":@"ReceiveVoice";
    });
    
    self.voiceImageView.image = [UIImage imageNamed:voiceName];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < 4; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"%@00%ld",voiceName, (long)i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image)
            [images addObject:image];
    }
    self.voiceImageView.animationImages = images;
    self.voiceImageView.animationDuration = 1.0;
    [self.voiceImageView stopAnimating];
}
- (void)play:(UIButton *)sender{
    [self.voiceImageView startAnimating];
    //FIX ME OWNER 点击没反应  地图的一样
    CHChatMessageVoiceVM *vm = (CHChatMessageVoiceVM *)self.viewModel;
    [vm playVoice];
    NSLog(@"play");
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}
- (UIImageView *)voiceImageView{
    if (!_voiceImageView) {
        _voiceImageView = [UIImageView new];
    }
    return _voiceImageView;
}
- (UILabel *)secondsLabel{
    if (!_secondsLabel) {
        _secondsLabel = [UILabel new];
        _secondsLabel.font = [UIFont systemFontOfSize:13];
        _secondsLabel.textColor = [UIColor grayColor];
    }
    return _secondsLabel;
}
- (UIButton *)bubbleBtn{
    if (!_bubbleBtn) {
        _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bubbleBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bubbleBtn;
}
- (UIView *)unreadContainer{
    if (!_unreadContainer) {
        _unreadContainer = [[UIView alloc]init];
        _unreadContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _unreadContainer;
}
- (CAShapeLayer *)unreadLayer{
    if (!_unreadLayer) {
        _unreadLayer = [CAShapeLayer new];
        _unreadLayer.backgroundColor = [UIColor redColor].CGColor;
        _unreadLayer.bounds = CGRectMake(0, 0, 8, 8);
        _unreadLayer.anchorPoint = CGPointMake(0, 0.5);
        _unreadLayer.cornerRadius = 8/2;
    }
    return _unreadLayer;
}
- (UIActivityIndicatorView *)stateIndicatorView{
    if (!_stateIndicatorView) {
        _stateIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    }
    return _stateIndicatorView;
}
- (NSArray *)ch_registerKeypaths
{
    //    CHChatMessageVoiceVM *vm = (CHChatMessageVoiceVM *)self.viewModel;
    return [NSArray arrayWithObjects:@"viewModel.isOwner", @"viewModel.hasRead" , nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"viewModel.state"]) {
        NSInteger state = [[change objectForKey:@"new"] integerValue];
        if (state == 1) {
            [self.stateIndicatorView startAnimating];
        }else{
            [self.stateIndicatorView stopAnimating];
        }
    }
    if ([keyPath isEqualToString:@"viewModel.isOwner"]) {
        self.unreadContainer.hidden = [[change objectForKey:@"new"] boolValue];
    }
    if ([keyPath isEqualToString:@"viewModel.hasRead"]) {
        self.unreadContainer.hidden = [[change objectForKey:@"new"] boolValue];
    }
}
-(void)dealloc{
    [self ch_unregisterFromKVO];
    
}
@end

