//
//  CHImageFullScreenHandler.m
//  CHChatKit
//
//  Created by Chausson on 2017/1/5.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import "CHImageFullScreenHandler.h"
#import <CHImagePicker/CHDownSheet.h>
#import <CHProgressHUD/CHProgressHUD.h>
#import <UIImageView+WebCache.h>
@interface CHImageFullScreenHandler()<CHDownSheetDelegate>
@property (strong ,nonatomic) UIScrollView *background;
@property (strong ,nonatomic) UIImageView *imageView;
@property (assign ,nonatomic) CGRect originRect;
@property (assign ,nonatomic) BOOL isOptioning;
@property (strong ,nonatomic) CHDownSheet *sheet;
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
        UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(menu)];
        _background = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _background.backgroundColor = [UIColor blackColor];
        [_background addGestureRecognizer:cancelTap];
        [_background addGestureRecognizer:longTap];

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
        self.isOptioning = NO;

    }];

}
- (void)menu{
    if (self.sheet.isDisplaying) {
        return;
    }
    self.sheet = [[CHDownSheet alloc]initWithList:[self avaiablePickerSheetModel] height:330];
    self.sheet.delegate = self;
    [self.sheet showInView:nil];
    self.isOptioning = YES;
 
}
- (void)ch_sheetDidSelectIndex:(NSInteger)index{
    if (index == 0) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        NSLog(@"保存");
    }else if (index == 2){
        NSLog(@"cancel");
    }
}
//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [CHProgressHUD showPlainText:msg];
    
}
- (NSArray *)avaiablePickerSheetModel{
    CHDownSheetModel *save = [[CHDownSheetModel alloc]init];
    save.title = @"保存到相册";

    CHDownSheetModel *cancel = [[CHDownSheetModel alloc]init];
    cancel.title = @"取消";
    
    return   @[save,cancel];
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
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:thumbnail.image  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }];
    
}
@end
