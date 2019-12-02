//
//  GMCouponTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCouponTableViewCell.h"

@implementation GMCouponTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_TABLE_BG_RAY;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgImageView.mas_centerY);
        make.left.equalTo(self.bgImageView).offset(26.f);
        make.width.mas_equalTo(Width_Screen - 126.f);
    }];
    
    [self.validLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.bgImageView.mas_centerY);
        make.right.equalTo(self.titleLabel.mas_right);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.right.equalTo(self.bgImageView.mas_right).offset(-40.f);
    }];
}

- (void)updateCouponCellWithModel:(CouponInfoModel *)model {
    self.titleLabel.text = model.name;
    self.validLabel.text = [NSString stringWithFormat:@"有效期至：%@",model.endTime];
    if (model.receive == 0) {
        self.statusLabel.text = @"领取";
        self.titleLabel.textColor = COLOR_TEXT_BLACK;
        self.statusLabel.textColor = COLOR_TEXT_BLACK;
        self.validLabel.textColor = COLOR_TEXT_BLACK;
    } else {
        self.titleLabel.textColor = COLOR_GRAY_150;
        self.statusLabel.textColor = COLOR_GRAY_150;
        self.validLabel.textColor = COLOR_GRAY_150;
        self.statusLabel.text = @"已领取";
    }
    
}

#pragma mark --init subviews

- (UIImageView *)bgImageView {
    if (! _bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_bg"]];
        _bgImageView.layer.shadowOffset = CGSizeMake(1,2);
        _bgImageView.layer.shadowOpacity = 0.3;
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = Font_15;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)validLabel {
    if (! _validLabel) {
        _validLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _validLabel.font = Font_13;
        [self.contentView addSubview:_validLabel];
    }
    return _validLabel;
}

- (UILabel *)statusLabel {
    if (! _statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.font = Font_16;
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

@end
