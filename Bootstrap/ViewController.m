//
//  ViewController.m
//  CHChatKit
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "CHChatBusinessCommnd.h"
#import "CHChatModel.h"
#import "CHChatViewController.h"
#import "CHChatConfiguration.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CHChatConfiguration standardChatDefaults].allowRecordVoice = false;
    [CHChatConfiguration standardChatDefaults].allowEmoji = false;
    [CHChatConfiguration standardChatDefaults].allowAssistance = true;
    [CHChatConfiguration standardChatDefaults].toolContentBackground = [UIColor blackColor];
    [CHChatConfiguration standardChatDefaults].keyboardAppearance = UIKeyboardAppearanceDark;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)singleChat:(UIButton *)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChatContent" ofType:@"plist"]];
    CHChatModel* listModel = [[CHChatModel alloc]initWithDictionary:dic error:nil];
    //单聊模式
    CHChatViewModel *vm = [[CHChatViewModel alloc]initWithMessageList:listModel];
    vm.userIcon = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=5bda8a18a71ea8d38a777c02a73a1c76/5882b2b7d0a20cf4598dc37c77094b36acaf9977.jpg";
    CHChatViewController *vc = [[CHChatViewController alloc]initWithViewModel:vm];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:true completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
