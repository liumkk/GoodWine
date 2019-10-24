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
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageiew.mas_right).offset(20.f);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(85.f, 30.f));
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
        make.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100.f, 25.f));
    }];
    
    self.headerImageiew.bounds = CGRectMake(0, 0, HeaderView_width, HeaderView_width);
    [UIView maskCorner:self.headerImageiew rectCorner:UIRectCornerAllCorners corner:HeaderView_width/2.f];

    self.rightLabel.bounds = CGRectMake(0, 0, 105.f, 25.f);
    [UIView maskCorner:self.rightLabel rectCorner:UIRectCornerTopLeft | UIRectCornerBottomLeft corner:25.f];
}

- (void)updateCell {
    if (UserCenter.isLogin) {
        self.loginBtn.hidden = YES;
        self.nameLabel.hidden = NO;
        self.phoneNumLabel.hidden = NO;
        self.nameLabel.text = [NSString stringWithFormat:@"昵称: %@",UserCenter.userInfoModel.username];
        self.phoneNumLabel.text = [NSString stringWithFormat:@"手机号码: %@",UserCenter.userInfoModel.phone];
    } else {
        self.nameLabel.hidden = YES;
        self.phoneNumLabel.hidden = YES;
        self.loginBtn.hidden = NO;
    }
    
}

+ (CGFloat)heightForCell {
    
    return 100.f;
    
}

#pragma mark --init subviews

- (UIImageView *)headerImageiew {
    if (! _headerImageiew) {
        _headerImageiew = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImageiew.image = [UIImage imageNamed:@"goodWine"];
//        _headerImageiew.clipsToBounds = YES;
//        _headerImageiew.layer.cornerRadius = HeaderView_width/2;
        [self.contentView addSubview:_headerImageiew];
    }
    return _headerImageiew;
}

- (UILabel *)nameLabel {
    if (! _nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = [NSString stringWithFormat:@"昵称: %@",UserCenter.userInfoModel.username];
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
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = Font_14;
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.backgroundColor = COLOR_THEME_COLOR;
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (UIButton *)loginBtn {
    if (! _loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn setTitle:@"去登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
//        UIImage *image = [[UIImage imageNamed:@"gray_bg_yuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"border_red"] forState:UIControlStateNormal];
//        [_loginBtn setTintColor:[UIColor whiteColor]];
        _loginBtn.titleLabel.font = Font(15.f);
        _loginBtn.hidden = YES;
        [self.contentView addSubview:_loginBtn];
    }
    return _loginBtn;
}

@end
