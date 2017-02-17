//
//  CHFaceBoard.m
//  CSChatDemo
//
//  Created by Chausson on 15/11/18.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CHFaceBoard.h"
#import "CHFaceBoard+EmojiHash.h"
#import "UIImage+CHImage.h"
#import <Masonry/Masonry.h>

#define FACE_NAME_HEAD @"/s"
#define FACE_NAME_LEN 5// 表情转义字符的长度
#define FACE_COUNT_ALL 85

#define FACE_COUNT_ROW 4

#define FACE_COUNT_CLU 8

#define FACE_COUNT_PAGE (FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE 42 * [UIScreen mainScreen].bounds.size.width / 375


@implementation CHFaceBoard

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self configurationEmoji];
        NSMutableArray *emojiArray = [NSMutableArray arrayWithArray:[self.emojiArray copy]];
        NSInteger count = emojiArray.count/FACE_COUNT_PAGE;
        for (int i = 1; i <= emojiArray.count+count; i++) {
            NSInteger count = i/FACE_COUNT_PAGE;
            UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            faceButton.tag = i;
            CGFloat x = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + ((i - 1) / FACE_COUNT_PAGE * [UIScreen mainScreen].bounds.size.width);
            CGFloat y = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * FACE_ICON_SIZE + 8;
            
            if (i % FACE_COUNT_PAGE == 0 || (i == emojiArray.count+count &&i % FACE_COUNT_PAGE > 0)){
                CGFloat dx = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * FACE_ICON_SIZE + 6 + ((i - 1) / FACE_COUNT_PAGE * [UIScreen mainScreen].bounds.size.width);
                CGFloat dy = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * FACE_ICON_SIZE + 8;
                UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
                [delete addTarget:self action:@selector(cancelFaceMessage:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *deleteImage = [UIImage imageNamed:@"deleteBtn" inBundle:@"CHChatFaceBoard"];
                [delete setImage:deleteImage
                        forState:UIControlStateNormal];
                
                [self.faceView addSubview:delete];
                [delete mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@(dx));
                    make.top.equalTo(@(dy));
                    make.width.height.equalTo(@(FACE_ICON_SIZE));
                }];
                continue;
            }
            
            
    
            [self.faceView addSubview:faceButton];
            
            [faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(x));
                make.top.equalTo(@(y));
                make.width.height.equalTo(@(FACE_ICON_SIZE));
            }];
            UIImage *emoji = emojiArray[i-count-1];
                [faceButton setImage:emoji
                            forState:UIControlStateNormal];
                [faceButton addTarget:self action:@selector(faceButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:self.faceView];
        [self addSubview:self.facePageControl];
        [self addSubview:self.sendBtn];
        [self addSubview:self.deleteBtn];
        [self.faceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.top.equalTo(@0);
            make.bottom.equalTo(@(0));
        }];

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
        _faceView = [[UIScrollView alloc] init];
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
        _facePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180, (_emojiArray.count / FACE_COUNT_PAGE + 1) * 10, 20)];
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
        _sendBtn.backgroundColor = [UIColor whiteColor];
        _sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _sendBtn.titleLabel.shadowColor = [UIColor redColor];
         _sendBtn.titleLabel.shadowOffset = CGSizeMake(1.0,1.0);
        _sendBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _sendBtn.layer.borderWidth = 0.5;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [_sendBtn addTarget:self action:@selector(sendFaceMassage:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 51, 187, 50, 30);
    }

    return _sendBtn;
}
//- (UIButton *)deleteBtn{
//    if (!_deleteBtn) {
//        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _deleteBtn.backgroundColor = [UIColor lightGrayColor];
//        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [_deleteBtn addTarget:self action:@selector(cancelFaceMessage:) forControlEvents:UIControlEventTouchUpInside];
//        _deleteBtn.frame = CGRectMake(CGRectGetMinX(self.sendBtn.frame)-50, 187, 50, 30);
//    }
//    return _deleteBtn;
//}


@end
