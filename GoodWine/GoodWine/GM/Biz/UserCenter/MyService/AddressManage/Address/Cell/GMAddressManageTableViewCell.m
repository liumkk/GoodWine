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
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 5, 15));
    }];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(28.f);
        make.left.equalTo(self.contentView).offset(41.f);
        make.size.mas_equalTo(CGSizeMake(19.f, 22.f));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_right).offset(10.f);
        make.top.equalTo(self.contentView).offset(25.f);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(5.f);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10.f);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-55.f);
    }];
    
}

- (void)updateAddressCellWithModel:(AddressInfoModel *)model {
    self.nameLabel.text = model.name;
    self.phoneLabel.text = model.phoneNumber;
    self.addressLabel.text = model.detailAddress;
}

#pragma mark --init subviews

- (UIImageView *)bgImageView {
    if (! _bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collection_bg_right"]];
//        _bgImageView.layer.shadowOffset = CGSizeMake(0,1);
//        _bgImageView.layer.shadowOpacity = 0.3;
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UIImageView *)addressImageView {
    if (! _addressImageView) {
        _addressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address_icon"]];
        [self.contentView addSubview:_addressImageView];
    }
    return _addressImageView;
}

- (UILabel *)nameLabel {
    if (! _nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = Font_14;
        _nameLabel.textColor = COLOR_THEME_COLOR;
        [self.bgImageView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (! _phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.font = Font_14;
        [self.bgImageView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel {
    if (! _addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.font = Font_14;
        [self.bgImageView addSubview:_addressLabel];
    }
    return _addressLabel;
}

@end
