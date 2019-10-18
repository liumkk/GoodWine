//
//  GMOrderProductTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderProductTableViewCell.h"

@implementation GMOrderProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
    }
    return self;
}

- (void)updateOrderProductTableCellWithModel:(ShoppCarInfoModel *)model {
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.productPic]];
    self.titleLabel.text = model.productName;
    self.contentLabel.text = model.productSubTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.currentPrice floatValue]];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",model.quantity];
}

- (void)updateOrderProductTableCellWithOrderItem:(GMOrderItem *)item {
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:item.productPic]];
    self.titleLabel.text = item.productName;
//    self.contentLabel.text = item.productSubTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[item.productPrice floatValue]];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",item.productQuantity];
}

- (void)setupConstraints {
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(80.f, 80.f));
    }];
    
    self.titleImageView.bounds = CGRectMake(0, 0, 80.f, 80.f);
    [UIView maskCorner:self.titleImageView rectCorner:UIRectCornerAllCorners corner:5.f];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView);
        make.left.equalTo(self.titleImageView.mas_right).offset(10.f);
        make.right.equalTo(self.contentView).offset(-10.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.left.right.equalTo(self.titleLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10.f);
        make.left.equalTo(self.titleLabel);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

+ (CGFloat)heightForCell {
    
    return 100.f;
    
}

#pragma mark --init subviews

- (UIImageView *)titleImageView {
    if (! _titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleImageView];
    }
    return _titleImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = Font(16.f);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = COLOR_GRAY_150;
        _contentLabel.font = Font(14.f);
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)priceLabel {
    if (! _priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numLabel];
    }
    return _numLabel;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [UIView creatDefaultLineView];
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
}

@end
