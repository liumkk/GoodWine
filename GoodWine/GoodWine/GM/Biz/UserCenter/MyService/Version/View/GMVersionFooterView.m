//
//  GMVersionFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/10/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMVersionFooterView.h"

@implementation GMVersionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = Font_13;
        _titleLabel.numberOfLines = 2;
        NSString *title = @"Copyright@2019 安徽五方原电子商务有限公司\n版权所有";
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0; // 设置行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
        _titleLabel.attributedText = attributedStr;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
