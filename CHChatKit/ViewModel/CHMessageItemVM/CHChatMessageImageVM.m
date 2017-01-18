//
//  CHChatMessageImageVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageImageVM.h"
#import "UIImageView+WebCache.h"
#import "NSObject+KVOExtension.h"
#import "CHChatMessageViewModel+Protocol.h"
@interface CHChatMessageImageVM(){
    UIImage *_thumbnailImage;
}
@end
@implementation CHChatMessageImageVM

- (CHChatMessageType )category{
    return CHMessageImage;
}

- (void)setSize:(CGSize)size{
    _size = size;
}
- (void)setWidth:(float)width{
    _width = width;
}
- (void)setHeight:(float)height{
    _height = height;
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage{
    if (thumbnailImage && ![self isLocalFile]) {
        [[SDImageCache sharedImageCache] storeImage:thumbnailImage forKey:[self thumbnailKey]];
    }
    _thumbnailImage = thumbnailImage;
}
- (void)setFilePath:(NSString *)filePath{
    NSString *newKey =  [filePath stringByAppendingString:@"_thumnailImage"];
    if (filePath && ![[self thumbnailKey] isEqualToString:newKey] && self.thumbnailImage) {
        [[SDImageCache sharedImageCache] removeImageForKey:[self thumbnailKey]];
        [[SDImageCache sharedImageCache] storeImage:self.thumbnailImage forKey:newKey];
    }
    super.filePath = filePath;
}
- (UIImage *)thumbnailImage{
    if (!_thumbnailImage) {
        _thumbnailImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:[self thumbnailKey]];
        if (!_thumbnailImage){
            _thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[self thumbnailKey]];
        }
    }
    return _thumbnailImage;
}
- (NSString *)thumbnailKey{
    if (self.filePath.length > 0) {
        return [self.filePath stringByAppendingString:@"_thumnailImage"];
    }
    return nil;
}
@end
