//
//  GMVersionHeaderView.m
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMVersionHeaderView.h"

@implementation GMVersionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30.f);
        make.size.mas_equalTo(CGSizeMake(90.f, 90.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(10.f);
    }];
}

- (UIImageView *)headerImageView {
    if (! _headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"美酒快线";
        _titleLabel.font = Font_18;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = COLOR_THEME_COLOR;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
