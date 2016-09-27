//
//  UIImageView+CHMaskLayer.h
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CHMaskLayer)
- (void)maskLeftLayer:(CGSize)size;
- (void)maskRightLayer:(CGSize)size;
@end
