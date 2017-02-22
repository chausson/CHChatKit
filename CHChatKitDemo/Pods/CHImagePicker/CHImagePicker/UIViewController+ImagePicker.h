//
//  UIViewController+ImagePicker.h
//  CHPickImageDemo
//
//  Created by Chausson on 16/8/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDownSheet.h"

@interface UIViewController (ImagePicker)
- (void)showPicker:(BOOL)animated
        completion:(void(^)(UIImage *image))callback;

- (void)showPickerList:(BOOL)animated;

- (void)show:(BOOL)animated
     handler:(NSObject <CHDownSheetDelegate>*)handler;

- (void)openCamera;

- (void)openPhotoLibrary;
@end
