//
//  CHImageFullScreenHandler.h
//  CHChatKit
//
//  Created by Chausson on 2017/1/5.
//  Copyright © 2017年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHImageFullScreenHandler : NSObject

+ (instancetype)standardDefault;

- (void)thumbnailImageView:(UIImageView *)thumbnail
                 fullImage:(UIImage *)fullImage;

- (void)thumbnailImage:(UIImage *)thumbnail
             remoteUrl:(NSString *)url;
@end
