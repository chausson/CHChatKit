//
//  CHPickPhotoAssistance.m
//  CHChatKit
//
//  Created by Chausson on 16/10/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "CHPickPhotoAssistance.h"
#import "CHMessagePictureEvent.h"
@interface CHPickPhotoAssistance ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@end;
@implementation CHPickPhotoAssistance
+ (NSString *)registerAssistance{
    return CHPickPhotoAssistanceIdentifer;
}

+ (void)load{
    [self registerSubclass];
}
- (NSString *)title{
    return @"拍照";
}
- (NSString *)picture{
    return @"sharemore_video";
}
- (void)executeEvent:(id )responder{
    [self openCamera:responder];

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
#pragma mark 打开照相机
- (void)openCamera:(UIViewController *)controller{
    if (controller && [controller isKindOfClass:[UIViewController class]]) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sourceType =  UIImagePickerControllerSourceTypeCamera;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        pickerImage.sourceType = sourceType;
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        [controller presentViewController:pickerImage animated:YES completion:^{}];
    }
    
}
#pragma mark - Imagepicker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CHMessagePictureEvent *event = [CHMessagePictureEvent new];
        event.file = url.absoluteString;
        event.fullPicture = image;
        [[XEBEventBus defaultEventBus] postEvent:event];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
     
    }];
}
@end
