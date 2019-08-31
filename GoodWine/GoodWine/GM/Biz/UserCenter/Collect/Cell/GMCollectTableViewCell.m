//
//  GMCollectTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCollectTableViewCell.h"

@implementation GMCollectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)updateCollectCellWithModel:(CollectProductItem *)item {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:item.pic]];
    self.titleLabel.text = item.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld元/瓶",item.price];
    self.detailLabel.text = [NSString stringWithFormat:@"%ld度/%@",item.alcohol,item.productCategoryName];
    self.saleLabel.text = [NSString stringWithFormat:@"销量:%ld%@",item.sale,item.unit];
}

- (void)setupConstraints {
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(80.f, 80.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView).offset(10.f);
        make.left.equalTo(self.headerImageView.mas_right).offset(10.f);
        make.right.equalTo(self.contentView).offset(-10.f);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView.mas_bottom).offset(-10.f);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel);
        make.left.equalTo(self.priceLabel.mas_right).offset(5.f);
    }];
    
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10.f);
    }];
    
}

- (UIImageView *)headerImageView {
    if (! _headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = Font_16;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (! _priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.font = Font_15;
        _priceLabel.textColor = COLOR_THEME_COLOR;
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)detailLabel {
    if (! _detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.font = Font_12;
        _detailLabel.textColor = COLOR_GRAY_150;
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UILabel *)saleLabel {
    if (! _saleLabel) {
        _saleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _saleLabel.font = Font_12;
        _saleLabel.textColor = COLOR_GRAY_150;
        _saleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_saleLabel];
    }
    return _saleLabel;
}


@end
