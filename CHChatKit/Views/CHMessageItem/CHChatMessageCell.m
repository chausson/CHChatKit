//
//  CHChatMessageCell.m
//  CHChatKit
//
//  Created by Chausson on 16/9/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatMessageCell.h"
#import "CHChatConfiguration.h"
#import "CHChatMessageViewModel.h"
#import "CHChatDefinition.h"
#import "Masonry.h"
#import "NSObject+KVOExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CHImage.h"
#import "UIImageView+CHExtension.h"
NSMutableDictionary <NSString *,Class>const * ChatCellMessageCatagory = nil;

static CGFloat const cellMessageDateHeight = 25.0f;
static CGFloat const cellAvatarWidth = 40.0f;
static CGFloat const cellAvatarHeight = cellAvatarWidth;
static CGFloat const cellContentGap = 10.0f; // 每个控件的间隔
static CGFloat const cellContentBottom = 16.0f;
static NSString *refreshName = nil;
@implementation CHChatMessageCell
+ (void)registerNotificationRefresh:(NSString *)name{
    if (refreshName.length > 0) {
        return;
    }
    refreshName = name;
}
+ (void)registerSubclass{
    if ([self conformsToProtocol:@protocol(CHChatMessageCellCategory)]) {

        CHChatMessageType type = [self messageCategory];
        Class<CHChatMessageCellCategory> aClass = self;
            if (!ChatCellMessageCatagory) {
                ChatCellMessageCatagory = [NSMutableDictionary dictionary];
            }
            [ChatCellMessageCatagory setObject:aClass forKey:@(type)];
    }else{
        NSAssert(NO, @"没有注册子类CHCHatMessageCell的协议");
    }
}
+ (CHChatMessageType )messageCategory{

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
    self.backgroundColor = self.superview.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self ch_registerForKVO:@[@"viewModel.sendingState",@"viewModel.avatar"]];
    [self layoutContainer];

}
#pragma mark privite LayoutSubView
- (void)layoutContainer{
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.date];
    [self.contentView addSubview:self.nickName];
    [self.contentView addSubview:self.messageContainer];
    [self.contentView addSubview:self.stateIndicatorView];
    [self.contentView addSubview:self.resendBtn];
}
#pragma mark - Override
- (void)updateConstraints{
    [super updateConstraints];
    //过滤表情超过的长度
    
    CGSize dateSize = [self boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width, 8000) text:self.viewModel.date font:[UIFont systemFontOfSize:12]];
    if (self.viewModel.visableTime) {
        [self.date mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(cellContentGap/2);
            make.height.equalTo(@(cellMessageDateHeight));
            make.width.mas_equalTo(dateSize.width+10);
        }];
    }else {
        [self.date mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
    }
    CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
    CGFloat widthMax = width - (cellAvatarWidth +cellContentGap*2)*2;
    CGFloat nickNameHeight = self.viewModel.nickName.length > 0?20:0;
    if ([self isOwner]){
        [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.viewModel.visableTime) {
                make.top.equalTo(_date.mas_bottom).offset(cellContentGap);
            }else{
                make.top.offset(cellContentGap);
            }
            make.right.offset(-cellContentGap);
            make.height.equalTo(@(cellAvatarHeight));
            make.width.equalTo(@(cellAvatarWidth));
        }];
        [self.nickName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avatarImageView.mas_top);
            make.height.equalTo(@(nickNameHeight));
            make.width.mas_lessThanOrEqualTo(@(widthMax)).priorityHigh();
            make.right.equalTo(_avatarImageView.mas_left).offset(-cellContentGap);
        }];
        [self.messageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_avatarImageView.mas_left).offset(-cellContentGap);
            make.top.equalTo(_nickName.mas_bottom);
            make.bottom.equalTo(self.contentView).offset(-cellContentBottom).priorityLow();
            make.width.mas_lessThanOrEqualTo(@(widthMax)).priorityHigh();
      //      make.width.equalTo(@(widthMax));
        }];
        [self.stateIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContainer.mas_left).offset(-cellContentGap/2);
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            //      make.width.equalTo(@(widthMax));
        }];
        [self.resendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContainer.mas_left).offset(-cellContentGap/2);
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            make.height.equalTo(@(25));
            make.width.equalTo(@(25));
            //      make.width.equalTo(@(widthMax));
        }];
        
    }else{
        [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.viewModel.visableTime) {
                make.top.equalTo(_date.mas_bottom).offset(cellContentGap);
            }else{
                make.top.offset(cellContentGap);
            }

            make.left.offset(cellContentGap);
            make.height.equalTo(@(cellAvatarHeight));
            make.width.equalTo(@(cellAvatarWidth));
        }];
        [self.nickName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avatarImageView.mas_top);
            make.height.equalTo(@(nickNameHeight));
            make.width.mas_lessThanOrEqualTo(@(widthMax)).priorityHigh();
            make.left.equalTo(_avatarImageView.mas_right).offset(cellContentGap);
        }];
        [self.messageContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nickName.mas_bottom);
            make.left.equalTo(_avatarImageView.mas_right).offset(cellContentGap);
            make.bottom.equalTo(self.contentView).offset(-cellContentBottom).priorityLow();
            make.width.mas_lessThanOrEqualTo(@(widthMax)).priorityHigh();
           // make.width.equalTo(@(widthMax));
        }];
        [self.stateIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContainer.mas_right).offset(cellContentGap/2);
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            //      make.width.equalTo(@(widthMax));
        }];
        [self.resendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContainer.mas_right).offset(cellContentGap/2);
            make.centerY.equalTo(self.messageContainer.mas_centerY);
            make.height.equalTo(@(25));
            make.width.equalTo(@(25));
            //      make.width.equalTo(@(widthMax));
        }];
    }
}
- (CGSize)boundingRectWithSize:(CGSize)size
                          text:(NSString *)text
                          font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}
