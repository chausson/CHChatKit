//
//  CHMessageDatabase.m
//  CHChatKit
//
//  Created by Chausson on 16/12/6.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageDatabase.h"
#import "CHChatMessageVMFactory.h"
#import "CHChatMessageFileVM.h"
#import "CHRLMConversation.h"
#import "CHRLMMessage.h"
#import "CHChatMessageViewModel+Protocol.h"
#import <Realm/Realm.h>
#import <objc/runtime.h>
@interface CHMessageDatabase()
@property (strong ,nonatomic) RLMRealm *realm;
@end
@implementation CHMessageDatabase{

}

+ (CHMessageDatabase *)databaseWithUserId:(int )identifier{
    static CHMessageDatabase *dataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[self alloc]init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *pathStr = paths.firstObject;
        NSString *path =  [NSString stringWithFormat:@"%@/%d.realm",pathStr,identifier];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:path];
        if(result){
            dataBase -> _realm  =[RLMRealm realmWithURL:[NSURL URLWithString:path]];
        }else{
            RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
            configuration.fileURL = [NSURL URLWithString:path];
            dataBase -> _realm  =[RLMRealm realmWithConfiguration:configuration error:nil];
            dataBase -> _realm.configuration.readOnly = NO;
            
        }
            dataBase -> _userId = identifier;
    });
    if (dataBase ->_userId != identifier) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *pathStr = paths.firstObject;
        NSString *path =  [NSString stringWithFormat:@"%@/%d.realm",pathStr,identifier];
        RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
        configuration.fileURL = [NSURL URLWithString:path];
        dataBase -> _realm  =[RLMRealm realmWithConfiguration:configuration error:nil];
        dataBase -> _realm.configuration.readOnly = NO;
    }
    NSLog(@"realm =%@ ",dataBase -> _realm.configuration.fileURL.absoluteString);

    return dataBase;
}

- (void)saveMessage:(CHChatMessageViewModel *)viewModel{
    CHRLMMessage *msg = [self createRLMWithVM:viewModel];
    [self.realm beginWriteTransaction];
    [self.realm addObject:msg];
    [self.realm commitWriteTransaction];
}

- (void)editMessage:(CHChatMessageViewModel *)viewModel{
 
    CHRLMMessage *msg = [self findRLMWithVM:viewModel];
    [self.realm beginWriteTransaction];
    [self updateMessage:msg viewModel:viewModel];
    [self.realm commitWriteTransaction];
    
}
- (void)deleteMessage:(CHChatMessageViewModel *)viewModel{

    CHRLMMessage *msg = [self findRLMWithVM:viewModel];
    
    [self.realm beginWriteTransaction];
    [self.realm deleteObject:msg];
    [self.realm commitWriteTransaction];
}


- (void)removeAllMessages{

    [self.realm beginWriteTransaction];
    [self.realm deleteAllObjects];
    [self.realm commitWriteTransaction];
}

