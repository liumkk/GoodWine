//
//  GMOrderDetailHeaderView.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderDetailHeaderView.h"

@implementation GMOrderDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = COLOR_THEME_COLOR;
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-20.f);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1.f, 20.f));
    }];
    
    [self.platformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lineView);
        make.right.equalTo(self.lineView.mas_left).offset(-15.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lineView);
        make.left.equalTo(self.lineView.mas_right).offset(15.f);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top).offset(-10.f);
        make.right.equalTo(self.lineView.mas_left).offset(-3.f);
        make.size.mas_equalTo(CGSizeMake(25.f, 25.f));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView.mas_bottom);
        make.left.equalTo(self.lineView.mas_right);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.lineView.mas_bottom).offset(15.f);
        make.size.mas_equalTo(CGSizeMake(100.f, 30.f));
    }];
}

- (void)updateOrderDetailHeaderViewWithStatus:(NSString *)status content:(NSString *)content {
    self.statusLabel.text = status;
    self.contentLabel.text = content;
}

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address"]];
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)statusLabel {
    if (! _statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.text = @"待付款";
        _statusLabel.font = Font_17;
        _statusLabel.textColor = [UIColor whiteColor];
        [self addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UILabel *)platformLabel {
    if (! _platformLabel) {
        _platformLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _platformLabel.text = @"美酒快线";
        _platformLabel.font = Font_15;
        _platformLabel.textAlignment = NSTextAlignmentRight;
        _platformLabel.textColor = [UIColor whiteColor];
        [self addSubview:_platformLabel];
    }
    return _platformLabel;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}


- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.text = @"等待用户付款...";
        _contentLabel.font = Font_15;
        _contentLabel.textColor = [UIColor whiteColor];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIButton *)payBtn {
    if(! _payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_white"] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = Font_15;
        [self addSubview:_payBtn];
    }
    return _payBtn;
}

@end
