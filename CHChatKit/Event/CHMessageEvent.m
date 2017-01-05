//
//  CHMessageEvent.m
//  CHChatKit
//
//  Created by Chausson on 16/9/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEvent.h"
static NSString *SwiftDateToStr(NSDate *date){
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    
    return   [formatter stringFromDate:date];
}

@implementation CHMessageEvent
- (NSString *)eventName{
    return  NSStringFromClass(self.class);
}
- (NSString *)timestamp{
    return SwiftDateToStr([NSDate date]);
}
- (NSString *)date{
    return SwiftDateToStr([NSDate date]);
}
- (BOOL)isGroup{
    return self.groupId > 0;
}
@end
