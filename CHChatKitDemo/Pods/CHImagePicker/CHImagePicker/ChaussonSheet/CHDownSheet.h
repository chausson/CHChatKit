//
//  CHDownSheet.h
//
//
//  Created by Chausson on 14-7-19.
//  Copyright (c) 2014年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDownSheetCell.h"
@class CHDownSheet;
@protocol CHDownSheetDelegate <NSObject>
@optional
-(void)ch_sheetDidSelectIndex:(NSInteger)index;
@end

@interface CHDownSheet : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
   
}

-(CHDownSheet *)initWithList:(NSArray *)list height:(CGFloat)height;
- (void)showInView:(UIViewController *)Sview;
- (void)showOnView:(UIView *)aView;
@property (nonatomic ,weak) id <CHDownSheetDelegate> delegate;
@property (nonatomic ,strong) UITableView *view;
@property (nonatomic ,assign ,getter=isDisplaying) BOOL displaying;

@end


