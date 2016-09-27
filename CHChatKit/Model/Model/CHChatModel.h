//
//  CHChatModel.h
//  CHChatDemo
//
//  Created by 李赐岩 on 15/11/24.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@class UIImage;
@class CHChatViewItemModel;
@protocol CHChatViewItemModel <NSObject>
@end

@interface CHChatViewItemModel : JSONModel

@property (nonatomic ,copy) NSString <Optional>*content;
@property (nonatomic ,copy) NSString *icon;
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString <Optional>*name;
@property (nonatomic ,copy) NSString <Optional>*image;
@property (nonatomic ,copy) NSString <Optional>*title;
@property (nonatomic ,copy) NSString <Optional>*detail;
@property (nonatomic ,copy) NSString <Optional>*path;
@property (nonatomic ,assign) NSInteger type;
@property (nonatomic ,strong) NSNumber *owner;
@property (nonatomic ,strong) NSNumber <Optional>*lat;
@property (nonatomic ,strong) NSNumber <Optional>*lon;

@end
@interface CHChatModel : JSONModel
@property (nonatomic ,strong) NSArray<CHChatViewItemModel> *chatContent;
@end