- (void)loadViewModel:(CHChatMessageViewModel *)viewModel{
    self.nickName.text = viewModel.nickName;
    self.date.text = viewModel.date;
    self.nickName.hidden = !(viewModel.nickName.length > 0);
    self.viewModel = viewModel;
    [self setAvatarImage:viewModel.avatar];

    [self reloadSendingState];
    
    [self updateConstraints];

}
- (void)userAction:(UITapGestureRecognizer *)sender{
    UIImageView *view = (UIImageView *)sender.view;
    
    NSLog(@"user aCgion  size = %@",NSStringFromCGSize(view.image.size));
}
- (void)containerAction:(UITapGestureRecognizer *)sender{
    NSLog(@"containerAction aCgion ");

}
- (void)resend{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"重发该消息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancel];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *resend = [UIAlertAction actionWithTitle:@"重发" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.viewModel resend];
        [strongSelf.stateIndicatorView startAnimating];
    }];
    [alert addAction:resend];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}
- (void)reloadTableView{
    if (refreshName.length > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:refreshName object:nil];
    }
}
- (BOOL)isOwner{
    return  [self.reuseIdentifier containsString:CHChatCellOwnerIdentifier];
}
- ( __kindof CHChatMessageViewModel *)viewModel{
    return _viewModel;
}
- (void)setAvatarImage:(NSString *)avatar{
    __weak typeof(self) weakSelf = self;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            CGSize containerSize = CGSizeMake(cellAvatarWidth, cellAvatarHeight);
            if (!CGSizeEqualToSize(image.size, containerSize) && [strongSelf.viewModel.avatar isEqualToString:imageURL.absoluteString]) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                    UIImage *fitImage = [image ch_fitToSize:containerSize];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        strongSelf.avatarImageView.image = fitImage;
                        strongSelf.avatarImageView.layer.cornerRadius = strongSelf.avatarCornerRadius;
                        strongSelf.avatarImageView.layer.shouldRasterize = TRUE;
                        strongSelf.avatarImageView.layer.rasterizationScale = strongSelf.avatarImageView.layer.contentsScale;
                        strongSelf.avatarImageView.layer.masksToBounds = YES;
                    });
                });
           
            }

            
        }
        
        
    }];
}
- (void)reloadSendingState{
    switch (self.viewModel.sendingState) {
        case CHMessageSending:{
            [self.resendBtn setHidden:YES];
            [self.stateIndicatorView startAnimating];
            break;
        }case CHMessageSendFailure:{
            [self.stateIndicatorView stopAnimating];
            [self.resendBtn setHidden:NO];
            break;
            
        }default:
            [self.resendBtn setHidden:YES];
            [self.stateIndicatorView stopAnimating];
            break;
    }
}

#pragma mark 懒加载
- (void)setAvatarCornerRadius:(CGFloat)avatarCornerRadius{
    _avatarCornerRadius = avatarCornerRadius;

}

- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userAction:)];
        
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.opaque = YES;
        _avatarImageView.userInteractionEnabled = YES;
        [_avatarImageView addGestureRecognizer:tap];
    }
    return _avatarImageView;
}
- (UIView *)messageContainer{
    if (!_messageContainer) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(containerAction:)];
        _messageContainer = [[CHMessageContentView alloc]init];
        _messageContainer.opaque = YES;
        _messageContainer.backgroundColor = self.contentView.backgroundColor;
       // _messageContainer.backgroundColor = [UIColor blueColor];
        [_messageContainer addGestureRecognizer:tap];
    }
    return _messageContainer;
}
- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.layer.cornerRadius = 5;
        _date.opaque = YES;
        _date.layer.masksToBounds  =  YES ;
        _date.font = [UIFont systemFontOfSize:11] ;//时间字体
        _date.backgroundColor = [UIColor colorWithRed:192.0/ 255.0 green:192.0/255.0 blue:192.0 / 255.0 alpha:1];
        _date.textAlignment = NSTextAlignmentCenter;
        _date.textColor = [UIColor whiteColor];
    }
    return _date;
}
- (UILabel *)nickName{
    if (!_nickName) {
        _nickName = [UILabel new];
        _nickName.font = [UIFont systemFontOfSize:12];
        _nickName.textColor = [UIColor grayColor];

    }
    return _nickName;
}
- (UIActivityIndicatorView *)stateIndicatorView{
    if (!_stateIndicatorView) {
        _stateIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _stateIndicatorView.opaque = YES;
        _stateIndicatorView.backgroundColor = self.contentView.backgroundColor;
        [_stateIndicatorView startAnimating];
        
    }
    return _stateIndicatorView;
}
- (UIButton *)resendBtn{
    if (!_resendBtn) {
        _resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _resendBtn.backgroundColor = self.contentView.backgroundColor;
        _resendBtn.hidden = YES;
        _resendBtn.opaque = YES;
        [_resendBtn setBackgroundImage:[UIImage imageNamed:@"MessageSendFail"] forState:UIControlStateNormal];
        [_resendBtn addTarget:self action:@selector(resend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resendBtn;
}
#pragma mark KVO
- (void)ch_ObserveValueForKey:(NSString *)key ofObject:(id)obj change:(NSDictionary *)change{
    if ([key isEqualToString:@"viewModel.sendingState"]) {
        [self reloadSendingState];
    }else if ([key isEqualToString:@"viewModel.avatar"]) {
         NSString *avatar = change[@"new"];
        [self setAvatarImage:avatar];
    }
}
- (void)dealloc{
    [self ch_unregisterFromKVO];
    
}


@end
