//
//  CHImageFullScreenHandler.m
//  CHChatKit
//
//  Created by Chausson on 2017/1/5.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHImageFullScreenHandler.h"
#import <UIImageView+WebCache.h>
@interface CHImageFullScreenHandler()
@property (strong ,nonatomic) UIView *background;
@property (strong ,nonatomic) UIImageView *imageView;
@property (assign ,nonatomic) CGRect originRect;

@end
@implementation CHImageFullScreenHandler
+ (instancetype)standardDefault {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}
- (UIView *)background{
    if (!_background) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        _background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _background.backgroundColor = [UIColor blackColor];
        [_background addGestureRecognizer:tap];
    }
    return _background;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.background addSubview:_imageView];
    }
    return _imageView;
}
- (void)dismiss:(UITapGestureRecognizer *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = self.originRect;
    } completion:^(BOOL finished) {
        [self.background removeFromSuperview];
        [self.imageView removeFromSuperview];
        self.imageView = nil;
        self.background = nil;
    }];

}
- (void)thumbnailImageView:(UIImageView *)thumbnail
                 fullImage:(UIImage *)fullImage{
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.background];

    CGRect rect=[thumbnail convertRect:thumbnail.bounds toView:window];
    self.imageView.frame = rect;
    self.originRect = rect;
    self.imageView.image = thumbnail.image;
    [UIView animateWithDuration:0.4 animations:^{
        self.imageView.frame = CGRectMake(0, 0, self.background.frame.size.width, self.background.frame.size.height);
    } completion:^(BOOL finished) {
        self.imageView.image = fullImage;
    }];
}
- (void)thumbnailImageView:(UIImageView *)thumbnail
                 remoteUrl:(NSString *)url{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.background];
    
    CGRect rect=[thumbnail convertRect:thumbnail.bounds toView:window];
    self.imageView.frame = rect;
    self.originRect = rect;
    self.imageView.image = thumbnail.image;
    [UIView animateWithDuration:0.4 animations:^{
        self.imageView.frame = CGRectMake(0, 0, self.background.frame.size.width, self.background.frame.size.height);
    } completion:^(BOOL finished) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }];
    
}
@end
