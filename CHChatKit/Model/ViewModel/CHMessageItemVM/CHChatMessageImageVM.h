//
//  CHChatMessageImageVM.h
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageFileVM.h"

@interface CHChatMessageImageVM : CHChatMessageFileVM<CHChatMessageViewModelProtocol>

@property (nonatomic ,readonly) NSString *imageName;
@property (nonatomic ,readonly) float size;
@property (nonatomic ,readonly) float width;
@property (nonatomic ,readonly) float height;

@end
