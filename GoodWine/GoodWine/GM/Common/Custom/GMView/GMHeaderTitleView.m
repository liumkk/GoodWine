//
//  GMHeaderTitleView.m
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMHeaderTitleView.h"

@implementation GMHeaderTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupConstranits];
    }
    return self;
}

- (void)updateTitleText:(NSString *)title titleColor:(UIColor *)color {
    self.titleLabel.text = title;
    self.titleLabel.textColor = color;
}

- (void)setupConstranits {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16.f);
    }];
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = Font_14;
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
