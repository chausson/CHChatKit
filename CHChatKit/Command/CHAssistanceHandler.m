//
//  CHAssistanceHandler.m
//  CHChatKit
//
//  Created by Chausson on 16/9/12.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHAssistanceHandler.h"
//#import "SDImageCache.h"

@interface CHAssistanceHandler()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak ,nonatomic) UIViewController *controller;
@property (copy ,nonatomic) CHPickerHandler handler;
@end
@implementation CHAssistanceHandler
- (void)pickPhotoWihtCameraPicker:(NSObject *)controller
                       completion:(CHPickerHandler )handler{
    _handler = handler;
    if ([controller isKindOfClass:[UIViewController class]]) {
        _controller = (UIViewController *)controller;
    }

    [self openCamera];
}

- (void)pickPhotoWihtLibraryPicker:(NSObject *)controller
                        completion:(CHPickerHandler )handler{
    _handler = handler;
    if ([controller isKindOfClass:[UIViewController class]]) {
        _controller = (UIViewController *)controller;
    }
    [self openPhotoLibrary];
}
#pragma mark 打开照相机
- (void)openCamera{
    if (_controller) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            sourceType =  UIImagePickerControllerSourceTypeCamera;
            
        }
        //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //    }
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
        //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.sourceType = sourceType;
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [_controller presentViewController:pickerImage animated:YES completion:^{}];
    }

}
#pragma mark 打开相册
- (void)openPhotoLibrary{
    if (_controller) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.sourceType = sourceType;
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        [_controller presentViewController:pickerImage animated:YES completion:^{}];
        
    }
}

#pragma mark - Imagepicker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{


    [picker dismissViewControllerAnimated:YES completion:^{
        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
        if (_handler) {
            _handler(url.absoluteString);
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        _handler = nil;
        _controller = nil;
    }];
}

@end
