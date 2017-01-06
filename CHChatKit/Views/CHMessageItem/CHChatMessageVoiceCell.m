//
//  CHChatMessageVoiceCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageVoiceCell.h"
#import "CHChatMessageVoiceVM.h"
#import "Masonry.h"
#import "UIImage+CHImage.h"
#import "CHChatMessageVoiceVM.h"
#import "NSObject+KVOExtension.h"
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
  //  [self.messageContainer addSubview:self.unreadContainer];
  //  [self.unreadContainer.layer addSublayer:self.unreadLayer];
    [self.messageContainer addSubview:self.stateIndicatorView];
    [self ch_registerForKVO:[NSArray arrayWithObjects:@"viewModel.isOwner", @"viewModel.hasRead",@"viewModel.voiceState", nil]];

    if ([self isOwner]) {
        self.unreadContainer.hidden = YES;
        [ self.voiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            make.right.equalTo(self.messageContainer).offset(-12);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];

        [self.secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bubbleBtn.mas_centerY);
            make.width.equalTo(@25);
            make.right.equalTo(self.bubbleBtn.mas_left).offset(-3);
        }];

    }else{
        [ self.voiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            make.left.equalTo(self.messageContainer).offset(12);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];

        [self.secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            make.width.equalTo(@25);
            make.left.equalTo(self.bubbleBtn.mas_right).offset(3);
        }];
//        [self.unreadContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.messageContainer).offset(5);
//            make.height.equalTo(@10);
//            make.width.equalTo(@10);
//            make.left.equalTo(self.bubbleBtn.mas_right).offset(3);
//        }];
        
    }
}
- (void)updateConstraints{
    [super updateConstraints];
    CHChatMessageVoiceVM *voice = (CHChatMessageVoiceVM  *)self.viewModel;
    CGFloat width = MIN(50+self.contentView.frame.size.width/2/30*voice.length, 50+self.contentView.frame.size.width/2);
    if ([self isOwner]) {

        [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.height.greaterThanOrEqualTo(self.icon.mas_height);
            make.width.equalTo(@(width));
            make.left.equalTo(self.messageContainer).offset(0);
            make.right.equalTo(self.messageContainer).offset(0);
        }];
        
    }else{
        [self.bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.height.greaterThanOrEqualTo(self.icon.mas_height);
            make.width.equalTo(@(width));
            make.left.equalTo(self.messageContainer).offset(0);
            make.right.equalTo(self.messageContainer).offset(0);
            
        }];
    }
}
- (void)loadViewModel:(CHChatMessageVoiceVM *)viewModel{
    [super loadViewModel:viewModel];
    [self setAnimationImage];
    [self.bubbleBtn setBackgroundImage:[UIImage avaiableBubbleImage:viewModel.owner] forState:UIControlStateNormal];
    if ([viewModel isKindOfClass:[CHChatMessageVoiceVM class]]) {
    
        self.secondsLabel.text = [NSString stringWithFormat:@"%ld''", (long)viewModel.length];
    }else{
        NSAssert(NO, @"[CHChatMessageVoiceVM class] loadViewModel的类型有问题");
    }
    
}
- (void)setAnimationImage{
    NSString *voiceName = ({
        self.viewModel.owner ? @"SenderVoice":@"ReceiveVoice";
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
    [self.viewModel playVoice];
}

- ( __kindof CHChatMessageVoiceVM *)viewModel{
    return super.viewModel;
}
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

- (void)ch_ObserveValueForKey:(NSString *)key ofObject:(id)obj change:(NSDictionary *)change{
    [super ch_ObserveValueForKey:key ofObject:obj change:change];
    if ([key isEqualToString:@"viewModel.isOwner"]) {
        self.unreadContainer.hidden = [[change objectForKey:@"new"] boolValue];
    }else if ([key isEqualToString:@"viewModel.hasRead"]) {
        self.unreadContainer.hidden = [[change objectForKey:@"new"] boolValue];
    }else if ([key isEqualToString:@"viewModel.voiceState"]) {
         NSInteger state = [[change objectForKey:@"new"] integerValue];
        switch (state) {
            case CHVoicePlaying:
                [self.voiceImageView startAnimating];
                break;
            case CHVoiceFinish:
                [self.voiceImageView stopAnimating];
                break;
            case CHVoicePlayCancel:
                [self.voiceImageView stopAnimating];
                break;
                
            default:
                break;
        }
    }
}
-(void)dealloc{
    [self ch_unregisterFromKVO];

}
@end

