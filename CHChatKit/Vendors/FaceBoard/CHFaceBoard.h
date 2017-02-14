//
//  CHFaceBoard.h
//  CHChatKit
//
//  Created by Chausson on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHFaceBoard;
@protocol CHFaceBoardDelegate <NSObject>
- (void)clickCHFaceBoard:(NSString *)string;
- (void)sendFaceMessage;
- (void)cancelFaceMessage;
@optional
@end

@interface CHFaceBoard : UIView<UIScrollViewDelegate>
@property (nonatomic ,weak ) id<CHFaceBoardDelegate>delegate;
@property (nonatomic ,strong )UIScrollView *faceView;
@property (nonatomic ,strong )UIButton *sendBtn;
@property (nonatomic ,strong )UIButton *deleteBtn;
@property (nonatomic ,strong )UIPageControl *facePageControl;
@end
