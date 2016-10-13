//
//  CHNoticeEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/10/13.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHNoticeEvent : NSObject
@property (strong ,nonatomic ) NSDate *timestamp;
@property (strong ,nonatomic ) NSDictionary *context;

@end
