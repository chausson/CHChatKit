//
//  UIImage+CHImage.m
//  CHChatKit
//
//  Created by Chausson on 16/9/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "UIImage+CHImage.h"
#import <Photos/Photos.h>
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
- (UIImage *)ch_fitToSize:(CGSize)aSize {
    CGSize originSize = ({
        CGFloat width = self.size.width;
        CGFloat height = self.size.height;
        CGSize size = CGSizeMake(width, height);
        size;
    });

    if (originSize.width == 0 || originSize.height == 0) {
        return self;
    }
    CGFloat aspectRatio = originSize.width / originSize.height;
    CGFloat width;
    CGFloat height;
    //胖照片
    if (aSize.width / aspectRatio <= aSize.height) {
        width = aSize.width;
        height = aSize.width / aspectRatio;
    } else {
        //瘦照片
        width = aSize.height * aspectRatio;
        height = aSize.height;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *fitImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return fitImage;
}
- (UIImage *)ch_aspectImageCell{
    return [self ch_fitToSize:CGSizeMake(200, 200)];
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
@end
