//
//  CHChatCellViewModel.m
//  CHChatDemo
//
//  Created by XiaoSong on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#define kMargin 10 // 间隔
#define KIconWH 40 // 头像高度
#define KContentW 180 // 内容宽度

#define KTimeMarginW 15
#define KTimeMarginH 10

#define KContentTop 10
#define KcontentLeft 25
#define KContentBottom 15
#define KContentRight 15

#define KTimeFont [UIFont systemFontOfSize:12]
#define KContentFont [UIFont systemFontOfSize:16]
#define FACE_NAME_HEAD  @"/s"
// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   5
#import "CHChatCellViewModel.h"

#import <AVFoundation/AVFoundation.h>
@interface CHChatCellViewModel ()<AVAudioPlayerDelegate>
@property (strong ,nonatomic)AVAudioPlayer *audioPlayer;
@end

@implementation CHChatCellViewModel
- (instancetype)initWithModel:(CHChatViewItemModel *)model{
    self = [super init];
    if (self) {
        _icon = model.icon;
        _content = model.content;
        _type = model.type;
        _time = model.time;
        _name = model.name;
        _image = model.image;
        _visableTime = YES;
        _visableLeftDirection = [model.others boolValue];
        _voicePath = model.voicePath;
       
    }
    return self;
}

- (void)sortOutWithTime:(NSString *)time{
    if (time && time.length != 0) {
        if ([time isEqualToString:_time]){
            self.visableTime = NO;
        }
    }
}
- (void)respondsUserTap{
    _processing  = YES;
    if (!_processing) {
        switch (_type) {
            case CHMessageVoice:
                [self playVoice];
                break;
            case CHMessageLocation:
                [self showLocation];
                break;
            case CHMessageImage:
                [self showImage];
                break;
                
            default:
                break;
        }
    }
}
- (void)showImage{
    
}
- (void)showLocation{
    
}
- (void)playVoice{
    if (self.voicePath.length != 0) {

        dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(dispatchQueue, ^(void) {
        
           NSData *voictData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.voicePath]];
            NSError *error = nil;
            // 初始化音频控制器
            self.audioPlayer.volume = 0.8f;
            self.audioPlayer.numberOfLoops = 0;
            if (!self.audioPlayer) {
                self.audioPlayer = [[AVAudioPlayer alloc] initWithData:voictData error:&error];
            }
            
            if (self.audioPlayer != nil){
                
                self.audioPlayer.delegate = self;// 设置 delegate
                if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
                    // 播放成功
                }
                else {
                    // 播放失败
                }
            }
            else {
                // 初始化 AVAudioPlayer 失败 
            }
        });

    }
  
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
           self.audioPlayer = nil;
    }
 
    // 播放结束
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    // 播放失败
}
@end
