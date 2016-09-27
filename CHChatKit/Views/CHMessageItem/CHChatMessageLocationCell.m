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
    [self.messageContainer addSubview:self.locationView];
    [self.locationView addSubview:self.locationMap];
    [self.locationView addSubview:self.areaView];
    [self.areaView addSubview:self.areaName];
    [self.areaView addSubview:self.areaDetail];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMapAction)];
    [self.locationView addGestureRecognizer:tap];
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    [super loadViewModel:viewModel];
    if (viewModel.isOwner) {
        [self.locationView maskRightLayer:CGSizeMake(240, 130)];
    }else{
        [self.locationView maskLeftLayer:CGSizeMake(240, 130)];
    }
    if ([viewModel isKindOfClass:[CHChatMessageLocationVM class]]) {
        CHChatMessageLocationVM *vm = (CHChatMessageLocationVM *)viewModel;
        self.areaName.text = vm.areaName;
        self.areaDetail.text = vm.areaDetail;
        if (![vm isLocalFile]) {
            [self.locationMap sd_setImageWithURL:[NSURL URLWithString:vm.filePath] placeholderImage:[UIImage imageNamed:@""]];
        }else{
            self.locationMap.image = [UIImage imageWithContentsOfFile:vm.filePath];
        }
        
    }else{
        NSAssert(NO, @"[CHChatMessageLocationVM class] loadViewModel的类型有问题");
    }
}
- (void)updateConstraints{
    [super updateConstraints];
    if (self.viewModel.isOwner){
        [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@240);
            make.height.equalTo(@130);
            make.right.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
    }else{
        [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@240);
            make.height.equalTo(@130);
            make.left.equalTo(self.messageContainer).offset(0);
            make.top.equalTo(self.messageContainer).offset(0);
            make.bottom.equalTo(self.messageContainer).offset(0);
        }];
        
    }
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationView).offset(0);
        make.width.equalTo(@240);
        make.height.equalTo(@50);
        make.right.equalTo(self.locationView).offset(0);
    }];
    
    [self.locationMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationView).offset(50);
        make.width.equalTo(@240);
        make.height.equalTo(@80);
        make.right.equalTo(self.locationView).offset(0);
    }];
    
    [self.areaName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.areaView).offset(10);
        make.right.equalTo(self.areaView).offset(-10);
        make.left.equalTo(self.areaView).offset(10);
        make.height.equalTo(@20);
    }];
    
    [self.areaDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.areaView).offset(32);
        make.right.equalTo(self.areaView).offset(-10);
        make.left.equalTo(self.areaView).offset(10);
        make.height.equalTo(@15);
    }];
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
        _areaDetail.textColor = [UIColor lightGrayColor];
    }
    return _areaDetail;
}
- (UILabel *)areaName{
    if (!_areaName) {
        _areaName = [[UILabel alloc] init];
        _areaName.font = [UIFont systemFontOfSize:15];
        _areaName.textColor = [UIColor blackColor];
    }
    return _areaName;
}
- (UIImageView *)locationMap{
    if (!_locationMap) {
        _locationMap = [[UIImageView alloc] init];
    }
    return _locationMap;
}
- (UIView *)areaView{
    if (!_areaView) {
        _areaView = [[UIView alloc] init];
    }
    return _areaView;
}
- (UIView *)locationView{
    if (!_locationView) {
        _locationView = [[UIView alloc] init];
    }
    return _locationView;
}
@end
