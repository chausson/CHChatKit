//
//  CHRecordHandler.h
//  CHChatKit
//
//  Created by Chausson on 16/9/14.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHRecordHandler : NSObject

+ (instancetype)new __unavailable;
- (instancetype)init __unavailable;

+ (instancetype)standardDefault;
/** 开始录音 */
- (void)startRecording;
/** 开始录音并保存到指定路径 */
- (void)startRecording:(NSString *)file;

/** 停止录音 */
- (void)stopRecording;

/** 播放录音文件 */
- (void)playRecordingFile;

/** 停止播放录音文件 */
- (void)stopPlaying;

/** 销毁录音文件 */
- (void)destory;
@end
