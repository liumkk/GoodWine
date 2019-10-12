//
//  GMRegisterFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/10/11.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMRegisterFooterView.h"

@implementation GMRegisterFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20.f);
        make.left.equalTo(self).offset(20.f);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBtn);
        make.left.equalTo(self.selectBtn.mas_right).offset(5.f);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBtn);
        make.left.equalTo(self.textLabel.mas_right);
        make.width.mas_equalTo(140.f);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectBtn.mas_bottom).offset(20.f);
        make.left.equalTo(self).offset(25.f);
        make.right.equalTo(self).offset(-25.f);
        make.height.mas_equalTo(45.f);
    }];
}

- (void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (UIButton *)selectBtn {
    if (! _selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UILabel *)textLabel {
    if (! _textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.text = @"我已阅读并同意";
        _textLabel.font = Font(14.f);
        _textLabel.textColor = COLOR_GRAY_150;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

- (UIButton *)protocolBtn {
    if (! _protocolBtn) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolBtn setTitle:@"《美酒快线服务协议》" forState:UIControlStateNormal];
        [_protocolBtn setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
        _protocolBtn.titleLabel.font = Font(14.f);
        [self addSubview:_protocolBtn];
    }
    return _protocolBtn;
}

- (UIButton *)confirmBtn {
    if (! _confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = Font(15.f);
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

@end
