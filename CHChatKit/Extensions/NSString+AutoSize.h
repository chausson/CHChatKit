//
//  NSString+AutoSize.h
//  chat622
//
//  Created by 黑眼圈 on 16/6/26.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (AutoSize)

// 根据文本和字体大小来确定 label 的大小
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;


@end


