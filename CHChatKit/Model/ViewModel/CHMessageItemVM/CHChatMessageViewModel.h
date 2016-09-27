//
//  CHMessageViewModel.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHChatDefinition.h"
#import "CHChatModel.h"

@interface CHChatMessageViewModel : NSObject
///* 如果有http代表访问远程不是的话则是本地路径.
// */
//@property (nonatomic ,readonly) NSString *voice;
//@property (nonatomic ,readonly) NSString *location;
//@property (nonatomic ,readonly) NSString *image;

@property (nonatomic ,readonly) NSString *icon;
@property (nonatomic ,readonly) NSString *date;
@property (nonatomic ,readonly) NSString *nickName;
@property (nonatomic ,readonly) CHChatMessageType category;

@property (nonatomic ,readonly , getter= isVisableTime) BOOL visableTime;
@property (nonatomic ,readonly , getter= isRetry) BOOL retry;
@property (nonatomic ,readonly , getter= isOwner) BOOL owner;

- (void)sortOutWithTime:(NSString *)time;
@end
