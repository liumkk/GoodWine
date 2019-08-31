//
//  GMOrderDetailFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderDetailFooterView.h"

@implementation GMOrderDetailFooterView

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
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(90.f, 30.f));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.phoneBtn.mas_left).offset(-15.f);
        make.size.mas_equalTo(CGSizeMake(90.f, 30.f));
    }];
}

- (void)updateFooterViewWithOrderDetailModel:(GMOrderDetailInfoModel *)model {
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

- (UIButton *)phoneBtn {
    if (! _phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"联系商家" forState:UIControlStateNormal];
        [_phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_phoneBtn setBackgroundColor:COLOR_THEME_COLOR];
        _phoneBtn.titleLabel.font = Font_15;
        _phoneBtn.layer.cornerRadius = 10.f;
        _phoneBtn.layer.masksToBounds = YES;
        [self addSubview:_phoneBtn];
    }
    return _phoneBtn;
}

- (UIButton *)cancleBtn {
    if (! _cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleBtn setBackgroundColor:COLOR_THEME_COLOR];
        _cancleBtn.titleLabel.font = Font_15;
        _cancleBtn.layer.cornerRadius = 10.f;
        _cancleBtn.layer.masksToBounds = YES;
        [self addSubview:_cancleBtn];
    }
    return _cancleBtn;
}

@end
