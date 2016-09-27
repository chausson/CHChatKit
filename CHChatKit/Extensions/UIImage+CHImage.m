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
@end
