//
//  ViewController.m
//  CHChatKit
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "CHChatModel.h"
#import "CHChatViewController.h"
#import "CHChatConfiguration.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)singleChat:(UIButton *)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChatContent" ofType:@"plist"]];
    CHChatModel* listModel = [[CHChatModel alloc]initWithDictionary:dic error:nil];
    //单聊模式
    CHChatConfiguration *configuration = [CHChatConfiguration defultConfigruration];

    [configuration addAssistanceItems:@[@(CHAssistancePhoto),@(CHAssistanceCarema),@(CHAssistanceLocation)]];
    CHChatViewModel *vm = [[CHChatViewModel alloc]initWithMessageList:listModel
                           configuration:configuration];
    vm.userIcon = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=5bda8a18a71ea8d38a777c02a73a1c76/5882b2b7d0a20cf4598dc37c77094b36acaf9977.jpg";
    CHChatViewController *vc = [[CHChatViewController alloc]initWithViewModel:vm];

    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
