//
//  RimMapTableViewCell.h
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRimMapCellViewModel.h"
@interface CHRimMapTableViewCell : UITableViewCell
@property (nonatomic, strong)CHRimMapCellViewModel *cellViewModel;
- (void)loadCellViewModel:(CHRimMapCellViewModel *)cellViewModel;
@end
