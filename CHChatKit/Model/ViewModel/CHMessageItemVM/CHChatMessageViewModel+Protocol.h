//
//  CHChatMessageViewModel+Protocol.h
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"
#import "CHChatMessageFileVM.h"
#import "CHChatMessageTextVM.h"
#import "CHChatMessageLocationVM.h"
#import "CHChatMessageVoiceVM.h"
#import "CHChatMessageImageVM.h"
@interface CHChatMessageViewModel ()
@property (nonatomic ,copy) NSString *voice;
@property (nonatomic ,copy) NSString *location;
@property (nonatomic ,copy) NSString *image;
@property (nonatomic ,copy) NSString *date;
@property (nonatomic ,copy) NSString *nickName;
@property (nonatomic ,assign) CHChatMessageType category;

@property (nonatomic ,assign , getter= isVisableTime) BOOL visableTime;
@property (nonatomic ,assign , getter= isRetry) BOOL retry;
@property (nonatomic ,assign , getter= isOwner) BOOL owner;
@end

@interface CHChatMessageTextVM ()

@property (nonatomic ,copy) NSString *content;

@end
@interface CHChatMessageFileVM ()

@property (nonatomic ,copy) NSString *filePath;
@property (nonatomic ,assign) CHMessageSendState sendingState;

@end
@interface CHChatMessageLocationVM ()
@property (nonatomic ,assign) double longitude;
@property (nonatomic ,assign) double latitude;
@property (nonatomic ,copy) NSString *areaDetail;
@property (nonatomic ,copy) NSString *areaName;
@property (nonatomic ,strong) UIImage *snapshot;
@end
@interface CHChatMessageImageVM ()

@property (nonatomic ,copy) NSString *imageName;
@property (nonatomic ,assign) float size;
@property (nonatomic ,assign) float width;
@property (nonatomic ,assign) float height;

@end

@interface CHChatMessageVoiceVM ()
@property (nonatomic ,assign) NSInteger length;
@property (nonatomic ,assign) BOOL hasRead;
@property (nonatomic ,assign) CHVoicePlayState voiceState;

@end
