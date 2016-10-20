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

#define FACE_NAME_HEAD @"/s"
#define FACE_NAME_LEN 5// 表情转义字符的长度
#define FACE_COUNT_ALL 85

#define FACE_COUNT_ROW 4

#define FACE_COUNT_CLU 8

#define FACE_COUNT_PAGE (FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE 44 * [UIScreen mainScreen].bounds.size.width / 375


@implementation FaceBoard

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationEmoji];
        for (int i = 1; i <= self.faceView.contentSize.width / [UIScreen mainScreen].bounds.size.width; i ++) {
            UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake((i - 1) * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, self.faceView.frame.size.height)];
            [self.faceView addSubview:backGroundView];
            for (int i = 1; i <= self.emojiArray.count; i++) {
                UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [faceButton addTarget:self action:@selector(faceButton:) forControlEvents:UIControlEventTouchUpInside];
                faceButton.tag = i;
                CGFloat x = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + ((i - 1) / FACE_COUNT_PAGE * [UIScreen mainScreen].bounds.size.width);
                CGFloat y = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * FACE_ICON_SIZE + 8;
                faceButton.frame = CGRectMake( x, y, FACE_ICON_SIZE, FACE_ICON_SIZE);
                [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"emo_%03d", i]]
                            forState:UIControlStateNormal];
                [self.faceView addSubview:faceButton];
            }
        }

        [self addSubview:self.faceView];
        [self addSubview:self.facePageControl];
        [self addSubview:self.sendBtn];
        [self addSubview:self.deleteBtn];

    }
    return self;
}

//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.facePageControl setCurrentPage:self.faceView.contentOffset.x / [UIScreen mainScreen].bounds.size.width];
    [self.facePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {
    [self.faceView setContentOffset:CGPointMake(self.facePageControl.currentPage * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    [self.facePageControl setCurrentPage:self.facePageControl.currentPage];
}

- (void)faceButton:(id)sender {
    NSInteger i = ((UIButton *)sender).tag;
    if ([self.delegate respondsToSelector:@selector(clickFaceBoard:)]) {
           [self.delegate clickFaceBoard:_symbolArray[i-1] ];
    }
}

- (void)sendFaceMassage:(id)sender{
    if ([self.delegate respondsToSelector:@selector(sendFaceMessage)]) {
        [self.delegate sendFaceMessage];
    }

}
- (void)cancelFaceMessage:(id)sender{
    if ([self.delegate respondsToSelector:@selector(cancelFaceMessage)]) {
        [self.delegate cancelFaceMessage];
    }
}
- (UIScrollView *)faceView{
    if (!_faceView) {
        _faceView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 190)];
        _faceView.pagingEnabled = YES;
        _faceView.contentSize = CGSizeMake((_emojiArray.count / FACE_COUNT_PAGE + 1) * [UIScreen mainScreen].bounds.size.width, 190);
        _faceView.showsHorizontalScrollIndicator = NO;
        _faceView.showsVerticalScrollIndicator = NO;
        _faceView.delegate = self;
    }
    return _faceView;
}
- (UIPageControl *)facePageControl{
    if (!_facePageControl) {
        //添加PageControl
        _facePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_facePageControl.frame.origin.y, 180, _facePageControl.frame.size.width, _facePageControl.frame.size.height)];
        [_facePageControl addTarget:self
                             action:@selector(pageChange:)
                   forControlEvents:UIControlEventValueChanged];
        
        _facePageControl.numberOfPages = _emojiArray.count / FACE_COUNT_PAGE + 1;
        _facePageControl.currentPage = 0;
    }
    return _facePageControl;
}
- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.backgroundColor = [UIColor orangeColor];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendFaceMassage:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 185, 50, 30);
    }

    return _sendBtn;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = [UIColor lightGrayColor];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(cancelFaceMessage:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.frame = CGRectMake(CGRectGetMinX(self.sendBtn.frame)-50, 185, 50, 30);
    }
    return _deleteBtn;
}
@end
