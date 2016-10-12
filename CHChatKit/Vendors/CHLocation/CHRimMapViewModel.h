//
//  RimMapViewModel.h
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRimMapCellViewModel.h"
@interface CHRimMapViewModel : NSObject
@property (nonatomic, strong, readonly)NSString *title;
@property (nonatomic, strong)NSMutableArray <CHRimMapCellViewModel *>*cellViewModle;
@property (nonatomic, assign)BOOL isClick;

@end
