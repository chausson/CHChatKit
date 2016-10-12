//
//  CHEMChatAccountEvent.h
//  CHChatKit
//
//  Created by Chausson on 16/10/12.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHEMChatAccountEvent : NSObject
@property (nonatomic ,copy) NSString *userName;
@property (nonatomic ,copy) NSString *password;
@property (nonatomic ,assign ,getter=isLogout ) BOOL logout; /* false 表示登录yes表示登出*/
@end
