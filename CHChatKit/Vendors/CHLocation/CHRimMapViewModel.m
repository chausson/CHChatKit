//
//  RimMapViewModel.m
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import "CHRimMapViewModel.h"

@interface CHRimMapViewModel()
@property (nonatomic, strong)NSString *title;
@end
@implementation CHRimMapViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"定位";
        self.cellViewModle = [NSMutableArray array];
    }
    return self;
}
@end
