//
//  UIImageView+CHExtension.m
//  CHChatKit
//
//  Created by Chausson on 2017/1/11.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "UIImageView+CHExtension.h"
#import <objc/runtime.h>
static char cornerRadiusKey;

@implementation UIImageView (CHExtension)
-(void)setCh_cornerRadius:(CGFloat )cornerRadius
{
    if (self.ch_cornerRadius == cornerRadius) {
        return;
    }
    objc_setAssociatedObject(self, &cornerRadiusKey, @(cornerRadius), OBJC_ASSOCIATION_COPY);
    [self drewCornerRadius:cornerRadius];
}

-(CGFloat )ch_cornerRadius
{
    return [objc_getAssociatedObject(self, &cornerRadiusKey) floatValue];
}
- (void)drewCornerRadius:(CGFloat)radius{

    UIImage *image = nil;
    CGSize size = self.bounds.size;
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    if (currnetContext) {
        CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.ch_cornerRadius].CGPath);
        CGContextClip(currnetContext);
        [self drawRect:rect];

        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
//        [self.layer renderInContext:currnetContext];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if ([image isKindOfClass:[UIImage class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    }
}
@end
