//
//  GMUserCenterFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserCenterFooterView.h"

@implementation GMUserCenterFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConstraints];
        self.backgroundColor = COLOR_GRAY_244;
    }
    return self;
}

- (void)setupConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10.f);
        make.left.right.bottom.equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"   我的服务";
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
