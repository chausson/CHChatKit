//
//  CHChatMessageImage.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageImageCell.h"
#import "CHChatMessageImageVM.h"
#import "UIImageView+CHMaskLayer.h"
#import "UIImageView+WebCache.h"
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
            make.width.equalTo(@250);
            make.height.equalTo(@250);
            make.right.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }else{
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@250);
            make.height.equalTo(@250);
            make.left.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }

}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];

    if ([viewModel isKindOfClass:[CHChatMessageImageVM class]]) {
        if (viewModel.isOwner) {
            [self.imageContainer maskRightLayer:CGSizeMake(250, 250)];
        }else{
            [self.imageContainer maskLeftLayer:CGSizeMake(250, 250)];
        }
        CHChatMessageImageVM *vm = (CHChatMessageImageVM *)viewModel;
        if (![vm isLocalFile]) {
            [self.imageContainer sd_setImageWithURL:[NSURL URLWithString:vm.filePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }else{
            self.imageContainer.image = [UIImage imageWithContentsOfFile:vm.filePath];
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
