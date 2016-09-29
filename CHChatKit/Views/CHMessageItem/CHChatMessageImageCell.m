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
        [self.imageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@(200)).priorityHigh();
            make.left.equalTo(self.messageContainer).offset(0);
            make.right.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }else{
        [self.imageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@(200)).priorityHigh();
            make.right.equalTo(self.messageContainer).offset(0);
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
        UIImage *thumbnailPhoto = vm.thumbnailImage;
        if (self.imageContainer.image == thumbnailPhoto && self.imageContainer.image) {
            return;
        }
        if (thumbnailPhoto) {
            self.imageContainer.image = thumbnailPhoto;
            [self cropMask:self.imageContainer.image.size];
            
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
