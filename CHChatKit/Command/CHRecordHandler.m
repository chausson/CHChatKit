//
//  CHRecordHandler.m
//  CHChatKit
//
//  Created by Chausson on 16/9/14.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "CHRecordHandler.h"



@interface  CHRecordHandler()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 播放器对象 */
@property (nonatomic, strong) AVAudioPlayer *player;
/** 录音文件地址 */
@property (nonatomic, strong) NSURL *recordFileUrl;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AVAudioSession *session;

@end


@implementation CHRecordHandler

- (void)startRecording {
    // 录音时停止播放 删除曾经生成的文件
    [self stopPlaying];
    [self destory];
    
    // 真机环境下需要的代码
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
    self.session = session;
    
    [self.recorder record];
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateImage) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [timer fire];
//    self.timer = timer;
}
- (void)startRecording:(NSString *)file{
    // 录音时停止播放 删除曾经生成的文件
    [self stopPlaying];
    [self destory];
    [self initRecord];

    self.recordFileUrl = [NSURL fileURLWithPath:file];
}

- (void)stopRecording {
    if ([_recorder isRecording]) {
        [_recorder stop];
        [self.timer invalidate];
    }
}

- (void)playRecordingFile {
    // 播放时停止录音
    [_recorder stop];
    
    // 正在播放就返回
    if ([self.player isPlaying]) return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:NULL];
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}

- (void)stopPlaying {
    [self.player stop];
}

static id instance;
#pragma mark - 单例
+ (instancetype)standardDefault {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}
- (void)initRecord{
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:[self recorderSetting] error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
}
#pragma mark - 懒加载
- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        

//        NSLog(@"%@", filePath);
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:[self recorderSetting] error:NULL];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;
        
        [_recorder prepareToRecord];
    }
    return _recorder;
}
- (NSDictionary *)recorderSetting{
    // 3.设置录音的一些参数
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    // 音频格式
    setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    // 录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    setting[AVSampleRateKey] = @(44100);
    // 音频通道数 1 或 2
    setting[AVNumberOfChannelsKey] = @(1);
    // 线性音频的位深度  8、16、24、32
    setting[AVLinearPCMBitDepthKey] = @(8);
    //录音的质量
    setting[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityHigh];
    
    return [NSDictionary dictionaryWithDictionary:setting];
}
- (void)destory {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (self.recordFileUrl) {
        [fileManager removeItemAtURL:self.recordFileUrl error:NULL];
    }
}

@end
