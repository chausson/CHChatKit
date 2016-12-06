//
//  CHChatMessageImageVM.m
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageImageVM.h"

@implementation CHChatMessageImageVM

- (CHChatMessageType )category{
    return CHMessageImage;
}
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
}
- (void)setSize:(CGSize)size{
    _size = size;
}
- (void)setWidth:(float)width{
    _width = width;
}
- (void)setHeight:(float)height{
    _height = height;
}
+ (NSArray *)ignoredProperties {
    return @[@"fullImage",@"thumbnailImage"];
}
@end
