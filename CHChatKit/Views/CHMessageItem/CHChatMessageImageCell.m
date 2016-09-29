//
//  CHChatMessageImage.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageImageCell.h"
#import "CHChatMessageImageVM.h"
#import "UIView+CHMaskLayer.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CHImage.h"
#import "Masonry.h"
#import <Photos/Photos.h>

@implementation CHChatMessageImageCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageImage;
}
- (void)layout{
    [self.messageContainer addSubview:self.imageContainer];
    [super layout];
    if ([self isOwner]) {
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@(200)).priorityHigh();
            make.right.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }else{
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@(200)).priorityHigh();
            make.left.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }
    
}
- (void)updateConstraints{
    [super updateConstraints];
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    if ([viewModel isKindOfClass:[CHChatMessageImageVM class]]) {
        CHChatMessageImageVM *vm = (CHChatMessageImageVM *)viewModel;
        UIImage *thumbnailPhoto = vm.thumbnailImage;
        if (self.imageContainer.image == thumbnailPhoto && self.imageContainer.image) {
            return;
        }
        if (thumbnailPhoto) {
            self.imageContainer.image = thumbnailPhoto;
            [self cropMask:self.imageContainer.image.size];
            
            return;
        }
        if ([vm isLocalFile] && vm.filePath) {
            // TO DO 内存缓存和沙盒缓存
            self.imageContainer.image = nil;
            [self fullResolutionImageForAssetUrl:[NSURL URLWithString:vm.filePath] finish:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    vm.fullImage = image;
                    UIImage *fitImage =[image ch_fitToSize:CGSizeMake(200, 200)];
                    vm.thumbnailImage = fitImage;
                    self.imageContainer.image = fitImage;
                    [self cropMask:self.imageContainer.image.size];
                    
                    [self reloadTableView];
                });
            }];
            
            
            
            
            return;
        }
        [self.imageContainer sd_setImageWithURL:[NSURL URLWithString:vm.filePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //display the image
                vm.fullImage = image;
                UIImage *fitImage = [image ch_fitToSize:CGSizeMake(200, 200)];
                
                vm.thumbnailImage = fitImage;
                self.imageContainer.image = fitImage;
                [self cropMask:self.imageContainer.image.size];
                [self reloadTableView];
            });
            
        }];
        return;
        
    }else{
        NSAssert(NO, @"[CHChatMessageImageVM class] loadViewModel的类型有问题");
    }
}
- (void )fullResolutionImageForAssetUrl: (NSURL*)assetUrl
                                 finish: (void (^)(UIImage *))finish{
    if(assetUrl == nil) {
        return ;
    }
    
    if([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
        return ;
    }
    
    PHAsset* asset = ^ {
        PHFetchResult<PHAsset*>* result = [PHAsset fetchAssetsWithALAssetURLs: @[ assetUrl ] options: nil];
        PHAsset* asset = [result firstObject];
        
        return asset;
    } ();
    if(asset == nil) {
        return ;
    }
    
    CGFloat imageWidth = [asset pixelWidth];
    if(imageWidth == 0) {
        return ;
    }
    assert(imageWidth > 0);
    
    CGFloat imageHeight = [asset pixelHeight];
    if(imageHeight == 0) {
        return ;
    }
    assert(imageHeight > 0);
    
    CGSize imageSize = CGSizeMake(imageWidth, imageHeight);
    
    PHImageRequestOptions* options = [[PHImageRequestOptions alloc] init];
    [options setSynchronous: TRUE];
    
    
    PHImageManager* manager = [PHImageManager defaultManager];
    [
     manager
     requestImageForAsset: asset
     targetSize: imageSize
     contentMode: PHImageContentModeDefault
     options: options
     resultHandler: ^(UIImage* resultImage, NSDictionary* info) {
         if (finish) {
             finish(resultImage);
         }
     }
     ];
}
- (void)cropMask:(CGSize )size{
    if (self.viewModel.isOwner) {
        [self.imageContainer maskRightLayer:size];
    }else{
        [self.imageContainer maskLeftLayer:size];
    }
}
- (void )imageTap:(UITapGestureRecognizer *)tap{
    
}
#pragma mark 懒加载
- (UIImageView *)imageContainer{
    if (!_imageContainer) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        _imageContainer = [UIImageView new];
        _imageContainer.userInteractionEnabled = YES;
        [_imageContainer addGestureRecognizer:tap];
    }
    return _imageContainer;
}
@end
