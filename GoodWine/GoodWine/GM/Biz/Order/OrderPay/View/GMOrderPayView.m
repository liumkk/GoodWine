//
//  GMOrderPayView.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderPayView.h"

@implementation GMOrderPayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = COLOR_TABLE_BG_RAY;
        [self setupConstraints];
    }
    return self;
}

- (void)updateWithPayAmount:(NSString *)amount {
    self.priceLabel.text = [amount formatterYuan];
    [self.payBtn setTitle:[NSString stringWithFormat:@"支付%.2f元",[amount floatValue]] forState:UIControlStateNormal];
}

- (void)setupConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30.f);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.platformImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(40.f);
        make.left.equalTo(self).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.platformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.platformImageView.mas_centerY);
        make.left.equalTo(self.platformImageView.mas_right).offset(10.f);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.platformImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-16.f);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30.f - BottomTarBarSpace);
        make.left.equalTo(self).offset(16.f);
        make.right.equalTo(self).offset(-16.f);
        make.height.mas_equalTo(45.f);
    }];
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"请尽快支付订单,以免耽误配送!";
        _titleLabel.font = Font_16;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (! _priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.font = Font_60;
        [self addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.text = @"美酒快线(蜀山店)";
        _contentLabel.font = Font_16;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)platformImageView {
    if (! _platformImageView) {
        _platformImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zfb_icon"]];
        [self addSubview:_platformImageView];
    }
    return _platformImageView;
}

- (UILabel *)platformLabel {
    if (! _platformLabel) {
        _platformLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _platformLabel.text = @"支付宝支付";
        _platformLabel.font = Font_16;
        [self addSubview:_platformLabel];
    }
    return _platformLabel;
}

- (UIButton *)selectedBtn {
    if (! _selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setBackgroundImage:[UIImage imageNamed:@"shopp_select"] forState:UIControlStateNormal];
        [self addSubview:_selectedBtn];
    }
    return _selectedBtn;
}

- (UIButton *)payBtn {
    if (! _payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [self addSubview:_payBtn];
    }
    return _payBtn;
}

@end
