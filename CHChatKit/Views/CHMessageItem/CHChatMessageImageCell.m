//
//  CHChatMessageImage.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageImageCell.h"

@implementation CHChatMessageImageCell
#pragma mark OverRide
+ (void)load{
    [self registerSubclass];
}
+ (CHChatMessageType )messageCategory{
    
    return CHMessageImage;
}
- (void)layout{
    
    [super layout];
    
}
- (void)updateConstraints{
    [super updateConstraints];
    
}
@end
