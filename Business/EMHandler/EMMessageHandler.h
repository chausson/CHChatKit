//
//  EMMessageHandler.h
//  CHChatKit
//
//  Created by Chausson on 16/10/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CHMessageEventCenter.h"
#import "EMSDK.h"
#import "CHMessageDatabase.h"

@interface EMMessageHandler : NSObject<CHMessageEventProtocl,EMChatManagerDelegate>
@property (nonatomic ,readonly) NSString *userName;
@property (nonatomic ,readonly) CHMessageDatabase *dataBase;
+ (instancetype)shareInstance;

- (void)install:(NSString *)appkey
   apnsCertName:(NSString *)apnsCertName;
- (void)signInWithUserName:(NSString *)userName
                  password:(NSString *)password;
- (void)signOut;

@end
