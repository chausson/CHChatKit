//
//  CHRecordHandler.m
//  CHChatKit
//
//  Created by Chausson on 16/9/14.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "CHRecordHandler.h"
#import "CommonCrypto/CommonDigest.h"
NSString *const recordFileName = @"CHRecord.caf";
NSString *const pathKey = @"CHRecordHandler_VOICE_PATH";

@interface  CHRecordHandler()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 播放器对象 */
@property (nonatomic, strong) AVAudioPlayer *player;
/** 录音文件地址 */
@property (nonatomic, strong) NSURL *recordFileUrl;

@property (nonatomic, strong) AVAudioSession *session;

@property (nonatomic, strong) NSMutableDictionary *paths;
/** 定时器 */
@property (nonatomic, strong) NSTimer *recordTimer;// 定时器

@end



@implementation CHRecordHandler
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
+ (void)initialize{
    [super initialize];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *createPath = [NSString stringWithFormat:@"%@/Voice", pathDocuments];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:createPath]){
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:pathKey]) {
        [CHRecordHandler standardDefault].paths = [[NSUserDefaults standardUserDefaults] objectForKey:pathKey];
    }else{
        [CHRecordHandler standardDefault].paths = [NSMutableDictionary dictionary];
    }
    
}
- (void)startRecording {
    // 录音时停止播放 删除曾经生成的文件
    [self stopPlaying];
    // 真机环境下需要的代码
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    _recordSecs = 0;
    self.session = session;
    self.recordFileUrl =  [NSURL URLWithString:[self saveVoicePath]];
    [self initRecord];
    [self.recorder record];
    
    
}
- (NSString *)stopRecording{
    
    if ([_recorder isRecording]) {
        double cTime = _recorder.currentTime;
        [_recorder stop];
        [self.recordTimer invalidate];
        self.recordTimer = nil;
        if (cTime > 1) {
            // 录制返回路径
            //            NSString *md5Str = [self md5:self.recordFileUrl.absoluteString];
            //            [[CHRecordHandler standardDefault].paths setValue:self.recordFileUrl.absoluteString forKey:md5Str];
            //            [[NSUserDefaults standardUserDefaults] setObject:[CHRecordHandler standardDefault].paths forKey:pathKey];
            //            [[NSUserDefaults standardUserDefaults] synchronize];
            return self.recordFileUrl.absoluteString;
            
        } else {
            // 录制失败
            [_recorder deleteRecording];
            
        }
        
    }
    return nil;
}
/** 播放录音文件 */
- (void)playRecordWithPath:(NSString *)filePath{
    // 播放时停止录音
    [_recorder stop];
    // key = [[CHRecordHandler standardDefault].paths objectForKey:key];
    // 正在播放就返回
    if ([self.player isPlaying]) return;
    self.recordFileUrl = [NSURL URLWithString:filePath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:NULL];
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}

- (void)stopPlaying {
    [self.player stop];
}

- (void)destory {
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (self.recordFileUrl) {
        [fileManager removeItemAtURL:self.recordFileUrl error:&error];
        error?NSLog(@"Destory File=%@",error):@"";
        
    }
}


#pragma mark - 懒加载
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
#pragma mark Private
- (void)countVoiceTime{
    _recordSecs += 0.5;
}
- (void)initRecord{
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:[self recorderSetting] error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    _recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
}
- (NSString *)saveVoicePath{
    NSString *key = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *createPath = [NSString stringWithFormat:@"%@/Voice", pathDocuments];
    NSString *createDir = [NSString stringWithFormat:@"%@/CHVoice_%@_%@", createPath,key,recordFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![fileManager fileExistsAtPath:createPath]){
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    return createDir;
}
//- (NSString *)md5:(NSString *)inPutText
//{
//    const char *cStr = [inPutText UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStr, strlen(cStr), result);
//    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//             result[0], result[1], result[2], result[3],
//             result[4], result[5], result[6], result[7],
//             result[8], result[9], result[10], result[11],
//             result[12], result[13], result[14], result[15]
//             ] lowercaseString];
//}

- (void)clear{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *createPath = [NSString stringWithFormat:@"%@/Voice", pathDocuments];
    [fileManager removeItemAtPath:createPath error:&error];
    error?NSLog(@"Destory File=%@",error):@"";
    
}
- (void)deleteWithPath:(NSString *)filePath{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (filePath) {
        [fileManager removeItemAtPath:filePath error:&error];
        error?NSLog(@"Destory File=%@",error):@"";
    }
}
@end
