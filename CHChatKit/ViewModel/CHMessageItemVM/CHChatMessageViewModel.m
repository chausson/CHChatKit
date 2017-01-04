//
//  CHMessageViewModel.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageViewModel.h"
#import <objc/runtime.h>
@implementation CHChatMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _visableTime = YES;
        _createDate = [NSDate date];
    }
    return self;
}

- (void)respondsTapAction{
    
}
- (void)sortOutWithTime:(NSString *)time{
    if (time && time.length != 0) {
        if ([time isEqualToString:_date]){
            _visableTime = NO;
        }
    }
}
- (void)setNickName:(NSString *)nickName{
    _nickName = nickName;
}
- (void)setSendingState:(CHMessageSendState)sendingState{
    _sendingState = sendingState;
}
- (void)setCategory:(CHChatMessageType)category{
    _category = category;
}
- (void)setDate:(NSString *)date{
    _date = date;
}
- (void)setOwner:(BOOL)owner{
    _owner = owner;
}
- (void)setVisableTime:(BOOL)visableTime{
    _visableTime = visableTime;
}
- (void)resend{
    NSLog(@"重发消息");
}
- (NSDictionary *)fetchMessageBody{
    if ([self isMemberOfClass:[CHChatMessageViewModel class]]) {
        return nil;
    }
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = *properties;
        
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        if ([props valueForKey:propertyName]) {
            continue;
        }
        const char * propertyAttr = property_getAttributes(property);
        NSString *propertyType = [NSString stringWithUTF8String:propertyAttr];
        if (![self isValidType:propertyType]) {
            continue;
        }
        NSLog(@"属性描述为 %@ 的 %@ ", propertyType, propertyName);
        [props setValue:[self valueForKey:propertyName] forKey:propertyName];
    }
    free(properties);
    return props;
}
- (BOOL)isValidType:(NSString *)type{
    if ([type containsString:@"NSString"] ||
        [type containsString:@"float"] ||
        [type containsString:@"int"] ||
        [type containsString:@"NSInteger"] ||
        [type containsString:@"BOOL"] ||
        [type containsString:@"double"] ||
        [type containsString:@"long long"] ||
        [type containsString:@"long"] ||
        [type containsString:@"NSNumber"] ||
        [type containsString:@"NSData"]
        ) {
        return YES;
    }else{
        return NO;
    }
}
+ (NSString *)decodeType:(const char *)cString {
    if (!strcmp(cString, @encode(id))) return @"id";
    if (!strcmp(cString, @encode(void))) return @"void";
    if (!strcmp(cString, @encode(float))) return @"float";
    if (!strcmp(cString, @encode(int))) return @"int";
    if (!strcmp(cString, @encode(BOOL))) return @"BOOL";
    if (!strcmp(cString, @encode(char *))) return @"char *";
    if (!strcmp(cString, @encode(double))) return @"double";
    if (!strcmp(cString, @encode(Class))) return @"class";
    if (!strcmp(cString, @encode(SEL))) return @"SEL";
    if (!strcmp(cString, @encode(unsigned int))) return @"unsigned int";
    
    NSString *result = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
    if ([[result substringToIndex:1] isEqualToString:@"@"] && [result rangeOfString:@"?"].location == NSNotFound) {
        result = [[result substringWithRange:NSMakeRange(2, result.length - 3)] stringByAppendingString:@"*"];
    } else
        if ([[result substringToIndex:1] isEqualToString:@"^"]) {
            result = [NSString stringWithFormat:@"%@ *",
                      [self decodeType:[[result substringFromIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]]];
        }
    return result;
}

@end
