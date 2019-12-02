//
//  GMDescriptionTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/12/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMDescriptionTableViewCell.h"

@implementation GMDescriptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5.f);
        make.left.equalTo(self.contentView).offset(16.f);
        make.right.equalTo(self.contentView).offset(-16.f);
        make.height.mas_equalTo(14.f);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(24, 16, 5, 16));
    }];
}

- (void)updateCellWithTitle:(NSString *)title {
    self.titleLabel.text = @"商品描述:";
    self.descriptionLabel.attributedText = [NSString setFirstLineHeadIndentWithString:title indent:28];;
}

#pragma mark --init subviews

- (UILabel *)descriptionLabel {
    if (! _descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descriptionLabel.textColor = COLOR_GRAY_150;
        _descriptionLabel.font = Font(14.f);
        _descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        _titleLabel.font = Font(14.f);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
