//
//  CHAssistanceHandler.h
//  CHChatKit
//
//  Created by Chausson on 16/9/12.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CHPickerHandler)(UIImage* image);

@interface CHAssistanceHandler : NSObject

- (void)pickPhotoWihtCameraPicker:(NSObject *)controller
                       completion:(CHPickerHandler )handler;
- (void)pickPhotoWihtLibraryPicker:(NSObject *)controller
                       completion:(CHPickerHandler )handler;
@end
