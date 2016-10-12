//
//  AppDelegate+Extensions.m
//  SwizzleSELDemo
//
//  Created by Chausson on 16/10/12.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "AppDelegate+Extensions.h"
#import <objc/runtime.h>
#import <EMSDK.h>
@implementation AppDelegate (Extensions)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self install];
    });
}
+ (void)install{
    [self swizzleSEL:@selector(applicationDidEnterBackground:) withSEL:@selector(ch_ApplicationDidEnterBackground:)];
    [self swizzleSEL:@selector(applicationWillEnterForeground:) withSEL:@selector(ch_ApplicationWillEnterForeground:)];
    [self swizzleSEL:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) withSEL:@selector(ch_Application:didRegisterForRemoteNotificationsWithDeviceToken:)];
    [self swizzleSEL:@selector(application:didFailToRegisterForRemoteNotificationsWithError:) withSEL:@selector(ch_Application:didFailToRegisterForRemoteNotificationsWithError:)];
}
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

- (void)ch_ApplicationDidEnterBackground:(UIApplication *)application{
    [self ch_ApplicationDidEnterBackground:application];
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}
- (void)ch_ApplicationWillEnterForeground:(UIApplication *)application {
    [self ch_ApplicationWillEnterForeground:application];
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}
- (void)ch_Application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self ch_Application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
}
- (void)ch_Application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [self ch_Application:application didFailToRegisterForRemoteNotificationsWithError:error];
}
@end
