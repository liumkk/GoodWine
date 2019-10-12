//
//  GMShoppCarFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/8/12.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMShoppCarFooterView.h"

@interface GMShoppCarFooterView ()


@end

@implementation GMShoppCarFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.allSelectBtn.mas_right).offset(10.f);
    }];
    
    [self.checkoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(70.f, 30.f));
    }];
}

- (UIButton *)allSelectBtn {
    if (! _allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [self addSubview:_allSelectBtn];
    }
    return _allSelectBtn;
}

- (UILabel *)allSelectLabel {
    if (! _allSelectLabel) {
        _allSelectLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _allSelectLabel.text = @"全选";
        _allSelectLabel.textColor = COLOR_THEME_COLOR;
        [self addSubview:_allSelectLabel];
    }
    return _allSelectLabel;
}

- (UIButton *)checkoutBtn {
    if (! _checkoutBtn) {
        _checkoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkoutBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_checkoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkoutBtn setBackgroundColor:COLOR_THEME_COLOR];
        _checkoutBtn.titleLabel.font = Font_15;
        _checkoutBtn.layer.cornerRadius = 10.f;
        _checkoutBtn.layer.masksToBounds = YES;
        [self addSubview:_checkoutBtn];
    }
    return _checkoutBtn;
}

@end
