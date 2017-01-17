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
        normal = [self imageNamed:@"chatfrom_bg_normal" inBundle:@"CHChatImage" bundleClass:self];
    }else{
        normal = [self imageNamed:@"chatto_bg_normal" inBundle:@"CHChatImage" bundleClass:self];
    }
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
    return normal;
}
+ (UIImage *)imageNamed:(NSString *)name
               inBundle:(NSString *)bundleName{
    return [self imageNamed:name inBundle:bundleName bundleClass:self];
}
+ (UIImage *)imageNamed:(NSString *)name
               inBundle:(NSString *)bundleName
            bundleClass:(Class )aClass{
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return nil;
    UIImage *image;
    NSBundle *bundle = [self bundleForName:bundleName class:aClass];
    NSCache *cache = [[NSCache alloc]init];
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@",bundle,name];
    image = [cache objectForKey:cacheKey];
    
    if(image && [image isKindOfClass:[UIImage class]]) {
        return image;
    }
    NSString *res = name.stringByDeletingPathExtension;
    NSString *ext = name.pathExtension;
    NSString *path = nil;
    CGFloat scale = 1;
    // If no extension, guess by system supported (same as UIImage).
    NSArray *exts = ext.length > 0 ? @[ext] : @[@"", @"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng"];
    NSArray *scales = ^NSArray *{
        static NSArray *scales;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            CGFloat screenScale = [UIScreen mainScreen].scale;
            if (screenScale <= 1) {
                scales = @[ @1,@2,@3 ];
            } else if (screenScale <= 2) {
                scales = @[ @2,@3,@1 ];
            } else {
                scales = @[ @3,@2,@1 ];
            }
        });
        return scales;
    }();

    for (int s = 0; s < scales.count; s++) {
        scale = ((NSNumber *)scales[s]).floatValue;
        
        NSString *scaledName = [self stringByAppendingScale:scale str:res];
        for (NSString *e in exts) {
            path = [bundle pathForResource:scaledName ofType:e];
            if (path) break;
        }
        if (path) break;
    }
    if (path.length == 0) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data.length == 0) return nil;
    image = [[UIImage alloc] initWithData:data scale:scale];
    [cache setObject:image forKey:cacheKey];
    return image;
}
+ (NSString *)bundlePathForBundleName:(NSString *)bundleName class:(Class)aClass {
    NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", bundleName];
    NSString *bundlePath =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
    return bundlePath;
}

+ (NSString *)customizedBundlePathForBundleName:(NSString *)bundleName {
    NSString *customizedBundlePathComponent = [NSString stringWithFormat:@"CHCHatCustomized.bundle"];
    NSString *customizedBundlePath =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:customizedBundlePathComponent];
    return customizedBundlePath;
}

+ (NSBundle *)bundleForName:(NSString *)bundleName class:(Class)aClass {
    NSString *customizedBundlePath = [self customizedBundlePathForBundleName:bundleName];
    NSBundle *customizedBundle = [NSBundle bundleWithPath:customizedBundlePath];
    if (customizedBundle) {
        return customizedBundle;
    }
    NSString *bundlePath = [self bundlePathForBundleName:bundleName class:aClass];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}
+ (NSString *)stringByAppendingScale:(CGFloat)scale str:(NSString *)content{
    if (fabs(scale - 1) <= __FLT_EPSILON__ || content.length == 0 || [content hasSuffix:@"/"]) return content.copy;
    return [content stringByAppendingFormat:@"@%@x", @(scale)];
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
