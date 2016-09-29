//
//  CHChatMessageLocationVM.h
//  CHChatKit
//
//  Created by Chausson on 16/9/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageFileVM.h"

@interface CHChatMessageLocationVM : CHChatMessageFileVM<CHChatMessageViewModelProtocol>
@property (nonatomic ,readonly) float longitude;
@property (nonatomic ,readonly) float latitude;
@property (nonatomic ,readonly) NSString *areaDetail;
@property (nonatomic ,readonly) NSString *areaName;
@end