- (NSArray <CHChatMessageViewModel *>*)fetchAllMessageWithReceive:(long long)receiveId{
    NSAssert(_userId != 0, @"数据库的UserId尚未设置");
    RLMResults<CHRLMMessage *> *msgs = [self fetchAllMessageUser:_userId receive:receiveId groupId:0];
    NSLog(@"url = %@ \n DATA = %@",self.realm.configuration.fileURL.absoluteString,msgs);
    NSMutableArray <CHChatMessageViewModel *>*array = [NSMutableArray arrayWithCapacity:msgs.count];
    for (CHRLMMessage *message in msgs) {
        CHChatMessageViewModel *vm = [self buildVMWithMessage:message];
        if (vm) {
            [array addObject:vm];
        }else{
            NSString *error = [NSString stringWithFormat:@"%s有未找到类型的Message",__PRETTY_FUNCTION__];
            NSAssert(NO, error);
        }

    }
    return [array copy];
}
- (NSArray <CHChatMessageViewModel *>*)fetchLastMessage:(NSInteger )count
                                                receive:(long long)receiveId{
    NSAssert(_userId != 0, @"数据库的UserId尚未设置");
    RLMResults<CHRLMMessage *> *msgs = [self fetchAllMessageUser:_userId receive:receiveId groupId:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        CHChatMessageViewModel *vm = [self buildVMWithMessage:[msgs objectAtIndex:i]];
        if (vm) {
            [array addObject:vm];
        }else{
            NSString *error = [NSString stringWithFormat:@"%s有未找到类型的Message",__PRETTY_FUNCTION__];
            NSAssert(NO, error);
        }
    }

    return [array copy];
}
- (NSArray <CHChatMessageViewModel *>*)fetchIn:(CHChatMessageViewModel *)viewModel
                                       receive:(long long)receiveId
                                         count:(NSInteger )count{
    NSAssert(_userId != 0, @"数据库的UserId尚未设置");
    RLMResults<CHRLMMessage *> *msgs = [self fetchAllMessageUser:_userId receive:receiveId groupId:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    CHRLMMessage *msg = [self findRLMWithVM:viewModel];
    int index = (int)[msgs indexOfObject:msg];
    for (int i = index; i < count+index; i++) {
        CHRLMMessage *message = [msgs objectAtIndex:i];
        CHChatMessageViewModel *vm = [self buildVMWithMessage:message];
        if (vm) {
            [array addObject:vm];
        }else{
            NSString *error = [NSString stringWithFormat:@"%s有未找到类型的Message",__PRETTY_FUNCTION__];
            NSAssert(NO, error);
        }
    }
    
    return [array copy];
}
- (NSArray <CHChatMessageViewModel *>*)fetchAllMessageWithGroupId:(long long)identifier{
    NSAssert(_userId != 0, @"数据库的UserId尚未设置");
    NSString *where = [NSString stringWithFormat:@"senderId = %d AND groupId = %lld",_userId,identifier];
    RLMResults<CHRLMMessage *> *msgs = [CHRLMMessage objectsInRealm:self.realm where:where];
//    NSLog(@"url = %@ \n DATA = %@",self.realm.configuration.fileURL.absoluteString,msgs);
    NSMutableArray <CHChatMessageViewModel *>*array = [NSMutableArray arrayWithCapacity:msgs.count];
    for (CHRLMMessage *message in msgs) {
        CHChatMessageViewModel *vm = [self buildVMWithMessage:message];
        if (vm) {
            [array addObject:vm];
        }else{
            NSString *error = [NSString stringWithFormat:@"%s有未找到类型的Message",__PRETTY_FUNCTION__];
            NSAssert(NO, error);
        }
        
    }
    return [array copy];
}
- (void)saveAndUpdateDraft:(NSString *)draft
                   receive:(long long)receiveId
                     group:(long long)groupId{
    CHRLMConversation *conversation = [[CHRLMConversation alloc]init];
    conversation.draft = draft;
    conversation.receiveId = (int)receiveId;
    conversation.groupId = (int)groupId;
    [self.realm beginWriteTransaction];
    [self.realm addOrUpdateObject:conversation];
    [self.realm commitWriteTransaction];
}
- (void)deleteDraftWithReceive:(long long)receiveId{
    NSString *where = [NSString stringWithFormat:@"receiveId = %lld",receiveId];
    RLMResults <CHRLMConversation *> *draft =[CHRLMConversation objectsInRealm:self.realm where:where];
    if (draft.firstObject) {
        [self.realm beginWriteTransaction];
        [self.realm deleteObject:draft.firstObject];
        [self.realm commitWriteTransaction];
    }
}
- (NSString *)fetchDraftWithReceive:(long long)receiveId{
    NSString *where = [NSString stringWithFormat:@"receiveId = %lld",receiveId];
    RLMResults <CHRLMConversation *> *draft =[CHRLMConversation objectsInRealm:_realm where:where];
    return [draft firstObject].draft;
}
- (void)deleteDraftWithGroup:(long long)groupId{
    NSString *where = [NSString stringWithFormat:@"groupId = %lld",groupId];
    RLMResults <CHRLMConversation *> *draft =[CHRLMConversation objectsInRealm:_realm where:where];
    if (draft.firstObject) {
        [self.realm beginWriteTransaction];
        [self.realm deleteObject:draft.firstObject];
        [self.realm commitWriteTransaction];
    }
}
- (NSString *)fetchDraftWithGroup:(long long)groupId{
    NSString *where = [NSString stringWithFormat:@"groupId = %lld",groupId];
    RLMResults <CHRLMConversation *> *draft =[CHRLMConversation objectsInRealm:_realm where:where];
    return [draft firstObject].draft;
}
// 获取草稿信息
#pragma mark Private
- (RLMRealm *)realm{
    if (!_realm) {
        _realm = [RLMRealm defaultRealm];
    }
    return _realm;
}
- (CHRLMMessage *)createRLMWithVM:(CHChatMessageViewModel *)viewModel{
    NSString *error = [NSString stringWithFormat:@"%s该类型不正确CHChatMessageViewModel",__PRETTY_FUNCTION__];
    NSAssert([viewModel isKindOfClass:[CHChatMessageViewModel class]], error);
    CHRLMMessage *msg = [[CHRLMMessage alloc]init];
    msg.avatar = viewModel.avatar;
    msg.nickName = viewModel.nickName;
    msg.visableTime = viewModel.isVisableTime;
    msg.visableNickName = viewModel.isVisableNickName;
    msg.owner = viewModel.isOwner;
    msg.category = (int)viewModel.category;
    msg.sendingState = (int)viewModel.sendingState;
    msg.receiveId = (int)viewModel.receiveId;
    msg.senderId = (int)viewModel.senderId;
    msg.groupId = (int)viewModel.groupId;
    msg.date = viewModel.date;
    msg.body =  [self assemblyBodyWithVM:viewModel];
    msg.hasRead = viewModel.hasRead;

    return msg;
}
- (void )updateMessage:(CHRLMMessage *)msg
             viewModel:(CHChatMessageViewModel *)aViewModel{
    if (msg) {
        msg.avatar = aViewModel.avatar;
        msg.nickName = aViewModel.nickName;
        msg.visableTime = aViewModel.isVisableTime;
        msg.visableNickName = aViewModel.isVisableNickName;
        msg.owner = aViewModel.isOwner;
        msg.category = (int)aViewModel.category;
        msg.sendingState = (int)aViewModel.sendingState;
        msg.receiveId = (int)aViewModel.receiveId;
        msg.senderId = (int)aViewModel.senderId;
        msg.groupId = (int)aViewModel.groupId;
        msg.body =  [self assemblyBodyWithVM:aViewModel];
        msg.hasRead = aViewModel.hasRead;
    }else{
        NSLog(@"Database中未找到需要修改的Message");
    }
    
}
- (CHRLMMessage *)findRLMWithVM:(CHChatMessageViewModel *)viewModel{
    if (!self.realm) {
        self.realm =  [RLMRealm defaultRealm];
    }
    RLMResults<CHRLMMessage *> *vm = [CHRLMMessage objectsInRealm:self.realm where:@"createDate = %@",viewModel.createDate];
    return vm.firstObject;
    
}
#pragma mark Private
- (NSString *)assemblyBodyWithVM:(CHChatMessageViewModel *)viewModel{
    NSError * err;
    NSMutableDictionary *prettyDic = [NSMutableDictionary dictionaryWithDictionary:[viewModel fetchMessageBody]];
    if ([viewModel.class isSubclassOfClass:[CHChatMessageFileVM class]]) {
        CHChatMessageFileVM *fileVM = (CHChatMessageFileVM *)viewModel;
        [prettyDic setValue:fileVM.filePath forKey:@"url"];
        [prettyDic setValue:fileVM.fileName forKey:@"fileName"];
    }
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:prettyDic options:0 error:&err];
    NSString *body;
    @try {
        if (!err) {
            NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
            body = myString;
        }
    } @catch (NSException *exception) {
        NSLog(@"%s %d %@ error=%@",__PRETTY_FUNCTION__,__LINE__,[exception description],[err description]);
        return nil;
    }
    return body;
    
}
- (RLMResults<CHRLMMessage *>*)fetchAllMessageUser:(long long)user
                                           receive:(long long)receive
                                           groupId:(long long)group{
    NSString *where = [NSString stringWithFormat:@"senderId = %lld AND receiveId = %lld AND groupId = %lld",user,receive,group];
    RLMResults<CHRLMMessage *> *msgs = [CHRLMMessage objectsInRealm:self.realm where:where];
    
    return msgs;
}
- (CHChatMessageViewModel *)buildVMWithMessage:(CHRLMMessage *)message{
    NSError *e;
    NSData *data = [message.body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if (e) {
        NSLog(@"%s %d %@",__PRETTY_FUNCTION__,__LINE__,[e description]);
        return nil;
    }
    CHChatMessageViewModel *viewModel;
    switch (message.category) {
        case CHMessageText:{
            NSString *content ;
            if ([json objectForKey:@"content"]) {
                content = [json objectForKey:@"content"];
            }
             viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:message.avatar timeDate:message.date nickName:message.nickName content:content isOwner:message.owner];
        }break;
        case CHMessageImage:{
            NSString *filePath ;
            if ([json objectForKey:@"url"]) {
                filePath = [json objectForKey:@"url"];
            }
            viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:message.avatar timeDate:message.date nickName:message.nickName resource:filePath size:CGSizeZero thumbnailImage:nil fullImage:nil isOwner:message.owner];
        }break;
        case CHMessageVoice:{
            NSString *filePath ;
            NSInteger length ;
            if ([json objectForKey:@"url"]) {
                filePath = [json objectForKey:@"url"];
            }
            if([json objectForKey:@"length"]) {
                length = [[json objectForKey:@"length"] integerValue];
            }
            viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:message.avatar timeDate:message.date nickName:message.nickName fileName:nil resource:filePath voiceLength:length isOwner:message.owner];
        }break;
        case CHMessagePacket:{
            NSInteger identifer ;
            NSString *blessing ;

            if ([json objectForKey:@"packetIdentifier"]) {
                identifer = [[json objectForKey:@"packetIdentifier"] integerValue];
            }
            if([json objectForKey:@"blessing"]){
                blessing = [json objectForKey:@"blessing"];
            }
            viewModel = [CHChatMessageVMFactory factoryPacketOfUserIcon:message.avatar timeDate:message.date nickName:message.nickName packetId:identifer blessing:blessing isOwner:message.owner];
        }break;
            
        default:
            return nil;
            break;
            
            
    }
    viewModel.createDate = message.createDate;
    viewModel.hasRead = message.hasRead;
    viewModel.receiveId = message.receiveId;
    viewModel.senderId = message.senderId;
    viewModel.groupId = message.groupId;
    viewModel.visableTime = message.visableTime;
    
    return viewModel;


}
@end
