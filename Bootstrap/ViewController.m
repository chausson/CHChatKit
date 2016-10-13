//
//  ViewController.m
//  CHChatKit
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "CHChatMessageVMFactory.h"
#import "CHChatModel.h"
#import "CHChatViewController.h"
#import "CHChatConfiguration.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)singleChat:(UIButton *)sender {

    CHChatConfiguration *configuration = [CHChatConfiguration defultConfigruration];
    configuration.title = @"聊天";
    [configuration addAssistances:@[CHPictureAssistanceIdentifer,CHPickPhotoAssistanceIdentifer,CHLocationAssistanceIdentifer]];
    CHChatViewModel *vm = [[CHChatViewModel alloc]initWithMessageHistroy:[self getHistroy] configuration:configuration];
    vm.receiveId = 13969;
    vm.userId = 13996;
    vm.userIcon = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=5bda8a18a71ea8d38a777c02a73a1c76/5882b2b7d0a20cf4598dc37c77094b36acaf9977.jpg";
    CHChatViewController *vc = [[CHChatViewController alloc]initWithViewModel:vm];

    [self.navigationController pushViewController:vc animated:YES];

}
- (NSArray *)getHistroy{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChatContent" ofType:@"plist"]];
    CHChatModel* list = [[CHChatModel alloc]initWithDictionary:dic error:nil];
    NSMutableArray *cellTempArray = [[NSMutableArray alloc ]initWithCapacity:list.chatContent.count];
    
    for (int i = 0; i < list.chatContent.count; i++) {
        CHChatViewItemModel *item = list.chatContent[i];
        CHChatMessageViewModel *viewModel ;
        switch (item.type) {
            case 1:
                viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:item.icon timeData:item.time nickName:item.name content:item.content isOwner:[item.owner boolValue]];
                break;
            case 2:
                viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:item.icon timeData:item.time nickName:item.name resource:item.image thumbnailImage:nil fullImage:nil  isOwner:[item.owner boolValue]];
                break;
            case 3:
                viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:item.icon timeData:item.time nickName:item.name resource:item.path voiceLength:[item.length integerValue] isOwner:[item.owner boolValue]];
                break;
            case 5:
                viewModel = [CHChatMessageVMFactory factoryLoactionOfUserIcon:item.icon timeDate:item.time nickName:item.name areaName:item.title areaDetail:item.detail resource:item.path snapshot:nil location:CLLocationCoordinate2DMake(0, 0) isOwner:[item.owner boolValue]];
                break;
                
            default:
                break;
        }
        
        if (i != 0) {
            CHChatViewItemModel *last = list.chatContent[i-1];
            
            
            [viewModel sortOutWithTime:last.time];
        }
        [cellTempArray addObject:viewModel];
    }
    
    
    return  [NSArray arrayWithArray:cellTempArray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
