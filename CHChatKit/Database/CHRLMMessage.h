//
//  CHRLMMessage.h
//  CHChatKit
//
//  Created by Chausson on 16/12/8.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Realm/Realm.h>

@interface CHRLMMessage : RLMObject

@property NSDate *createDate;
@property NSString *icon;
@property NSString *nickName;
@property BOOL visableTime;
@property BOOL owner;
@property BOOL visableNickName;
@property int category;
@property int sendingState;
@property int receiveId;
@property int senderId;
@property NSString *text;
@property NSString *date;

@end
