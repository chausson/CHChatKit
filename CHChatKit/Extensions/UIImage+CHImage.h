//
//  UIImage+CHImage.h
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CHImage)
+ (UIImage *)avaiableBubbleImage:(BOOL)right;
+ (UIImage *)imageNamed:(NSString *)name
               inBundle:(NSString *)bundleName
            bundleClass:(Class )aClass;
+ (UIImage *)imageNamed:(NSString *)name
               inBundle:(NSString *)bundleName;
- (UIImage *)ch_fitToSize:(CGSize)aSize;
- (UIImage *)ch_aspectImageCell;
- (void )fullResolutionImageForAssetUrl: (NSURL*)assetUrl
                                 finish: (void (^)(UIImage *))finish;
@end
