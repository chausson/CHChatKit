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
    
}
- (void)updateConstraints{
    [super updateConstraints];
    if (self.viewModel.isOwner) {
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@200).priorityHigh();
            make.right.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }else{
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@200).priorityHigh();
            make.left.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }

}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    if ([viewModel isKindOfClass:[CHChatMessageImageVM class]]) {
        CHChatMessageImageVM *vm = (CHChatMessageImageVM *)viewModel;
        if (viewModel.isOwner) {
            [self.imageContainer maskRightLayer:CGSizeMake(200, 200)];
        }else{
            [self.imageContainer maskLeftLayer:CGSizeMake(200, 200)];
        }
        if (![vm isLocalFile]) {
            [self.imageContainer sd_setImageWithURL:[NSURL URLWithString:vm.filePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                UIImage *fitImage = [image ch_fitToSize:CGSizeMake(200, 200)];
                dispatch_async(dispatch_get_main_queue(), ^{ //cache the image
                    //display the image
                    self.imageContainer.image = fitImage;
                });
                // TO DO 加入本地存放和缓存的逻辑
                
            }];
        }else{
            static NSCache *cache = nil;
            if (!cache) {
                cache = [[NSCache alloc] init];
            }
            UIImage *imageCache = [cache objectForKey:vm.filePath];
            //switch to background thread
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                UIImage *image ;
                if (imageCache) {
                    image = imageCache;
                }else{
                    image = [UIImage imageWithContentsOfFile:vm.filePath];
                }
               UIImage *fitImage = [image ch_fitToSize:CGSizeMake(200, 200)];
                //set image for correct image view
                dispatch_async(dispatch_get_main_queue(), ^{
                    //display the image
                    self.imageContainer.image = fitImage;
                });
            });
        }

    }else{
        NSAssert(NO, @"[CHChatMessageImageVM class] loadViewModel的类型有问题");
    }
}
#pragma mark 懒加载
- (UIImageView *)imageContainer{
    if (!_imageContainer) {
        _imageContainer = [UIImageView new];
    }
    return _imageContainer;
}

@end
