//
//  GMWineListCollectionViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/7/24.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMWineListCollectionViewCell.h"

@implementation GMWineListCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = COLOR_TABLE_BG_RAY;
        [self setupConstraints];
    }
    return self;
}

- (void)updateWineListCollectionCellWithHomePageTypeItem:(HomePageTypeItem *)homePageTypeItem {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:homePageTypeItem.pic]];
    self.titleLabel.text = homePageTypeItem.brandName;
    self.promotionPriceLabel.text = [NSString stringWithFormat:@"%.2f/瓶",[homePageTypeItem.price floatValue] ];
    NSString *originalPrice = [NSString stringWithFormat:@"原价:%.2f元",[homePageTypeItem.originalPrice floatValue]];
    self.originalPriceLabel.attributedText = [NSString setMiddleLinePriceWithString:originalPrice];
    self.saleLabel.text = [NSString stringWithFormat:@"%ld人购买",homePageTypeItem.sale];
}

- (void)setupConstraints {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(2.f);
//        make.left.equalTo(self.contentView).offset(2.f);
//        make.right.equalTo(self.contentView).offset(-2.f);
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(3.f);
        make.left.equalTo(self.contentView).offset(2.f);
        make.right.equalTo(self.contentView).offset(-2.f);
        make.height.mas_equalTo(167 *ScreenScale);
    }];
    self.imageView.bounds = CGRectMake(0, 0, self.contentView.width-4.f, 167 *ScreenScale);
    [UIView maskCorner:self.imageView rectCorner:UIRectCornerAllCorners corner:5.f];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(5.f);
        make.right.equalTo(self.contentView).offset(-10.f);
        make.left.equalTo(self.imageView).offset(2.f);
    }];
    
    [self.promotionPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.promotionPriceLabel.mas_bottom).offset(8.f);
        make.left.equalTo(self.promotionPriceLabel);
    }];
    
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originalPriceLabel);
        make.right.equalTo(self.imageView.mas_right).offset(-2.f);
    }];
    
}

- (UIImageView *)bgView {
    if (! _bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collection_bg"]];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)imageView {
    if (! _imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = Font_16;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)promotionPriceLabel {
    if (! _promotionPriceLabel) {
        _promotionPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _promotionPriceLabel.font = Font_15;
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
