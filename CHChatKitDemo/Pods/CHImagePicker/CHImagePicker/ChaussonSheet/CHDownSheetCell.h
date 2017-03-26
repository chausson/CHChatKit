//
//  CHDownSheetCell.h
//
//
//  Created by Chausson on 14-7-19.
//  Copyright (c) 2014年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#import "CHDownSheetModel.h"
@interface CHDownSheetCell : UITableViewCell{
    UILabel *InfoLabel;
    CHDownSheetModel *cellData;
    UIView *backgroundView;
}
+ (NSString *)identifier;
- (void)setData:(CHDownSheetModel *)dicdata;
@end

