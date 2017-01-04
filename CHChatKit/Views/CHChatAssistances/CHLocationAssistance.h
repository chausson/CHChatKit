//
//  CHLocationAssistance.h
//  CHChatKit
//
//  Created by Chausson on 16/10/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatAssistance.h"
@class UIImage;

@interface CHLocationAssistance : CHChatAssistance
@property (nonatomic ,assign) double longitude;
@property (nonatomic ,assign) double latitude;
@property (nonatomic, copy)NSString *postionTitle;
@property (nonatomic, copy)NSString *postionDetail;
@property (nonatomic, weak)UIImage *snapshot;


@end
