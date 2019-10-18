//
//  GMOrderListTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderListTableViewCell.h"

@implementation GMOrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_TABLE_BG_RAY;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.bgImageView).offset(13.f);
        make.size.mas_equalTo(CGSizeMake(90.f, 57.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.productImageView.mas_centerY);
        make.right.equalTo(self.bgImageView.mas_right).offset(-10.f);
        make.height.mas_equalTo(16.f);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.f);
        make.left.equalTo(self.titleLabel);
        make.height.mas_equalTo(13.f);
    }];
}

- (void)updateCell {
    
}

#pragma mark --init subviews


- (UIImageView *)bgImageView {
    if (! _bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_gray"]];
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UIImageView *)productImageView {
    if (! _productImageView) {
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_productImageView];
    }
    return _productImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = Font_16;
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

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.text = @"1";
        _numLabel.textColor = COLOR_GRAY_200;
        _numLabel.font = Font(12.f);
        [self.contentView addSubview:_numLabel];
    }
    return _numLabel;
}
@end
