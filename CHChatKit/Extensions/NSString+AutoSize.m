//
//  NSString+AutoSize.m
//  chat622
//
//  Created by 黑眼圈 on 16/6/26.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import "NSString+AutoSize.h"

@implementation NSString (AutoSize)



// 根据文本和字体大小来确定 label 的大小
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(w, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}



@end
