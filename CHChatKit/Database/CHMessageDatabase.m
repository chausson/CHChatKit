//
//  CHMessageDatabase.m
//  CHChatKit
//
//  Created by Chausson on 16/12/6.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageDatabase.h"
#import "CHChatMessageVMFactory.h"
#import <Realm/Realm.h>
@implementation CHMessageDatabase{
    RLMRealm *_realm;
    RLMResults<CHChatMessageViewModel *> *_allObjs;
}
+ (CHMessageDatabase *)databaseWithName:(NSString *)name{
    CHMessageDatabase *dataBase = [[CHMessageDatabase alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathStr = paths.firstObject;
    NSString *path =  [NSString stringWithFormat:@"%@/%@.realm",pathStr,name];

    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    configuration.fileURL = [NSURL URLWithString:path];
   // configuration.objectClasses = @[CHChatMessageViewModel.class,CHChatMessageTextVM.class];
    dataBase -> _realm  =[RLMRealm realmWithConfiguration:configuration error:nil];
    dataBase -> _realm.configuration.readOnly = NO;

    // Use the default directory, but replace the filename with the username
    
    NSLog(@"realm =%@ ",dataBase -> _realm.configuration.fileURL.absoluteString);
    return dataBase;
}
- (void)saveMessage:(CHChatMessageViewModel *)viewModel{
    if (!_realm) {
        _realm =  [RLMRealm defaultRealm];
    }
    [_realm transactionWithBlock:^{
        [_realm addObject:viewModel];
    }];
}

- (void)editMessage:(CHChatMessageViewModel *)viewModel{
    if (!_realm) {
        _realm =  [RLMRealm defaultRealm];
    }
    // TO DO
    
}
- (void)deleteMessage:(CHChatMessageViewModel *)viewModel{
    if (!_realm) {
        _realm =  [RLMRealm defaultRealm];
    }
    [_realm beginWriteTransaction];
    [_realm deleteObject:viewModel];
    [_realm commitWriteTransaction];
}
- (void)removeAll{
    if (!_realm) {
        _realm =  [RLMRealm defaultRealm];
    }
    [_realm beginWriteTransaction];
    [_realm deleteAllObjects];
    [_realm commitWriteTransaction];
}
- (NSArray <CHChatMessageViewModel *>*)fetchAllMessageWithUser:(long long)userId
                                                       receive:(long long)receiveId{
    RLMResults<CHChatMessageTextVM *> *texts = [CHChatMessageTextVM objectsInRealm:_realm where:[NSString stringWithFormat:@"senderId = %lld receiveId = %lld",userId,receiveId]];
//    _allObjs =
    [[CHChatMessageVMFactory messageViewModelClasses] enumerateObjectsUsingBlock:^(Class  _Nonnull class, NSUInteger idx, BOOL * _Nonnull stop) {
        class 
    }];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:_allObjs.count];
    for (CHChatMessageViewModel *vm in _allObjs) {
        [array addObject:vm];
    }
    return [array copy];
}
- (NSArray <CHChatMessageViewModel *>*)fetchLastMessage:(NSInteger )count
                                                   user:(long long)userId
                                                receive:(long long)receiveId{
    if (!_allObjs) {
        [self fetchAllMessageWithUser:userId receive:receiveId];
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        [array addObject:[_allObjs objectAtIndex:i]];
    }

    return  [array copy];
}
- (NSArray <CHChatMessageViewModel *>*)fetchIn:(CHChatMessageViewModel *)viewModel
                                          user:(long long)userId
                                       receive:(long long)receiveId
                                         count:(NSInteger )count{
    if (!_allObjs) {
        [self fetchAllMessageWithUser:userId receive:receiveId];
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    int index = (int)[_allObjs indexOfObject:viewModel];
    for (int i = index; i < count; i++) {
        [array addObject:[_allObjs objectAtIndex:i]];
    }
    
    return  [array copy];
}

@end
