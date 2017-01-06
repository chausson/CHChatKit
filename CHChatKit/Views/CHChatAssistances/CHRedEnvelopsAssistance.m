//
//  CHRedEnvelopsAssistance.m
//  CHChatKit
//
//  Created by 陈克锋 on 2017/1/6.
//  Copyright © 2017年 Chausson. All rights reserved.
//  红包模块

#import "CHRedEnvelopsAssistance.h"

@implementation CHRedEnvelopsAssistance

+ (void)load{
    [self registerSubclass];
}
- (NSString *)title{
    return @"红包";
}
- (NSString *)picture{
    return @"icon_gray red packet";
}
- (void)executeEvent:(id )responder{
    // 进入发送红包界面
    _responsed = responder;
    [self postEvent];
}

@end
