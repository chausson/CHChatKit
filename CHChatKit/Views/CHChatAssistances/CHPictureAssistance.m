//
//  CHPictureAssistance.m
//  CHChatKit
//
//  Created by Chausson on 16/10/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CHImagePicker/CHImagePicker.h>
#import "CHPictureAssistance.h"
#import "CHMessagePictureEvent.h"
@interface CHPictureAssistance ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) CHImagePicker *p;
@end;
@implementation CHPictureAssistance

+ (void)load{
    [self registerSubclass];
}
- (NSString *)title{
    return @"照片";
}
- (NSString *)picture{
    return @"icon_picture";
}
- (void)executeEvent:(id )responder{
    self.p = [CHImagePicker  new];
    __weak typeof(self) weakSelf = self;
    [self.p openPhotoLibrary:responder  completion:^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CHMessagePictureEvent *event = [CHMessagePictureEvent new];
        event.group = strongSelf.group;
        event.receiverId = strongSelf.receiveId;
        event.groupId = strongSelf.groupId;
        event.userId = strongSelf.userId;
        event.fullPicture = image;
        [[XEBEventBus defaultEventBus] postEvent:event];
    }];
    [self openPhotoLibrary:responder];

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
#pragma mark 打开相册
- (void)openPhotoLibrary:(UIViewController *)controller{
    if (controller && [controller isKindOfClass:[UIViewController class]]) {
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
        [controller presentViewController:pickerImage animated:YES completion:^{}];
        
    }
}
#pragma mark - Imagepicker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CHMessagePictureEvent *event = [CHMessagePictureEvent new];
        event.group = strongSelf.group;
//        event.fullLocalPath = url.absoluteString;
        event.receiverId = strongSelf.receiveId;
        event.groupId = strongSelf.groupId;
        event.userId = strongSelf.userId;
        event.fullPicture = image;
        [[XEBEventBus defaultEventBus] postEvent:event];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
  
    }];
}
@end
