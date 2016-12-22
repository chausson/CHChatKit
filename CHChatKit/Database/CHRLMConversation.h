//
//  CHRLMConversation.h
//  CHChatKit
//
//  Created by Chausson on 16/12/8.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Realm/Realm.h>

@interface CHRLMConversation : RLMObject
@property NSString *draft;
@property int receiveId;
@property int groupId;
@end
