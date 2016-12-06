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
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface CHChatMessageViewModel ()

@end

@interface CHChatMessageTextVM ()


@end
@interface CHChatMessageFileVM ()

@property (nonatomic ,copy) NSString *filePath;
@property (nonatomic ,copy) NSString *fileName;
@end
@interface CHChatMessageLocationVM ()
@property (nonatomic ,assign) double longitude;
@property (nonatomic ,assign) double latitude;
@property (nonatomic ,copy) NSString *areaDetail;
@property (nonatomic ,copy) NSString *areaName;
@property (nonatomic ,strong) UIImage *snapshot;
@property (nonatomic ,assign) CLLocationCoordinate2D coor;
@end
@interface CHChatMessageImageVM ()

@property (nonatomic ,copy) NSString *imageName;
@property (nonatomic ,assign) CGSize size;
@property (nonatomic ,assign) float width;
@property (nonatomic ,assign) float height;

@end

@interface CHChatMessageVoiceVM ()
@property (nonatomic ,assign) NSInteger length;
@property (nonatomic ,assign) BOOL hasRead;
@property (nonatomic ,assign) CHVoicePlayState voiceState;

@end
