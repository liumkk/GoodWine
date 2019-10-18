//
//  GMProductDetailCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductDetailCell.h"

@implementation GMProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)updateProductDetailCellWithModel:(GMProductDetailModel *)productDetailModel {
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:productDetailModel.pic]];
    self.promotionPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[productDetailModel.price floatValue] ];
    NSString *originalPrice = [NSString stringWithFormat:@"原价:￥%.2f",[productDetailModel.originalPrice floatValue]];
    self.originalPriceLabel.attributedText = [NSString setMiddleLinePriceWithString:originalPrice];
    
    NSString *title = [NSString stringWithFormat:@"%@  %@度/%@",productDetailModel.brandName,productDetailModel.alcohol,productDetailModel.purity];
    NSInteger changeLength = productDetailModel.alcohol.length +2 +productDetailModel.purity.length;
    self.titleLabel.attributedText = [NSString getAttrStr:title beginL:title.length -changeLength  endL:changeLength  color:COLOR_TEXT_BLACK font:Font(13.f)];
//    self.purityLabel.text = productDetailModel.purity;
    self.contentLabel.text = productDetailModel.subTitle;
}

- (void)setupConstraints {
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(Width_Screen);
    }];
    
    [self.promotionPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView.mas_bottom).offset(5.f);
        make.left.equalTo(self.contentView).offset(16.f);
    }];
    
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.promotionPriceLabel);
        make.left.equalTo(self.promotionPriceLabel.mas_right).offset(15.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.promotionPriceLabel.mas_bottom).offset(5.f);
        make.right.equalTo(self.contentView).offset(-10.f);
        make.left.equalTo(self.promotionPriceLabel);
    }];
    
//    [self.purityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.titleLabel.mas_bottom).offset(5.f);
//        make.right.equalTo(self.contentView).offset(-10.f);
//        make.left.equalTo(self.titleLabel.mas_right).offset(15.f);
//    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.right.equalTo(self.contentView).offset(-10.f);
        make.left.equalTo(self.titleLabel);
    }];
    
}

- (UIImageView *)titleImageView {
    if (! _titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleImageView];
    }
    return _titleImageView;
}

- (UILabel *)promotionPriceLabel {
    if (! _promotionPriceLabel) {
        _promotionPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _promotionPriceLabel.font = Font_16;
        _promotionPriceLabel.textColor = COLOR_THEME_COLOR;
        [self.contentView addSubview:_promotionPriceLabel];
    }
    return _promotionPriceLabel;
}

- (UILabel *)originalPriceLabel {
    if (! _originalPriceLabel) {
        _originalPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _originalPriceLabel.font = Font_12;
        _originalPriceLabel.textColor = COLOR_GRAY_150;
        [self.contentView addSubview:_originalPriceLabel];
    }
    return _originalPriceLabel;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = Font_16;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)purityLabel {
    if (! _purityLabel) {
        _purityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _purityLabel.font = Font_14;
        _purityLabel.textColor = COLOR_GRAY_150;
        [self.contentView addSubview:_purityLabel];
    }
    return _purityLabel;
}

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = Font_14;
        _contentLabel.textColor = COLOR_GRAY_150;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}


@end
