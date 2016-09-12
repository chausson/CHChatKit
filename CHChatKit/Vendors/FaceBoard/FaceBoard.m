//
//  FaceBoard.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "FaceBoard.h"
#import "FaceBoard+EmojiHash.h"
#import "Masonry.h"

#define FACE_COUNT_ALL 85

#define FACE_COUNT_ROW 4

#define FACE_COUNT_CLU 8

#define FACE_COUNT_PAGE (FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE 44 * [UIScreen mainScreen].bounds.size.width / 375

#define SCREENWIDTH  ( [UIScreen mainScreen].bounds.size.width )

#define SCREENHEIGHT ( [UIScreen mainScreen].bounds.size.height)

@interface FaceBoard ()<UIScrollViewDelegate>{
    UIScrollView *faceView;
    GrayPageControl *facePageControl;

}

@end

@implementation FaceBoard

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationEmoji];
//        self.backgroundColor = [UIColor colorWithRed:236.0/ 255.0 green:236.0/255.0 blue:236.0 / 255.0 alpha:1];
        // 表情盘
        faceView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190)];
        faceView.pagingEnabled = YES;
        faceView.contentSize = CGSizeMake((_emojiArray.count / FACE_COUNT_PAGE + 1) * SCREENWIDTH, 190);
        faceView.showsHorizontalScrollIndicator = NO;
        faceView.showsVerticalScrollIndicator = NO;
        faceView.delegate = self;
        
        for (int i = 1; i <= faceView.contentSize.width / SCREENWIDTH; i ++) {
            UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake((i - 1) * SCREENWIDTH, 0, SCREENWIDTH, faceView.frame.size.height)];
            [faceView addSubview:backGroundView];
            for (int i = 1; i <= self.emojiArray.count; i++) {
                UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [faceButton addTarget:self action:@selector(faceButton:) forControlEvents:UIControlEventTouchUpInside];
                faceButton.tag = i;
                CGFloat x = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + ((i - 1) / FACE_COUNT_PAGE * SCREENWIDTH);
                CGFloat y = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * FACE_ICON_SIZE + 8;
                faceButton.frame = CGRectMake( x, y, FACE_ICON_SIZE, FACE_ICON_SIZE);
                [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"emo_%03d", i]]
                            forState:UIControlStateNormal];
                [faceView addSubview:faceButton];
            }
        }

        [self addSubview:faceView];
        //添加PageControl
        facePageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(facePageControl.frame.origin.y, 180, facePageControl.frame.size.width, facePageControl.frame.size.height)];
        [facePageControl addTarget:self
                            action:@selector(pageChange:)
                  forControlEvents:UIControlEventValueChanged];
        
        facePageControl.numberOfPages = _emojiArray.count / FACE_COUNT_PAGE + 1;
        facePageControl.currentPage = 0;
        [self addSubview:facePageControl];
        
        //删除键
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.backgroundColor = [UIColor orangeColor];
        back.titleLabel.font = [UIFont systemFontOfSize:14];
        [back setTitle:@"发送" forState:UIControlStateNormal];
        [back addTarget:self action:@selector(sendFaceMassage:) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(SCREENWIDTH - 50, 185, 50, 30);
        [self addSubview:back];
    }
    return self;
}

//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [facePageControl setCurrentPage:faceView.contentOffset.x / SCREENWIDTH];
    [facePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {
    [faceView setContentOffset:CGPointMake(facePageControl.currentPage * SCREENWIDTH, 0) animated:YES];
    [facePageControl setCurrentPage:facePageControl.currentPage];
}

- (void)faceButton:(id)sender {
    NSInteger i = ((UIButton *)sender).tag;
    [self.FaceDelegate clickFaceBoard:_symbolArray[i-1] ];
}

- (void)sendFaceMassage:(id)sender{
    [self.FaceDelegate sendFaceMessage];
}

- (void)initEmojiArray{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
