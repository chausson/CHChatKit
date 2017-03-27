//
//  ViewController.m
//  CHChatKit
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "MyChatViewController.h"
#import "CHChatConfiguration.h"
#import "CHMessageDatabase.h"
#import "CHPictureAssistance.h"
#import "CHPickPhotoAssistance.h"
#import "CHChatMessageVMFactory.h"
#import "EMMessageHandler.h"
#import "YYFPSLabel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testFPSLabel];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - FPS

- (void)testFPSLabel {
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    fpsLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-25, 5, 50, 30);
    [fpsLabel sizeToFit];
    [[UIApplication sharedApplication].keyWindow addSubview:fpsLabel];
    
}
- (IBAction)singleChat:(UIButton *)sender {
    
    CHChatConfiguration *configuration = [CHChatConfiguration defultConfigruration];
    configuration.title = @"聊天";
    configuration.avatarCornerRadius = 5;
    [configuration addAssistances:@[[CHPictureAssistance class],[CHPickPhotoAssistance class]]];
    int userId = [[EMMessageHandler shareInstance].userName intValue];
    int receiveId = 14060;
    CHMessageDatabase *data =  [CHMessageDatabase databaseWithUserId:userId];
    NSString *draft = [data fetchDraftWithReceive:receiveId];
    NSMutableArray *messages = [NSMutableArray array];
    NSArray *historyMs = [data fetchAllMessageWithReceive:receiveId];
    [messages addObjectsFromArray:historyMs];
    CHChatViewModel *vm = [[CHChatViewModel alloc]initWithMessageHistroy:messages configuration:configuration];
   // vm.receiveId = 14128;
    vm.receiveId = receiveId;
    vm.userId = userId;
    vm.draft = draft;
    vm.receiverIcon = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=5bda8a18a71ea8d38a777c02a73a1c76/5882b2b7d0a20cf4598dc37c77094b36acaf9977.jpg";
    vm.userIcon = @"http://p3.music.126.net/36br0Mrxoa38WFBTfqiu3g==/7834020348630828.jpg";
    MyChatViewController *vc = [[MyChatViewController alloc]initWithViewModel:vm];

    [self.navigationController pushViewController:vc animated:YES];

}



@end
