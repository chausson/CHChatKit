//
//  CHChatMessageImage.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageImageCell.h"
#import "CHChatMessageImageVM.h"
#import "UIView+CHCatagory.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CHImage.h"
#import "NSObject+KVOExtension.h"
#import "Masonry.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CHImageFullScreenHandler.h"
@implementation CHChatMessageImageCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageImage;
}
- (void)layout{
    
    [self.stateIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.messageContainer addSubview:self.imageContainer];
    [self.imageContainer addSubview:self.prettyUploadMask];
    [self.messageContainer addSubview:self.progress];
    [self ch_registerForKVO:[NSArray arrayWithObjects:@"viewModel.progress", nil]];
    [super layout];
    if ([self isOwner]) {
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@(200)).priorityHigh();
            make.right.equalTo(self.messageContainer).offset(-5);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.left.equalTo(self.messageContainer).offset(0);
        }];

    }else{
        [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(@(200)).priorityHigh();
            make.left.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
            make.right.equalTo(self.messageContainer).offset(0);

        }];

    }
    [self.prettyUploadMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageContainer).offset(0);
        make.right.equalTo(self.imageContainer).offset(0);
        make.top.equalTo(self.imageContainer).offset(0);
        make.bottom.equalTo(self.imageContainer).offset(0);
    }];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.stateIndicatorView).offset(25);
        make.centerX.equalTo(self.imageContainer.mas_centerX);
        make.height.equalTo(@(25));
        make.width.equalTo(@(40));
    }];

    
}
- (void)updateConstraints{
    [super updateConstraints];
//    [self.stateIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.equalTo(self.imageContainer.mas_centerX);
//        make.centerY.equalTo(self.messageContainer.mas_centerY);
////        make.width.equalTo(@(40));
//    }];
    
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    if ([viewModel isKindOfClass:[CHChatMessageImageVM class]]) {
        
        CHChatMessageImageVM *vm = (CHChatMessageImageVM *)viewModel;
        UIImage *thumbnailPhoto = vm.thumbnailImage;

         if ((self.imageContainer.image == thumbnailPhoto )&& self.imageContainer.image) {
            return;
        }
        if (thumbnailPhoto) {
            UIImage *fitImage = [thumbnailPhoto ch_aspectImageCell];

            self.imageContainer.image = fitImage;
            [self cropMask:self.imageContainer.image.size];
            self.imageContainer.hidden = NO;

            return;
        }
 
        NSString *imageLocalPath = vm.filePath;
        //note: this will ignore contentMode.
        if ([vm isLocalFile] && imageLocalPath) {
            UIImage *fitImage =[vm.fullImage ch_aspectImageCell];
            vm.thumbnailImage = fitImage;
            self.imageContainer.image = fitImage;
            [self cropMask:self.imageContainer.image.size];
            self.imageContainer.hidden = NO;
            
            return;
        }
        if (vm.fullImage) {
            self.imageContainer.image = nil;
            UIImage *fitImage =[vm.fullImage ch_aspectImageCell];
            vm.thumbnailImage = fitImage;
            self.imageContainer.image = fitImage;
            [self cropMask:self.imageContainer.image.size];
            self.imageContainer.hidden = NO;
         
            return;
        }
        if (vm.filePath) {
            [self.imageContainer sd_setImageWithURL:[NSURL URLWithString:vm.filePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    vm.fullImage = image;
                    UIImage *fitImage = [image ch_aspectImageCell];
                    vm.thumbnailImage = fitImage;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //display the image
                        self.imageContainer.image = fitImage;
                        [self cropMask:self.imageContainer.image.size];
                        self.imageContainer.hidden = NO;
                        [self reloadTableView];
                        
                    });
                }
              
            }];
        }
    }else{
        NSString *errorInfo =  [NSString stringWithFormat:@" %@loadViewModel的类型有问题",NSStringFromClass([self class])];
        NSAssert(NO, errorInfo);
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
    CHChatMessageImageVM *imageVM = (CHChatMessageImageVM *)self.viewModel;
    [[CHImageFullScreenHandler standardDefault] thumbnailImageView:self.imageContainer remoteUrl:imageVM.filePath];
}
- (void)uploadProgress:(NSProgress *)progress{
    if (self.viewModel.sendingState == CHMessageSending  && progress) {
        _progress.hidden = NO;
        _prettyUploadMask.hidden = NO;
        long long count = (float)progress.completedUnitCount/(float)progress.totalUnitCount*100;
        _progress.text = [NSString stringWithFormat:@"%lld%%",count];
    }
    
}
- (void)reloadSendingState{
    [super reloadSendingState];
    if (self.viewModel.sendingState != CHMessageSending ) {
        _progress.hidden = YES;
        _prettyUploadMask.hidden = YES;
    }
}
#pragma mark 懒加载

- (UILabel *)progress{
    if (!_progress) {
        _progress = [[UILabel alloc]init];
        _progress.font = [UIFont systemFontOfSize:14];
        _progress.textColor = [UIColor whiteColor];
        _progress.hidden = YES;
        _progress.opaque = YES;
        _progress.textAlignment = NSTextAlignmentCenter;
    }
    return _progress;
}
- (UIView *)prettyUploadMask{
    if (!_prettyUploadMask) {
        _prettyUploadMask = [[UIView alloc]init];
        _prettyUploadMask.opaque = YES;
        _prettyUploadMask.userInteractionEnabled = YES;
        _prettyUploadMask.backgroundColor = [UIColor colorWithRed:122/255.0f green:122/255.0f blue:122/255.0f alpha:0.7];
        _prettyUploadMask.hidden = YES;

    }
    return _prettyUploadMask;
}
- (UIImageView *)imageContainer{
    if (!_imageContainer) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        _imageContainer = [UIImageView new];
        _imageContainer.hidden = YES;
        _imageContainer.userInteractionEnabled = YES;
        [_imageContainer addGestureRecognizer:tap];
    }
    return _imageContainer;
}
#pragma mark
- (void)ch_ObserveValueForKey:(NSString *)key ofObject:(id)obj change:(NSDictionary *)change{
    if ([key isEqualToString:@"viewModel.progress"]) {
        NSProgress *progress = [change objectForKey:@"new"] ;
        if (progress) {
            [self uploadProgress:progress];
        }
    }else if ([key isEqualToString:@"viewModel.sendingState"]) {
        [self reloadSendingState];
    }
}
-(void)dealloc{
    [self ch_unregisterFromKVO];
    
}
@end
