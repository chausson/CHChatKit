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


/** 停止录音,返回录制的Path * */
- (NSString *)stopRecording;

/** 播放录音文件 */
- (void)playRecordWithKey:(NSString *)key;

/** 停止播放录音文件 */
- (void)stopPlaying;

/** 销毁当前录音文件 */
- (void)destory;
/** 清除所有录音文件 */
- (void)clear;
@end
