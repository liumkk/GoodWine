//
//  GMOrderConfirmFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderConfirmFooterView.h"

@implementation GMOrderConfirmFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.totalLabeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(16.f);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(90.f, 30.f));
    }];
}

- (void)updateFooterViewWithModel:(CalcAmountInfoModel *)model {
    self.totalLabeL.text = [model.payAmount formatterYuan];
}

- (UILabel *)totalLabeL {
    if (! _totalLabeL) {
        _totalLabeL = [[UILabel alloc] initWithFrame:CGRectZero];
//        _totalLabeL.text = @"￥100";   --test
        _totalLabeL.textColor = COLOR_THEME_COLOR;
        [self addSubview:_totalLabeL];
    }
    return _totalLabeL;
}

- (UIButton *)confirmButton {
    if (! _confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:COLOR_THEME_COLOR];
        _confirmButton.titleLabel.font = Font_15;
        _confirmButton.layer.cornerRadius = 10.f;
        _confirmButton.layer.masksToBounds = YES;
        [self addSubview:_confirmButton];
    }
    return _confirmButton;
}

@end
