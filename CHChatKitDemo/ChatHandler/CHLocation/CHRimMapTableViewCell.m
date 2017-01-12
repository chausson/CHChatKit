//
//  RimMapTableViewCell.m
//  baiduSwift
//
//  Created by 郭金涛 on 16/9/13.
//  Copyright © 2016年 heiyan. All rights reserved.
//

#import "CHRimMapTableViewCell.h"
@interface CHRimMapTableViewCell()
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *address;
@property (nonatomic, strong)UIImageView *mark;
@end
@implementation CHRimMapTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadUI];
    }
    return self;
}
- (void)loadUI{
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 50, 20)];
    self.name.textColor = [UIColor blackColor];
    self.name.font = [UIFont systemFontOfSize:17];
    [self addSubview:self.name];
    
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, [UIScreen mainScreen].bounds.size.width - 50, 20)];
    self.address.textColor = [UIColor grayColor];
    self.address.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.address];
    
    self.mark = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 20, 30, 30)];
    self.mark.image = [UIImage imageNamed:@"mark"];
    [self addSubview:self.mark];
}
- (void)loadCellViewModel:(CHRimMapCellViewModel *)cellViewModel
{
    self.name.text = cellViewModel.name;
    self.address.text = cellViewModel.address;
    self.mark.hidden = !cellViewModel.isChoose;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
