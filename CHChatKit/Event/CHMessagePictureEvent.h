//
//  CHMessagePictureEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/10/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
@class UIImage;

@interface CHMessagePictureEvent : CHMessageEvent
@property (nonatomic ,strong) UIImage *thumbnailPicture;
@property (nonatomic ,strong) UIImage *fullPicture;
@property (nonatomic ,copy) NSString *file;
@end
