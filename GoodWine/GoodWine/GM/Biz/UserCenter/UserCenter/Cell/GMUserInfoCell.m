//
//  GMUserInfoCell.m
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserInfoCell.h"

#define HeaderView_width        60.f

@implementation GMUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.headerImageiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HeaderView_width, HeaderView_width));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageiew.mas_right).offset(20.f);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-7.f);
    }];
    
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(7.f);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10.f);
    }];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.mas_equalTo(LINE_HEIGHT);
//    }];
}

- (void)updateCell {
    
}

+ (CGFloat)heightForCell {
    
    return 100.f;
    
}

#pragma mark --init subviews

- (UIImageView *)headerImageiew {
    if (! _headerImageiew) {
        _headerImageiew = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImageiew.image = [UIImage imageNamed:@"goodWine"];
        _headerImageiew.clipsToBounds = YES;
        _headerImageiew.layer.cornerRadius = HeaderView_width/2;
        [self.contentView addSubview:_headerImageiew];
    }
    return _headerImageiew;
}

- (UILabel *)nameLabel {
    if (! _nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = [NSString stringWithFormat:@"昵称: %@",UserCenter.userInfoModel.nickname];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.f];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)phoneNumLabel {
    if (! _phoneNumLabel) {
        _phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneNumLabel.text = [NSString stringWithFormat:@"手机号码: %@",UserCenter.userInfoModel.phone];
        _phoneNumLabel.font = Font_14;
        _phoneNumLabel.textColor =[UIColor blackColor];
        [self.contentView addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [UIView creatDefaultLineView];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

-(UILabel *)rightLabel {
    if (! _rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.text = @"美酒快线会员";
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = Font_14;
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

@end
