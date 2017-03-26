//
//  LMSTakePhotoController.h
//  LetMeSpend
//
//  Created by 袁斌 on 16/3/10.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TakePhotoFunctionType) {
    TakePhotoDefaultType,//普通的拍照
    TakePhotoIDCardFrontType,//身份证正面照
    TakePhotoIDCardBackType//身份证背面照
};

typedef NS_ENUM(NSInteger, TakePhotoPosition)
{
    TakePhotoPositionBack = 0,
    TakePhotoPositionFront
};


@protocol  LMSTakePhotoControllerDelegate<NSObject>

@optional
- (void)didFinishPickingImage:(UIImage *)previewImage;

@end

@interface LMSTakePhotoController : UIViewController

/// 相机权限是否限制(是否允许拍照)
@property (nonatomic, assign, readonly) BOOL isAuthorizedCamera;
/// 判断设备是否有摄像头
@property (nonatomic, assign, readonly) BOOL isCameraAvailable;


@property (nonatomic,weak)id<LMSTakePhotoControllerDelegate> delegate;

//是前置还是后置摄像头
@property (nonatomic,assign)TakePhotoPosition position;

/// 按业务分功能
@property (nonatomic, assign) TakePhotoFunctionType functionType;


@end
