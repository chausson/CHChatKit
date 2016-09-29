//
//  UIImage+CHImage.m
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "UIImage+CHImage.h"

@implementation UIImage (CHImage)
+ (UIImage *)avaiableBubbleImage:(BOOL)right{
    UIImage *normal ;
    if (right) {
        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
    }else{
        normal = [UIImage imageNamed:@"chatto_bg_normal"];
    }
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
    return normal;
}
- (UIImage *)ch_fitToSize:(CGSize)aSize {
    CGSize originSize = ({
        CGFloat width = self.size.width;
        CGFloat height = self.size.height;
        CGSize size = CGSizeMake(width, height);
        size;
    });

    if (originSize.width == 0 || originSize.height == 0) {
        return self;
    }
    CGFloat aspectRatio = originSize.width / originSize.height;
    CGFloat width;
    CGFloat height;
    //胖照片
    if (aSize.width / aspectRatio <= aSize.height) {
        width = aSize.width;
        height = aSize.width / aspectRatio;
    } else {
        //瘦照片
        width = aSize.height * aspectRatio;
        height = aSize.height;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *fitImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return fitImage;
}
@end
