//
//  GMAddressManageTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddressManageTableViewCell.h"

@implementation GMAddressManageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLOR_GRAY_244;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10.f);
        make.top.equalTo(self.bgView).offset(10.f);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5.f);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(5.f);
        make.height.mas_equalTo(20.f);
    }];
    
}

- (void)updateAddressCellWithModel:(GMAddressInfoModel *)model {
    self.nameLabel.text = model.name;
    self.phoneLabel.text = model.phoneNumber;
    self.addressLabel.text = model.detailAddress;
}

#pragma mark --init subviews

- (UIView *)bgView {
    if (! _bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10.f;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)nameLabel {
    if (! _nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = Font_14;
        _nameLabel.textColor = [UIColor blackColor];
        [self.bgView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (! _phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.font = Font_14;
        [self.bgView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel {
    if (! _addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.font = Font_14;
        [self.bgView addSubview:_addressLabel];
    }
    return _addressLabel;
}

@end
