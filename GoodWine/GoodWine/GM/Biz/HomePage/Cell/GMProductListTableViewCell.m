//
//  GMProductListTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/11/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductListTableViewCell.h"

@implementation GMProductListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_TABLE_BG_RAY;
        [self setupConstraints];
        
    }
    return self;
}

- (void)updateProductListCellWithModel:(HomePageTypeItem *)item {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:item.pic]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@  %@",item.subTitle,item.purity];
    self.contentLabel.text = item.detailTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元/%@",item.price,item.unit];
    self.detailLabel.text = [NSString stringWithFormat:@"%@°%@",item.alcohol,item.productCategoryName];
    self.saleLabel.text = [NSString stringWithFormat:@"%ld人购买",item.sale];
}

- (void)setupConstraints {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2, 10, 5, 10));
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(6.f);
        make.size.mas_equalTo(CGSizeMake(80.f, 80.f));
    }];
    
    self.headerImageView.bounds = CGRectMake(0, 0, 80.f, 80.f);
    [UIView maskCorner:self.headerImageView rectCorner:UIRectCornerAllCorners corner:5.f];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView).offset(2.f);
        make.left.equalTo(self.headerImageView.mas_right).offset(10.f);
        make.right.equalTo(self.bgView.mas_right).offset(-10.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3.f);
        make.right.equalTo(self.bgView.mas_right).offset(-10.f);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView.mas_bottom).offset(-2.f);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel);
        make.left.equalTo(self.priceLabel.mas_right).offset(5.f);
    }];
    
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailLabel);
        make.right.equalTo(self.bgView.mas_right).offset(-10.f);
    }];
    
}

- (UIImageView *)bgView {
    if (! _bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collection_bg_right"]];
        _bgView.layer.shadowOffset = CGSizeMake(1,2);
        _bgView.layer.shadowOpacity = 0.3;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
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

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = Font_14;
        _contentLabel.textColor = COLOR_GRAY_150;
        _contentLabel.numberOfLines = 2;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
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
