//
//  ChatAssistanceView.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/21.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "CHChatAssistanceView.h"
#import "CHChatConfiguration.h"
#import "CHChatAssistance.h"
#import "GrayPageControl.h"
#define CHATASSISTANCE_COUNT_ROW 2 // 行数

#define CHATASSISTANCE_COUNT_CLU 4 // 每行个数

#define CHATASSISTANCE_ITEM_SIZE 66 * [UIScreen mainScreen].bounds.size.height / 667

#define CHATASSISTANCE_COUNT_PAGE (CHATASSISTANCE_COUNT_ROW * CHATASSISTANCE_COUNT_CLU)

#define ITEM_DISTANCE_SIZE 20 * [UIScreen mainScreen].bounds.size.width / 375
@interface CHChatAssistanceView ()<UIScrollViewDelegate>{

}

@end

@implementation CHChatAssistanceView{
    UIScrollView *chatAssistanceScrollView;
    NSMutableArray <CHChatAssistance *>* _assistances;
    GrayPageControl *assistancePageControl;
    BOOL progressing;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self layOutSubView];
    }
    return self;
}

#pragma mark privite layOutSubviews
- (void)layOutSubView
{
    _assistances = [NSMutableArray array];
    chatAssistanceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 190)];
    chatAssistanceScrollView.pagingEnabled = YES;

    chatAssistanceScrollView.showsHorizontalScrollIndicator = NO;
    chatAssistanceScrollView.showsVerticalScrollIndicator = NO;
    chatAssistanceScrollView.delegate = self;


    [self addSubview:chatAssistanceScrollView];
    
}
- (void)setConfig:(CHChatConfiguration *)config{
    _config = config;
    NSArray <NSString *>* assistanceItems = config.assistances;
    
    [assistanceItems enumerateObjectsUsingBlock:^(NSString * _Nonnull identifier, NSUInteger i, BOOL * _Nonnull stop) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CHChatAssistance *assistance = [self fetchAssistance:identifier];
        [itemButton addTarget:self action:@selector(itemButton:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.tag = i;
        CGFloat x = ITEM_DISTANCE_SIZE * (i % 4 + 1) + (i % 4) * CHATASSISTANCE_ITEM_SIZE + [UIScreen mainScreen].bounds.size.width * (i / 8);
        CGFloat y;
        if (i / 4 % 2 == 0) {
            y = ITEM_DISTANCE_SIZE;
        }else{
            y = CHATASSISTANCE_ITEM_SIZE + 2 * ITEM_DISTANCE_SIZE;
        }
        itemButton.frame = CGRectMake(x, y, CHATASSISTANCE_ITEM_SIZE, CHATASSISTANCE_ITEM_SIZE);
        [itemButton setBackgroundImage:[UIImage imageNamed:assistance.picture] forState:UIControlStateNormal];
        [chatAssistanceScrollView addSubview:itemButton];
        
        UILabel *itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(itemButton.frame.origin.x, CGRectGetMaxY(itemButton.frame), itemButton.frame.size.width, 15)];
        itemTitle.text = assistance.title;
        itemTitle.textColor = [UIColor lightGrayColor];
        itemTitle.font = [UIFont systemFontOfSize:12];
        itemTitle.textAlignment = NSTextAlignmentCenter;
        [chatAssistanceScrollView addSubview:itemTitle];
    }];
    chatAssistanceScrollView.contentSize = CGSizeMake((assistanceItems.count / CHATASSISTANCE_COUNT_PAGE + 1) * [UIScreen mainScreen].bounds.size.width, 190);
    assistancePageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(assistancePageControl.frame.origin.x, 190, assistancePageControl.frame.size.width, assistancePageControl.frame.size.height)];
    [assistancePageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    assistancePageControl.numberOfPages = assistanceItems.count / CHATASSISTANCE_COUNT_PAGE + 1;
    assistancePageControl.currentPage = 0;
    [self addSubview:assistancePageControl];
}
- (CHChatAssistance *)fetchAssistance:(NSString *)identifier{
    Class prettyClass = [AssistanceDic objectForKey:identifier];
    __block CHChatAssistance *assinstance ;
        [_assistances enumerateObjectsUsingBlock:^(CHChatAssistance * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([prettyClass isSubclassOfClass:obj.class]  ) {
                assinstance = obj;
                *stop = YES;
            }
        }];
    if (assinstance) {
        return assinstance;
    }else{
        assinstance = [[prettyClass alloc]init];
        [_assistances addObject:assinstance];
        return assinstance;
    }

}
#pragma mark SCrollViewDelagate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [assistancePageControl setCurrentPage:(chatAssistanceScrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width)];
    [assistancePageControl updateCurrentPageDisplay];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)pageChange:(id)sender {
    [chatAssistanceScrollView setContentOffset:CGPointMake(assistancePageControl.currentPage * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    [assistancePageControl setCurrentPage:assistancePageControl.currentPage];
}

- (void)itemButton:(UIButton *)sender {
    NSArray <NSString *>* assistanceItems = _config.assistances;
    CHChatAssistance *assistance = [self fetchAssistance:assistanceItems[sender.tag]];
    [assistance executeEvent:self.observer];
}



@end
