//
//  CHChatMessageCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"
#import "CHChatConfiguration.h"
#import "CHMessageViewModel.h"
@interface CHChatMessageCell()

@property (strong ,nonatomic ) UILabel *date;
@property (strong ,nonatomic ) UIImageView *icon;
@property (strong ,nonatomic ) UIImageView *picture;
@property (strong ,nonatomic ) UIImageView *voice;
@property (strong ,nonatomic ) UIButton *bubbleBtn;

@property (strong ,nonatomic ) UILabel *name;
@property (strong ,nonatomic ) UITapGestureRecognizer *imageTap;

@end

@implementation CHChatMessageCell

+ (void)load{
    [self registerMessageType];
}
+ (CHChatMessageType )registerMessageType{
    @synchronized (self) {
        if (!chatCellMessageCatagory) {
            chatCellMessageCatagory = [NSMutableDictionary dictionary];
        }
       
        [chatCellMessageCatagory setObject:[self class] forKey:NSStringFromClass([self class])];
    }
 
    return CHMessageNone;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layout];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layout];
    }
    return self;
}
- (void)layout {
    //默认的聊天模式
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self layoutContainer];

}
#pragma mark privite LayoutSubView
- (void)layoutContainer{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.date];
    [self.contentView addSubview:self.messageContainer];
    [self.contentView addSubview:self.name];

}
#pragma mark 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
- (UIView *)messageContainer{
    if (!_messageContainer) {
        _messageContainer = [[CHMessageContentView alloc]init];
        _messageContainer.backgroundColor = [UIColor clearColor];
    }
    return _messageContainer;
}
- (UILabel *)_date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.layer.cornerRadius = 5;
        _date.layer.masksToBounds  =  YES ;
        //    _date.font = KDATE_FONT;
        _date.backgroundColor = [CHChatConfiguration standardChatDefaults].cellDateBackgroundColor;
        _date.textAlignment = NSTextAlignmentCenter;
        _date.textColor = [UIColor whiteColor];
    }
    return _date;
}
- (UILabel *)name{
    if (!_name) {
        _name = [UILabel new];
        _name.font = [UIFont systemFontOfSize:12];
        _name.textColor = [UIColor grayColor];
    }
    return _name;
}

- (void)loadViewModel:(CHMessageViewModel *)viewModel{
        self.viewModel = viewModel;
}
@end
