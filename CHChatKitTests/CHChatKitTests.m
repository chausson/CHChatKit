//
//  CHChatKitTests.m
//  CHChatKitTests
//
//  Created by Chausson on 16/10/14.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EMSDK.h"
#import "XEBEventBus.h"
#import "CHMessageTextEvent.h"
#import "CHChatViewModel.h"
#import "EMMessageHandler.h"
@interface CHChatKitTests : XCTestCase

@end

@implementation CHChatKitTests{
    XEBEventBus *_eventBus;
    CHChatViewModel *_viewModel;
}

- (void)setUp {
    [super setUp];
    _eventBus = [XEBEventBus defaultEventBus];
    _viewModel = [[CHChatViewModel alloc]initWithMessageHistroy:nil configuration:[CHChatConfiguration defultConfigruration]];
    [[EMMessageHandler shareInstance] install:@"jiazu#jiazu" apnsCertName:@"vacances_dev"];
    [[EMMessageHandler shareInstance] signInWithUserName:@"14128" password:@"1234abcd"];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

}

- (void)testExample {
    [self measureBlock:^{
        for (int i = 0; i < 100; i++) {
            CHMessageTextEvent *event = [CHMessageTextEvent new];
            event.userId = 14128;
            event.receiverId = 14060;
            event.text = [NSString stringWithFormat:@"test数据第%d条",i];
            NSString *info = [NSString stringWithFormat:@"run第%d条",i];
            NSLog(@"%@",info);
            [[XEBEventBus defaultEventBus] postEvent:event];
        }
      
    }];
      NSAssert(_viewModel.cellViewModels.count == 100, @"testExample not pass");
}
- (void)testEMEvent{
  //  __block int count = 0;
    [self measureBlock:^{

        for (int i = 0; i < 100; i++) {
            
            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:[NSString stringWithFormat:@"test数据第%d条",i]];
            NSString *from = [[EMClient sharedClient] currentUsername];
            
            //生成Message
            EMMessage *message = [[EMMessage alloc] initWithConversationID:@"14128" from:from to:@"14060" body:body ext:nil];
            
            message.chatType = EMChatTypeChat;// 设置为单聊消息
            
            [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
                if (!error) {
   //                 count++;
                }
                NSLog(@"error = %@",error.description);
            }];
        }
   //     NSAssert(count == 100, @"testExample not pass");
    }];


}


@end
