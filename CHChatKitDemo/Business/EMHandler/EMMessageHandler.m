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

#import <AudioToolbox/AudioToolbox.h>
static NSString * changeDateToStr(long long timestamp){
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSTimeInterval interval = timestamp/1000.0f;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [formatter stringFromDate:date];
}
@interface EMMessageHandler()
@property (nonatomic ,strong) CHMessageDatabase *dataBase;
@end
@implementation EMMessageHandler
+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        instance = [[self alloc]init];
        [CHMessageEventCenter shareInstance].delegate = instance;
    });
    return instance;
}
- (NSString *)userName{
    return [[EMClient sharedClient] currentUsername];
}
- (void)install:(NSString *)appkey
   apnsCertName:(NSString *)apnsCertName{
    [EMMessageHandler shareInstance];
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

-(void)save:(CHChatMessageViewModel*)viewModel{
    [self.dataBase saveMessage:(CHChatMessageViewModel *)viewModel];
}

#pragma mark POST-TEXT
- (void)executeText:(CHChatMessageViewModel *)viewModel{
    [self EMTextPOST:(CHChatMessageTextVM *)viewModel];
}
- (void)EMTextPOST:(CHChatMessageTextVM *)viewModel{
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:viewModel.content];
    NSString *from = self.userName;
    NSString *to = [NSString stringWithFormat:@"%lld",viewModel.receiveId];
    //生成Message
    
    EMMessage *message = [[EMMessage alloc] initWithConversationID:to from:from to:to body:body ext:nil];
    message.chatType = EMChatTypeChat;
    __weak typeof(self)weakSelf = self;
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!error) {
            viewModel.sendingState = CHMessageSendSuccess;
        }else{
            viewModel.sendingState = CHMessageSendFailure;
        }
        [strongSelf.dataBase saveMessage:(CHChatMessageViewModel *)viewModel];
    }];
}

#pragma mark POST-PICTURE
- (void)executePicture:(CHChatMessageImageVM *)viewModel{
    NSProgress *current = [NSProgress progressWithTotalUnitCount:100];
    [current setCompletedUnitCount:0];
    viewModel.progress = current;
    [self EMPicturePOST:viewModel];
}
- (void)EMPicturePOST:(CHChatMessageImageVM *)viewModel{
    
    NSString *from = self.userName;
    NSString *to = [NSString stringWithFormat:@"%lld",viewModel.receiveId];
//      环信默认设置是0.6
        NSData *data = UIImageJPEGRepresentation(viewModel.fullImage, 1);
        EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:viewModel.fileName];
        EMMessage *message = [[EMMessage alloc] initWithConversationID:to from:from to:to body:body ext:nil];
        message.chatType = EMChatTypeChat;// 设置为单聊消息
        __weak typeof(self)weakSelf = self;
        [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {

                NSProgress *current = [NSProgress progressWithTotalUnitCount:100];
                [current setCompletedUnitCount:progress];
                viewModel.progress = current;

        } completion:^(EMMessage *message, EMError *error) {
            __strong typeof(weakSelf)strongSelf = weakSelf;

            if (!error) {
                viewModel.sendingState = CHMessageSendSuccess;
            }else{
                viewModel.sendingState = CHMessageSendFailure;
            }
            EMImageMessageBody *body = (EMImageMessageBody *)message.body;

            viewModel.filePath = body.remotePath;
            [strongSelf.dataBase saveMessage:(CHChatMessageViewModel *)viewModel];

        }];

    //UIImage转换为NSData
}
#pragma mark POST-VOICE
- (void)executeVoice:(CHChatMessageVoiceVM *)viewModel{
    [self EMVoicePOST:viewModel];
}
- (void)EMVoicePOST:(CHChatMessageVoiceVM *)viewModel{
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:viewModel.filePath displayName:viewModel.fileName];
    body.duration = (int)viewModel.length;
    NSString *from = [[EMClient sharedClient] currentUsername];
    NSString *to = [NSString stringWithFormat:@"%lld",viewModel.receiveId];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:to from:from to:to body:body ext:nil];
    message.chatType = EMChatTypeChat;
    __weak typeof(self)weakSelf = self;
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
        __strong typeof(weakSelf)strongSelf = weakSelf;

        if (!error) {
            viewModel.sendingState = CHMessageSendSuccess;
        }else{
            viewModel.sendingState = CHMessageSendFailure;
        }
        [strongSelf.dataBase saveMessage:(CHChatMessageViewModel *)viewModel];

    }];
}
-(void)executeHTML:(CHChatMessageHTMLVM *)viewModel{
    
    
}
#pragma mark POST-LOCATION

#pragma mark POST-RECEIVE
- (void)messagesDidReceive:(NSArray *)aMessages{
    
    [aMessages enumerateObjectsUsingBlock:^(EMMessage *msg, NSUInteger idx, BOOL *  stop) {
        if (msg.ext) {

        }else{
            // 声音和振动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1106);
            switch (msg.body.type) {
                case EMMessageBodyTypeText:{
                    EMTextMessageBody *body = (EMTextMessageBody *)msg.body;
                    CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeDate:changeDateToStr(msg.timestamp)  nickName:nil content:body.text isOwner:NO];
                    viewModel.receiveId = [msg.from intValue];
                    [[CHMessageEventCenter shareInstance] receiveMessage:viewModel];
                    }break;
                case EMMessageBodyTypeImage:{
  
                        [[EMClient sharedClient].chatManager downloadMessageAttachment:msg progress:nil completion:^(EMMessage *message, EMError *error) {
                            EMImageMessageBody *body = (EMImageMessageBody *)message.body;
                            if (error == nil && body.downloadStatus != EMDownloadStatusSuccessed) {

                                UIImage *fullImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:body.localPath]];
                                CHChatMessageImageVM *viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:nil timeDate:changeDateToStr(msg.timestamp) nickName:nil resource:body.remotePath size:body.size thumbnailImage:nil fullImage:fullImage isOwner:NO];
                                viewModel.receiveId = [msg.from intValue];
                                viewModel.filePath = body.remotePath;
                                [[CHMessageEventCenter shareInstance] receiveMessage:viewModel];
                            }
                            
                        }];
                }break;
                case EMMessageBodyTypeVoice:{

                    EMVoiceMessageBody *body = (EMVoiceMessageBody *)msg.body;
                    CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:nil timeDate:changeDateToStr(msg.timestamp)  nickName:nil fileName:body.displayName resource:body.localPath voiceLength:body.duration isOwner:NO];
                    viewModel.receiveId = [msg.from intValue];
                    [[CHMessageEventCenter shareInstance] receiveMessage:viewModel];

                }break;
                default:
                    
                    break;
            }
        }
        
    }];
}
- (CHMessageDatabase *)dataBase{
    if (!_dataBase) {
        _dataBase = [CHMessageDatabase databaseWithUserId:[[EMMessageHandler shareInstance].userName intValue]];
    }
    return _dataBase;
}
@end
