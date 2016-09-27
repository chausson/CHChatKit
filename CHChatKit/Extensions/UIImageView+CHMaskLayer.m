//
//  UIImageView+CHMaskLayer.m
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "UIImageView+CHMaskLayer.h"

@implementation UIImageView (CHMaskLayer)
- (void)maskLeftLayer:(CGSize)size{
    self.layer.mask = [self maskLayer:size left:YES];
}
- (void)maskRightLayer:(CGSize)size{
    self.layer.mask = [self maskLayer:size left:NO];
}
- (CAShapeLayer *)maskLayer:(CGSize )size left:(BOOL)isLeft{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat orginY = 20;
    CGFloat length = 3*1.5;
    CGFloat gapH = 5;
    CGFloat width = size.width;
    CGFloat height = size.height;
    // Create a path with the rectangle in it.
    if (isLeft) {
        [path moveToPoint:CGPointMake(0, orginY)];
        [path addLineToPoint:CGPointMake(length, orginY-4)];
        [path addLineToPoint:CGPointMake(length, gapH)];
        [path addQuadCurveToPoint:CGPointMake(length*2, 0) controlPoint:CGPointMake(length, 0)];
        [path addLineToPoint:CGPointMake(width-length*2, 0)];
        [path addQuadCurveToPoint:CGPointMake(width, gapH) controlPoint:CGPointMake(width, 0)];
        [path addLineToPoint:CGPointMake(width, height-length)];
        [path addQuadCurveToPoint:CGPointMake(width-length, height) controlPoint:CGPointMake(width, height)];
        [path addLineToPoint:CGPointMake(length*2, height)];
        [path addQuadCurveToPoint:CGPointMake(length, height-length) controlPoint:CGPointMake(length, height)];
        [path addLineToPoint:CGPointMake(length, orginY+4)];
        [path closePath];
    }else{
        [path moveToPoint:CGPointMake(width, orginY)];
        [path addLineToPoint:CGPointMake(width-length, orginY-4)];
        [path addLineToPoint:CGPointMake(width-length, gapH)];
        [path addQuadCurveToPoint:CGPointMake(width-length*2, 0) controlPoint:CGPointMake(width-length, 0)];
        [path addLineToPoint:CGPointMake(length*2, 0)];
        [path addQuadCurveToPoint:CGPointMake(0, gapH) controlPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(0, height-length)];
        [path addQuadCurveToPoint:CGPointMake(length, height) controlPoint:CGPointMake(0, height)];
        [path addLineToPoint:CGPointMake(width-length*2, height)];
        [path addQuadCurveToPoint:CGPointMake(width-length, height-length) controlPoint:CGPointMake(width-length, height)];
        [path addLineToPoint:CGPointMake(width-length, orginY+4)];
        [path closePath];
    }
    
    // Set the path to the mask layer.
    maskLayer.path = path.CGPath;
    return maskLayer;
}
@end
