//
//  GrayPageControl.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl
{
    UIImage *activeImage;
    UIImage *inactiveImage;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        activeImage = [UIImage imageNamed:@"inactive_page_image"];
        inactiveImage = [UIImage imageNamed:@"active_page_image"];
        [self setCurrentPage:1];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        activeImage = [UIImage imageNamed:@"inactive_page_image"];
        inactiveImage = [UIImage imageNamed:@"active_page_image"];
        [self setCurrentPage:1];
    }
    return self;
}

-(void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage) {
            if ([dot isKindOfClass:UIImageView.class]) {
                ((UIImageView *) dot).image = activeImage;
            }else{
                dot.backgroundColor = [UIColor colorWithPatternImage:activeImage];
            }
        }else{
            if ([dot isKindOfClass:UIImageView.class]) {
                ((UIImageView *) dot).image = inactiveImage;
            }else{
                dot.backgroundColor = [UIColor colorWithPatternImage:inactiveImage];
            }
        }
    }
}

-(void)setCurrentPage:(NSInteger)page{
    [super setCurrentPage:page];
    [self updateDots];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
