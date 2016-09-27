//
//  CHChatMessageLocationCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageLocationCell.h"

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
    
}
- (void)updateConstraints{
    [super updateConstraints];
    
}
@end
