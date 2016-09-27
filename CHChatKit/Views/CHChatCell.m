//
//  CHChatCell.m
//  CHChatDemo
//
//  Created by Chausson on 15/11/25.
//  Copyright © 2015年 Chausson. All rights reserved.
//
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "CHChatCell.h"
#import "CHChatModel.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#import "NSString+Emoji.h"
#import "NSString+AutoSize.h"
#import "CHChatBusinessCommnd.h"
#import "CHChatConfiguration.h"
#import "CHRecordHandler.h"
#import "CHChatDefinition.h"

#define KGAP 10 //间距
#define KDATE_HEIGHT 25 //
#define KICON_SIZE 40 //头像宽高

#define KDATE_FONT [UIFont systemFontOfSize:11] //时间字体
#define KMESSAGE_FONT [UIFont systemFontOfSize:15] //内容字体

#define KCONTENT_WIDTH  [UIScreen mainScreen].bounds.size.width-KICON_SIZE*2-KGAP*3
//static  CGFloat nameLabelMargin = 0;
//static  CGFloat contentWidth = 200;
//static  CGFloat unreadWH = 10;
//@interface CHChatCell()
//@property (strong ,nonatomic ) UIView *content;
//@property (strong ,nonatomic ) UILabel *date;
//@property (strong ,nonatomic ) UIImageView *icon;
//@property (strong ,nonatomic ) UIImageView *picture;
//@property (strong ,nonatomic ) UIImageView *voice;
//@property (strong ,nonatomic ) UIButton *bubbleBtn;
//@property (strong ,nonatomic ) UILabel *message;
//@property (strong ,nonatomic ) UILabel *nameLabel;
//@property (strong ,nonatomic ) CAShapeLayer *unreadLayer;
//@property (strong ,nonatomic ) UIView *unreadContainer;
//@property (strong ,nonatomic ) UITapGestureRecognizer *imageTap;
//@property (assign ,nonatomic ) CHChatConversationType chatType;
//@property (assign ,nonatomic ) CHChatMessageType messageType;
//@end
@implementation CHChatCell

