//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

/*
 * @method uuid
 * @description apple identifier support iOS6 and iOS5 below
*/

+ (NSString *)appName;
+ (NSString *)appVersion;

+ (NSString *)systemName;
+ (NSString *)systemVersion;

+ (NSString *)deviceName;
+ (NSString *)deviceType;

+ (NSString *)localIP;
+ (NSString *)bundleid;

+ (NSString *)idfa;
+ (NSString *)idfv;
+ (NSString *)bssid;
+ (NSString *)ssid;

+ (NSString *)mac;
+ (NSString *)imei;
+ (NSString *)model;

+ (NSString *)bootTime;

+ (BOOL)isJailBreak;

@end
