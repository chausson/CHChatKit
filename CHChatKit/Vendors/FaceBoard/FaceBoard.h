//
//  FaceBoard.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceBoard;
@protocol FaceBoardDelegate <NSObject>
- (void)clickFaceBoard:(NSString *)string;
- (void)sendFaceMessage;
- (void)cancelFaceMessage;
@optional
@end

@interface FaceBoard : UIView<UIScrollViewDelegate>
@property (nonatomic ,weak ) id<FaceBoardDelegate>delegate;
@property (nonatomic ,strong )UIScrollView *faceView;
@property (nonatomic ,strong )UIButton *sendBtn;
@property (nonatomic ,strong )UIButton *deleteBtn;
@property (nonatomic ,strong )UIPageControl *facePageControl;
@end
