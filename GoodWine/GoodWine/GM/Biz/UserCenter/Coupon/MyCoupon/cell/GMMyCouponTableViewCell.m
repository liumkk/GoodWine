//
//  GMMyCouponTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMyCouponTableViewCell.h"

@implementation GMMyCouponTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.left.equalTo(self.bgImageView).offset(26.f);
        make.width.mas_equalTo(Width_Screen - 126.f);
    }];
    
    [self.validLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.titleLabel.mas_right);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.right.equalTo(self.bgImageView.mas_right).offset(-40.f);
    }];
}

- (void)updateMyCouponCellWithModel:(MyCouponInfoModel *)model {
    self.titleLabel.text = model.couponItem.name;
    self.validLabel.text = [NSString stringWithFormat:@"有效期至：%@",model.couponItem.endTime];
    if ([model.useStatus integerValue] == 0) {
        self.statusLabel.text = @"可使用";
    } else if ([model.useStatus integerValue] == 1) {
        self.statusLabel.text = @"已使用";
    } else {
        self.statusLabel.text = @"已过期";
    }
    
}

#pragma mark --init subviews

- (UIImageView *)bgImageView {
    if (! _bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_bg"]];
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