//- (instancetype )initWithType:(CHChatMessageType )type{
//    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CHChatCell chatIdentifierWithType:type]];
//    if (self) {
//        //默认的聊天模式
//        _chatType = [CHChatConfiguration standardChatDefaults].type;
//        _messageType = type;
//        switch (_chatType) {
//            case CHChatSingle://单聊
//                nameLabelMargin = 0;
//                break;
//                
//            case CHChatGrounp://群聊
//                
//                nameLabelMargin = _viewModel.isVisableLeftDirection ? 15 : 0;
//                
//                break;
//        }
//        self.backgroundColor = [UIColor clearColor];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        switch (type) {
//            case CHMessageText:
//                [self layoutTextCell];
//                break;
//            case CHMessageVoice:
//                
//                [self layoutVoicCell];
//                break;
//            case CHMessageImage:
//                [self layoutImageCell];
//                break;
//            case CHMessageLocation:
//                [self layoutImageCell];
//                break;
//                
//            default:
//                break;
//        }
//        
//    }
//   
//    return self;
//}
//-(void)initUnreadView
//{
//    _unreadContainer = [[UIView alloc]init];
//    _unreadContainer.hidden = YES;
//    _unreadContainer.backgroundColor = [UIColor clearColor];
//    _unreadLayer = [CAShapeLayer new];
//    _unreadLayer.backgroundColor = [UIColor redColor].CGColor;
//    [_unreadContainer.layer addSublayer:_unreadLayer];
//    _unreadLayer.bounds = CGRectMake(0, 0, unreadWH, unreadWH);
//    _unreadLayer.anchorPoint = CGPointMake(0, 0.5);
//    _unreadLayer.cornerRadius = unreadWH/2;
//    [self.contentView addSubview:_unreadContainer];
//
//}
//#pragma mark privite LayoutSubView
//- (void)layoutContainer{
//    _icon = [[UIImageView alloc]init];
//    _content = [[UIView alloc]init];
//    _date = [[UILabel alloc]init];
//
//    _date.layer.cornerRadius = 5;
//    _date.layer.masksToBounds  =  YES ;
//    _date.font = KDATE_FONT;
//    _date.backgroundColor = kUIColorFromRGB(0xc0c0c0);
//    _date.textAlignment = NSTextAlignmentCenter;
//    _date.textColor = [UIColor whiteColor];
//    _content.backgroundColor = [UIColor clearColor];
//    
//    [self.contentView addSubview:_icon];
//    [self.contentView addSubview:_date];
//    [self.contentView addSubview:_content];
//
//}
//- (void)layoutTextCell{
//    [self layoutContainer];
//    _message = [UILabel new];
//    _nameLabel = [UILabel new];
//    _nameLabel.font = [UIFont systemFontOfSize:12];
//    _nameLabel.textColor = [UIColor grayColor];
//    _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [_content addSubview:_bubbleBtn];
//    [_content addSubview:_message];
//    [_content addSubview:_nameLabel];
//
//    _message.numberOfLines = 0;
//    _message.font = KMESSAGE_FONT;
//    _message.textColor = [UIColor blackColor];
//    _message.backgroundColor = [UIColor clearColor];
//    //   _message.preferredMaxLayoutWidth = KCONTENT_WIDTH;
//
//   
//}
//- (void)layoutImageCell{
//    [self layoutContainer];
//    _picture = [[UIImageView alloc]init];
//    _picture.backgroundColor = [UIColor clearColor];
//    _picture.contentMode = UIViewContentModeScaleAspectFill;
//    [_picture setClipsToBounds:YES];
//    _imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    [_picture addGestureRecognizer:_imageTap];
//    [_content addSubview:_picture];
//}
//- (void)layoutVoicCell{
//    [self layoutContainer];
//    [self initUnreadView];
//    _voice = [[UIImageView alloc]init];
//
//    _bubbleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_bubbleBtn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
//    [_content addSubview:_bubbleBtn];
//    [_bubbleBtn addSubview:_voice];
//}
//
//
//
//- (void)loadViewModel:(CHChatCellViewModel *)viewModel{
// 
//    _viewModel = viewModel;
//    _date.text = viewModel.date;
//    //计算文本的尺寸
//    __weak typeof(self) weakSelf = self;
//    [_icon sd_setImageWithURL:[NSURL URLWithString:viewModel.icon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        __strong typeof(self )strongSelf = weakSelf;
//        strongSelf.icon.layer.cornerRadius = [CHChatConfiguration standardChatDefaults].iconCornerRadius;
//        strongSelf.icon.layer.masksToBounds = YES;
//    }];
//    //在 cell上输出文字并显示 Emoji 表情
//    self.message.text = [viewModel.content stringByReplacingEmojiCheatCodesWithUnicode];
//    [_bubbleBtn setBackgroundImage:[self avaiableBackgroundImageWithDirection:self.viewModel.isVisableLeftDirection] forState:UIControlStateNormal];
//    if(viewModel.image || viewModel.imageResource){
//        if (viewModel.image.length > 0) {
//            [_picture sd_setImageWithURL:[NSURL URLWithString:viewModel.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                //__strong typeof(self )strongSelf = weakSelf;
//                
//            }];
//        }else if(viewModel.imageResource && [viewModel.imageResource isKindOfClass:[UIImage class]]){
//            [_picture setImage:viewModel.imageResource];
//        }
// 
//    }
//
//    // 显示时间
//    [self makeDateConstraint];
//    [self makeContainerConstraint];
//    switch (_viewModel.type) {
//        case CHMessageText:
//            [self makeTextConstraint];
//            break;
//        case CHMessageImage:
//            [self makeImageConstraint];
//            break;
//        case CHMessageVideo:
//            break;
//        case CHMessageVoice:{
//            _voice.image = [self avaiableVoiceImageWithDirection:_viewModel.visableLeftDirection];
//            [self makeVoiceConstraint];
//        }
//            break;
//        case CHMessageLocation:
//            [self makeLocationConstraint];
//            break;
//            
//        default:
//            break;
//    }
//
//}
//- (void)makeDateConstraint{
//    CGSize dateSize = [_viewModel.date sizeWithString:_viewModel.date font:[UIFont systemFontOfSize:12]];
//    if (_viewModel.visableTime) {
//        _date.hidden = NO;
//        [_date mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.contentView);
//            make.top.equalTo(self.contentView).offset(KGAP/2);
//            make.height.equalTo(@KDATE_HEIGHT);
//            make.width.mas_equalTo(dateSize.width+10);
//        }];
//    }else {
//        _date.hidden = YES;
//        [_date mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.contentView);
//            make.top.equalTo(self.contentView);
//            make.width.equalTo(@130);
//            make.height.equalTo(@0);
//        }];
//        
//    }
//}
//- (void)makeContainerConstraint{
//    //过滤表情超过的长度
//    CGSize size = [CHChatCell boundingRectWithSize:CGSizeMake(KCONTENT_WIDTH-3*KGAP, MAXFLOAT) text:_viewModel.content font:KMESSAGE_FONT];
//
//    if (_viewModel.visableLeftDirection){
//        
//        // 左边方向
//        _nameLabel.textAlignment = NSTextAlignmentLeft;
//        [_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
//            if (_date.hidden) {
//                make.top.offset(0);
//            } else {
//                make.top.equalTo(_date.mas_bottom).offset(_viewModel.isVisableTime?KGAP*2:0);
//            }
//            make.left.offset(KGAP);
//            make.height.equalTo(@KICON_SIZE);
//            make.width.equalTo(@KICON_SIZE);
//        }];
//        [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_icon.mas_top);
//            make.left.equalTo(_icon.mas_right).offset(KGAP/2);
//            make.width.equalTo(@(size.width+KGAP*3.5)).priorityLow();
//            //            make.bottom.equalTo(self.contentView).offset(-KGAP*2.5);
//            make.width.lessThanOrEqualTo(@(KCONTENT_WIDTH));
//        }];
//        
//    }else{
//
//        _nameLabel.textAlignment = NSTextAlignmentRight;
//        // 右边方向
//        [_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
//            if (_date.hidden) {
//                make.top.equalTo(self.contentView);
//            } else {
//                make.top.equalTo(_date.mas_bottom).offset(_viewModel.isVisableTime?KGAP*2:0);
//            }
//            make.right.equalTo(self.contentView).offset(-KGAP);
//            make.height.equalTo(@KICON_SIZE);
//            make.width.equalTo(@KICON_SIZE);
//        }];
//        [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_icon.mas_top);
//            make.right.equalTo(_icon.mas_left).offset(-KGAP/2);
//            make.width.equalTo(@(size.width+KGAP*3.5)).priorityLow();
//            make.width.lessThanOrEqualTo(@(KCONTENT_WIDTH));
//            make.width.greaterThanOrEqualTo(@(5));
//        }];
//        
//    }
//    [_bubbleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_content).offset(nameLabelMargin+5);
//        make.left.right.equalTo(_content).offset(0);
//        make.bottom.equalTo(_content).offset(0);
//    }];
//}
//- (void)makeTextConstraint{
//        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(nameLabelMargin);
//            make.left.equalTo(self.contentView.mas_left).offset(KGAP*7);
//            make.right.equalTo(self.contentView.mas_right).offset(-KGAP*7);
//            make.top.equalTo(_content);
//        }];
//        if (_viewModel.visableLeftDirection){
//            [_message mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_content).offset(KGAP/2 + nameLabelMargin+5);
//                make.left.equalTo(_content).offset(KGAP*2);
//                make.right.equalTo(_content).offset(-KGAP*1.5);
//                make.bottom.equalTo(_content).offset(-KGAP/2);
//            }];
//        }else{
//            [_message mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_content).offset(KGAP/2 + nameLabelMargin+5);
//                make.left.equalTo(_content).offset(KGAP*1.5);
//                make.right.equalTo(_content).offset(-KGAP*2);
//                make.bottom.equalTo(_content).offset(-KGAP/2);
//            }];
//        }
//}
//- (void)makeVoiceConstraint{
//        CGFloat width = [UIScreen mainScreen].bounds.size.width-KICON_SIZE-KGAP*10;
//        if (_viewModel.visableLeftDirection){
//            [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_icon.mas_top);
//                make.left.equalTo(_icon.mas_right).offset(KGAP/2);
//                make.width.equalTo(@(width));
//            }];
//
//            [_unreadContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_content.mas_right).offset(5);
//                make.width.height.equalTo(@(unreadWH));
//                make.centerY.equalTo(_content.mas_centerY);
//            }];
//            [_voice mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.offset(15);
//                make.centerY.equalTo(_bubbleBtn.mas_centerY);
//                make.width.height.equalTo(@(15));
//            }];
//        }else{
//            [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_icon.mas_top);
//                make.right.equalTo(_icon.mas_left).offset(-KGAP/2);
//                make.width.equalTo(@(width));
//            }];
//            [_unreadContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(_content.mas_left).offset(-5);
//                make.width.height.equalTo(@(unreadWH));
//                make.centerY.equalTo(_content.mas_centerY);
//            }];
//            [_voice mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.right.offset(-15);
//                make.centerY.equalTo(_bubbleBtn.mas_centerY);
//                make.width.height.equalTo(@(15));
//            }];
//        }
//
//        [_unreadLayer setNeedsDisplay];
//       // _unreadContainer.hidden = NO;
//}
//- (void)makeImageConstraint{
//
//    self.picture.layer.mask = [self maskLayer:CGSizeMake(contentWidth+KGAP*2, contentWidth+KGAP*2)];
//        CGFloat gap = 0;
//        UIEdgeInsets padding  = UIEdgeInsetsMake(gap, gap, gap, gap);
//        [_picture mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.edges.equalTo(_picture.superview).with.insets(padding);
//        }];
//        
//        if (_viewModel.visableLeftDirection){
//            [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_icon.mas_top);
//                make.left.equalTo(_icon.mas_right).offset(KGAP/2);
//                make.width.equalTo(@(contentWidth));
//                make.height.equalTo(@(contentWidth));
//            }];
//            
//        }else{
//            [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_icon.mas_top);
//                make.right.equalTo(_icon.mas_left).offset(-KGAP/2);
//                make.width.equalTo(@(contentWidth+KGAP*2));
//                //          make.bottom.equalTo(self.contentView).offset(-KGAP*2.5);
//                make.height.equalTo(@(contentWidth+KGAP*2));
//            }];
//            
//        }
//
//}
//- (void)makeLocationConstraint{
//        self.picture.layer.mask =  [self maskLayer:CGSizeMake(250, 150)];
//        CGFloat gap = 0;
//        UIEdgeInsets padding  = UIEdgeInsetsMake(gap, gap, gap, gap);
//        [_picture mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.edges.equalTo(_picture.superview).with.insets(padding);
//        }];
//
//        [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_icon.mas_top);
//            make.left.equalTo(_icon.mas_right).offset(KGAP/2);
//            make.width.equalTo(@(250));
//            make.height.equalTo(@(150));
//        }];
//   
//}
//- (UIImage *)avaiableBackgroundImageWithDirection:(BOOL)left{
//    UIImage *normal ;
//    if (left) {
//        normal = [UIImage imageNamed:@"chatto_bg_normal"];
//    }else{
//        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
//    }
//        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
//    return normal;
//}
//- (UIImage *)avaiableVoiceImageWithDirection:(BOOL)left{
//    UIImage *normal ;
//    if (left) {
//        normal = [UIImage imageNamed:@"chat_left_voice"];
//    }else{
//        normal = [UIImage imageNamed:@"chat_right_voice"];
//    }
//
//    return normal;
//}
//- (void)playVoice:(UIButton *)sender{
//    _unreadContainer.hidden = YES;
//    
//    [[CHRecordHandler standardDefault] playRecordWithKey:_viewModel.voice];
//    [self.viewModel respondsUserTap];
//}
//
//- (void)imageTap:(UITapGestureRecognizer *)sender{
//    [self.viewModel respondsUserTap];
//}
//- (CAShapeLayer *)maskLayer:(CGSize )size{
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    CGFloat orginY = 20;
//    CGFloat length = 3*1.5;
//    CGFloat gapH = 5;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    // Create a path with the rectangle in it.
//    if (self.viewModel.isVisableLeftDirection) {
//
//        [path moveToPoint:CGPointMake(0, orginY)];
//        [path addLineToPoint:CGPointMake(length, orginY-4)];
//        [path addLineToPoint:CGPointMake(length, gapH)];
//        [path addQuadCurveToPoint:CGPointMake(length*2, 0) controlPoint:CGPointMake(length, 0)];
//        [path addLineToPoint:CGPointMake(width-length*2, 0)];
//        [path addQuadCurveToPoint:CGPointMake(width, gapH) controlPoint:CGPointMake(width, 0)];
//        [path addLineToPoint:CGPointMake(width, height-length)];
//        [path addQuadCurveToPoint:CGPointMake(width-length, height) controlPoint:CGPointMake(width, height)];
//        [path addLineToPoint:CGPointMake(length*2, height)];
//        [path addQuadCurveToPoint:CGPointMake(length, height-length) controlPoint:CGPointMake(length, height)];
//        [path addLineToPoint:CGPointMake(length, orginY+4)];
//        [path closePath];
//    }else{
//        [path moveToPoint:CGPointMake(width, orginY)];
//        [path addLineToPoint:CGPointMake(width-length, orginY-4)];
//        [path addLineToPoint:CGPointMake(width-length, gapH)];
//        [path addQuadCurveToPoint:CGPointMake(width-length*2, 0) controlPoint:CGPointMake(width-length, 0)];
//        [path addLineToPoint:CGPointMake(length*2, 0)];
//        [path addQuadCurveToPoint:CGPointMake(0, gapH) controlPoint:CGPointMake(0, 0)];
//        [path addLineToPoint:CGPointMake(0, height-length)];
//        [path addQuadCurveToPoint:CGPointMake(length, height) controlPoint:CGPointMake(0, height)];
//        [path addLineToPoint:CGPointMake(width-length*2, height)];
//        [path addQuadCurveToPoint:CGPointMake(width-length, height-length) controlPoint:CGPointMake(width-length, height)];
//        [path addLineToPoint:CGPointMake(width-length, orginY+4)];
//        [path closePath];
//    }
//
//    // Set the path to the mask layer.
//    maskLayer.path = path.CGPath;
//    return maskLayer;
//}
//+ (CGSize)boundingRectWithSize:(CGSize)size
//                          text:(NSString *)text
//                          font:(UIFont *)font
//{
//    NSDictionary *attribute = @{NSFontAttributeName:font};
//    
//    CGSize retSize = [text boundingRectWithSize:size
//                                             options:\
//                      NSStringDrawingTruncatesLastVisibleLine |
//                      NSStringDrawingUsesLineFragmentOrigin |
//                      NSStringDrawingUsesFontLeading
//                                          attributes:attribute
//                                             context:nil].size;
//    
//    return retSize;
//}
//+ (NSString *)chatIdentifierWithType:(CHChatMessageType )type{
//    switch (type) {
//        case CHMessageText:
//            return @"text";
//            break;
//        case CHMessageVoice:
//            return @"voice";
//            break;
//        case CHMessageImage:
//            return @"image";
//            break;
//        case CHMessageLocation:
//            return @"location";
//            break;
//        default:
//            return @"chat";
//            break;
//    }
//   
//}
//+ (CGFloat)getHeightWithViewModel:(CHChatCellViewModel *)viewModel{
//   // CGFloat normalHeight = 115;
//    CGFloat height = 115;
// 
//    switch (viewModel.type) {
//        case CHMessageText:{
//            CGSize size = [CHChatCell boundingRectWithSize:CGSizeMake(KCONTENT_WIDTH-3*KGAP, MAXFLOAT) text:viewModel.content font:KMESSAGE_FONT];
//            CGFloat h = size.height +KICON_SIZE*2+KGAP;
//            
//            height =  (MAX(h, height));
//        }break;
//        case CHMessageVoice:
//            
//            break;
//        case CHMessageLocation:
//            height = 220;
//            break;
//        case CHMessageImage:
//            height = KICON_SIZE*2+KGAP +(contentWidth);
//            break;
//        default:
//            
//            break;
//    }
//    
//    if(!viewModel.isVisableTime){
//        height = height-(KICON_SIZE+KGAP);
//    }
//
//    return height;
//}
@end
