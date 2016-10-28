//
//  EMMessageHandler.m
//  CHChatKit
//
//  Created by Chausson on 16/10/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "EMMessageHandler.h"
/* 修改vm的@property 需要先导入该头文件 */
#import "CHChatMessageViewModel+Protocol.h"
#import "CHChatMessageTextVM.h"
#import "CHChatMessageVMFactory.h"
#import <AFNetworking/AFNetworking.h>

#import <AudioToolbox/AudioToolbox.h>

@implementation EMMessageHandler

+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [CHMessageEventCenter shareInstance].delegate = instance;
        instance = [[self alloc]init];
    });
    return instance;
}
- (void)install:(NSString *)appkey
   apnsCertName:(NSString *)apnsCertName{
    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
    options.apnsCertName = apnsCertName;
    [[EMClient sharedClient]initializeSDKWithOptions:options];
}
- (void)signInWithUserName:(NSString *)userName
                 password:(NSString *)password{
    [[EMClient sharedClient] loginWithUsername:userName password:password completion:^(NSString *aUsername, EMError *aError) {
        if (aError == nil) {
            [[EMClient sharedClient].chatManager removeDelegate:self];
            [[EMClient sharedClient].chatManager addDelegate:self];
        }else{
            NSLog(@"环信的错误信息=%@",aError.errorDescription);
        }
    }];
}
- (void)signOut{
    [[EMClient sharedClient] logout:YES];
}

- (void)executeText:(CHChatMessageViewModel *)viewModel{
    [self postTextViewModel:viewModel];
}
- (void)postTextViewModel:(CHChatMessageViewModel *)vm{
        CHChatMessageTextVM *viewModel = (CHChatMessageTextVM *)vm;
        NSDictionary *para = @{@"receiverId":@(viewModel.receiveId),
                               @"messageType":@"TEXT",
                               @"messageContent":viewModel.content,
                               @"userId":@(viewModel.senderId)};
        NSString *url = [NSString stringWithFormat:@"http://vacances.sudaotech.com/platform/app/notice/sendMsg"];
        AFHTTPSessionManager
        *manager = [self manager];
        [manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            vm.sendingState = CHMessageSendSuccess;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            vm.sendingState = CHMessageSendFailure;
        }];

}

- (void)messagesDidReceive:(NSArray *)aMessages{
    
    [aMessages enumerateObjectsUsingBlock:^(EMMessage *msg, NSUInteger idx, BOOL *  stop) {
        if (msg.ext) {

        }else{
            //                声音和振动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1106);
            switch (msg.body.type) {
                case EMMessageBodyTypeText:{
                    EMTextMessageBody *body = (EMTextMessageBody *)msg.body;
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"HH:mm";
                    NSTimeInterval interval = msg.timestamp/1000.0f;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
                    CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeData:[formatter stringFromDate:date]  nickName:nil content:body.text isOwner:NO];
                    viewModel.receiveId = [msg.from intValue];
                    [[CHMessageEventCenter shareInstance] receiveMessage:viewModel];
                    }break;
                    
                default:
                    
                    break;
            }
        }
        
    }];
}
#pragma mark - Private
- (AFHTTPSessionManager *)manager{
    // 开启转圈圈
    AFHTTPSessionManager *manager = nil;
    
    
    
    manager = [AFHTTPSessionManager manager];
    
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.requestSerializer.timeoutInterval = 300;
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    
    
    return manager;
}
@end
