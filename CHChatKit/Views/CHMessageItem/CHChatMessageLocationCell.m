//
//  CHChatMessageLocationCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageLocationCell.h"
#import "Masonry.h"
#import "CHChatMessageLocationVM.h"
#import "UIImage+CHImage.h"
#import "UIImageView+WebCache.h"
#import "UIView+CHMaskLayer.h"
@implementation CHChatMessageLocationCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageLocation;
}
- (void)layout{
    [super layout];
    int width = self.contentView.frame.size.width/4*3;
    int height = self.contentView.frame.size.width/4*3*(130.0/240.0);
    CGSize mapSize = CGSizeMake(width, height);
    if ([self isOwner]) {
        [self.locationContainer maskRightLayer:mapSize];
    }else{
        [self.locationContainer maskLeftLayer:mapSize];
    }
    [self.messageContainer addSubview:self.locationContainer];
    [self.locationContainer addSubview:self.mapImageView];
    [self.locationContainer addSubview:self.areaView];
    [self.areaView addSubview:self.areaName];
    [self.areaView addSubview:self.areaDetail];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMapAction)];
    [self.locationContainer addGestureRecognizer:tap];
    
//    if ([self isOwner]){
//        [self.locationContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(mapSize.width));
//            make.height.equalTo(@(mapSize.height));
//            make.right.equalTo(self.messageContainer).offset(0);
//            make.left.equalTo(self.messageContainer).offset(0);
//            make.top.equalTo(self.messageContainer).offset(0);
//            make.bottom.equalTo(self.messageContainer).offset(0);
//        }];
//    }else{
//        [self.locationContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(mapSize.width));
//            make.height.equalTo(@(mapSize.height));
//            make.right.equalTo(self.messageContainer).offset(0);
//            make.left.equalTo(self.messageContainer).offset(0);
//            make.top.equalTo(self.messageContainer).offset(0);
//            make.bottom.equalTo(self.messageContainer).offset(0);
//        }];
//        
//    }
//    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.locationContainer).offset(0);
//        make.left.equalTo(self.locationContainer).offset(0);
//        make.height.equalTo(@50);
//        make.right.equalTo(self.locationContainer).offset(0);
//    }];
//    
//    [self.mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.locationContainer).offset(50);
//        make.left.equalTo(self.locationContainer).offset(0);
//        make.height.equalTo(@80);
//        make.right.equalTo(self.locationContainer).offset(0);
//    }];
//    
//    [self.areaName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.areaView).offset(10);
//        make.right.equalTo(self.areaView).offset(-10);
//        make.left.equalTo(self.areaView).offset(10);
//        make.height.equalTo(@15);
//    }];
//    
//    [self.areaDetail mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.areaName.mas_bottom).offset(5);
//        make.right.equalTo(self.areaName).offset(0);
//        make.left.equalTo(self.areaName).offset(0);
//        make.height.equalTo(@15);
//    }];
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];


    if ([viewModel isKindOfClass:[CHChatMessageLocationVM class]]) {
        CHChatMessageLocationVM *vm = (CHChatMessageLocationVM *)viewModel;
        self.areaName.text = vm.areaName;
        self.areaDetail.text = vm.areaDetail;

            [self.mapImageView sd_setImageWithURL:[NSURL URLWithString:vm.filePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{ //cache the image
                    //display the image
                    self.mapImageView.image = image;
                });
                // TO DO 加入本地存放和缓存的逻辑
                
            }];


        
    }else{
        NSAssert(NO, @"[CHChatMessageLocationVM class] loadViewModel的类型有问题");
    }
}
- (void)updateConstraints{
    [super updateConstraints];

}
//进入定位详情
- (void)clickMapAction{
    NSLog(@"进入地图定位");
}
- (UILabel *)areaDetail
{
    if (!_areaDetail) {
        _areaDetail = [[UILabel alloc] init];
        _areaDetail.font = [UIFont systemFontOfSize:12];
        _areaDetail.textColor = [UIColor colorWithRed:188.0/ 255.0 green:188.0/255.0 blue:188.0 / 255.0 alpha:1];
      //  _areaDetail.textAlignment = NSTextAlignmentCenter;
        _areaDetail.numberOfLines =1;
    }
    return _areaDetail;
}
- (UILabel *)areaName{
    if (!_areaName) {
        _areaName = [[UILabel alloc] init];
        _areaName.font = [UIFont systemFontOfSize:15];
        _areaName.textColor = [UIColor blackColor];
        _areaName.numberOfLines =1;
       // _areaName.textAlignment = NSTextAlignmentCenter;
    }
    return _areaName;
}
- (UIImageView *)mapImageView{
    if (!_mapImageView) {
        _mapImageView = [[UIImageView alloc] init];
    }
    return _mapImageView;
}
- (UIView *)areaView{
    if (!_areaView) {
        _areaView = [[UIView alloc] init];
        _areaView.backgroundColor = [UIColor whiteColor];
    }
    return _areaView;
}
- (UIView *)locationContainer{
    if (!_locationContainer) {
        _locationContainer = [[UIView alloc] init];
    }
    return _locationContainer;
}
@end
