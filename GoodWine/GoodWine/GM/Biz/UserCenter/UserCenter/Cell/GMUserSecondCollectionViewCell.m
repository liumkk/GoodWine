//
//  GMUserSecondCollectionViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserSecondCollectionViewCell.h"

@implementation GMUserSecondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConstraints];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)updateCellWithImageString:(NSString *)imageString titleText:(NSString *)text {
    self.headerImageView.image = [UIImage imageNamed:imageString];
    self.titleLabel.text = text;
}

- (void)setupConstraints {
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_centerY).offset(5.f);
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = Font_14;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
