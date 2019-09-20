//
//  GMProductDetailFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductDetailFooterView.h"

#define button_width        19.f
#define button_top_margin   5.f

@implementation GMProductDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(10.f);
        make.width.mas_equalTo(45.f);
    }];
    
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.collectBtn.mas_right);
        make.width.mas_equalTo(45.f);
    }];
    
    [self.shoppCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottomMargin.equalTo(self);
        make.left.equalTo(self.serviceBtn.mas_right);
        make.width.mas_equalTo(45.f);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(90.f, 35.f));
    }];
    
    [self.joinShoppCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.buyButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(90.f, 35.f));
    }];
    
    self.joinShoppCarBtn.bounds = CGRectMake(0, 0, 90.f, 35.f);
    self.buyButton.bounds = CGRectMake(0, 0, 90.f, 35.f);
    [UIView maskCorner:self.joinShoppCarBtn rectCorner:UIRectCornerBottomLeft | UIRectCornerTopLeft corner:16.f];
    [UIView maskCorner:self.buyButton rectCorner:UIRectCornerBottomRight | UIRectCornerTopRight corner:16.f];
}

- (void)collectBtnSelected:(BOOL)selected {
//    [UIView maskCorner:self.joinShoppCarBtn rectCorner:UIRectCornerBottomLeft | UIRectCornerTopLeft corner:16.f];
//    [UIView maskCorner:self.buyButton rectCorner:UIRectCornerBottomRight | UIRectCornerTopRight corner:16.f];
    self.collectBtn.selected = selected;
    if (selected) {
        [self.collectBtn updateImageName:@"red_collected" contentText:@"已关注" Width:button_width topMargin:button_top_margin bottomMargin:3.f];
    } else {
        [self.collectBtn updateImageName:@"collect" contentText:@"关注" Width:button_width topMargin:button_top_margin bottomMargin:3.f];
    }
}

- (GMITButton *)collectBtn {
    if (! _collectBtn) {
        _collectBtn = [GMITButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn updateImageName:@"collect" contentText:@"关注" Width:button_width topMargin:button_top_margin bottomMargin:3.f];
        [self addSubview:_collectBtn];
    }
    return _collectBtn;
}

- (GMITButton *)serviceBtn {
    if (! _serviceBtn) {
        _serviceBtn = [GMITButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn updateImageName:@"kefu" contentText:@"客服" Width:button_width topMargin:button_top_margin bottomMargin:3.f];
        [self addSubview:_serviceBtn];
    }
    return _serviceBtn;
}

- (GMITButton *)shoppCarBtn {
    if (! _shoppCarBtn) {
        _shoppCarBtn = [GMITButton buttonWithType:UIButtonTypeCustom];
        [_shoppCarBtn updateImageName:@"shoppCar" contentText:@"购物车" Width:button_width topMargin:button_top_margin bottomMargin:3.f];
        [self addSubview:_shoppCarBtn];
    }
    return _shoppCarBtn;
}

- (UIButton *)joinShoppCarBtn {
    if (! _joinShoppCarBtn) {
        _joinShoppCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinShoppCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_joinShoppCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_joinShoppCarBtn setBackgroundColor:COLOR_YELLOW_COLOR];
        _joinShoppCarBtn.titleLabel.font = Font_15;
        [self addSubview:_joinShoppCarBtn];
    }
    return _joinShoppCarBtn;
}

- (UIButton *)buyButton {
    if (! _buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:COLOR_THEME_COLOR];
        _buyButton.titleLabel.font = Font_15;
        [self addSubview:_buyButton];
    }
    return _buyButton;
}

@end
