//
//  CHChatCommnd.m
//  CHChatDemo
//
//  Created by Chausson on 15/11/14.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#import "CHChatBusinessCommnd.h"
#import "NSString+Emoji.h"
#import "CHMessageModel.h"
//#import "CHGroupMemManager.h"


@implementation CHChatBusinessCommnd{
    NSString * _receiveUrl;
}
+ (instancetype)standardChatDefaults{
    static CHChatBusinessCommnd *commnd = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        commnd = [[CHChatBusinessCommnd alloc]init];


    });
    return commnd;
}


#pragma mark -
#pragma mark    发送消息
- (void)postMessage:(NSString *)message{
    
}

#pragma mark -
#pragma mark    发送群聊消息
- (void)postGroupMessageWithDic:(NSDictionary *)dic{


}




- (void)postSoundWithData:(NSString *)path{
    
}




//获取时间的星期数
-(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


//获取时间的字符串
-(NSString*)getTime:(NSDate*)date{
    
    
    /// 初始化一个日期格式类
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    
    fm.dateFormat = @"yyyy";
    
 
    if ([[fm stringFromDate:date] isEqualToString:[fm stringFromDate:[NSDate date]]]) { // 今年
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        if ([calendar isDateInToday:date]) { // 是今天
            
            fm.dateFormat = @"HH:mm";
            return [fm stringFromDate:date];
        } else if ([calendar isDateInYesterday:date]) { // 昨天
            
            fm.dateFormat = @"昨天 HH:mm";
            return [fm stringFromDate:date];
            
        } else{
            
            NSString* weekStr = [self weekdayStringFromDate:date];
            weekStr = [NSString stringWithFormat:@"%@ HH:mm",weekStr];
            fm.dateFormat = weekStr;
            return [fm stringFromDate:date];
        }
        
    } else { // 去年及之前
        fm.dateFormat = @"yyyy-MM-dd";
        return [fm stringFromDate:date];
    }
    


}










@end
