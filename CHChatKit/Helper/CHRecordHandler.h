//
//  CHRecordHandler.h
//  CHChatKit
//
//  Created by Chausson on 16/9/14.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CHRecordBlock)(NSString *path,NSInteger duration);

@interface CHRecordHandler : NSObject

@property (readonly , nonatomic) CGFloat recordSecs;
@property (readonly , nonatomic) NSString *recordFile;
/** 录音文件地址 */
@property (readonly , nonatomic) NSURL *recordFileUrl;

+ (instancetype)new __unavailable;
- (instancetype)init __unavailable;

+ (instancetype)standardDefault;
/** 开始录音 */
- (void)startRecording;

/** 停止录音,返回录制的Path * */
- (NSString *)stopRecording;

/** 播放录音文件 */
- (void)playRecordWithPath:(NSString *)filePath;

- (void)playRecordWithPath:(NSString *)filePath
                     finsh:(CHRecordBlock )compeltion;

/** 停止播放录音文件 */
- (void)stopPlaying;

/** 销毁当前录音文件 */
- (void)destory;
/** 清除所有录音文件 */
- (void)clear;
/** 加密 */
//- (NSString *)md5:(NSString *)inPutText;
/** 根据录音路径删除文件 */
- (void)deleteWithPath:(NSString *)filePath;
@end
