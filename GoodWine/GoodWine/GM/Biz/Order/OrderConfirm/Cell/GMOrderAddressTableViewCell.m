//
//  GMOrderAddressTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderAddressTableViewCell.h"

@implementation GMOrderAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-5.f);
        make.left.equalTo(self.contentView).offset(16.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
    }];
    
    [self.receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(5.f);
        make.left.right.equalTo(self.addressLabel);
    }];
}

- (void)updateCellWithModel:(AddressInfoModel *)model {
    if (!model.detailAddress) {
        self.addressLabel.text = @"请选择地址";
    } else {
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",model.city,model.region,model.detailAddress];
        self.receiverLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,model.phoneNumber];
    }
}

- (void)updateCellWithOrderDetailModel:(GMOrderDetailInfoModel *)model {
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",model.receiverCity,model.receiverRegion,model.receiverDetailAddress];
    self.receiverLabel.text = [NSString stringWithFormat:@"%@ %@",model.receiverName,model.receiverPhone];
}

#pragma mark --init subviews

- (UILabel *)addressLabel {
    if (! _addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.font = Font_16;
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (UILabel *)receiverLabel {
    if (! _receiverLabel) {
        _receiverLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _receiverLabel.font = Font_16;
        [self.contentView addSubview:_receiverLabel];
    }
    return _receiverLabel;
}

@end
