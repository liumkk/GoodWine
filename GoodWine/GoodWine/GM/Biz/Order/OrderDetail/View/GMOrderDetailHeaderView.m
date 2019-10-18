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
        make.bottom.equalTo(self.lineView.mas_top).offset(-5.f);
        make.right.equalTo(self.lineView.mas_left).offset(-3.f);
        make.size.mas_equalTo(CGSizeMake(28.f, 28.f));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.left.equalTo(self.lineView.mas_right);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.lineView.mas_bottom).offset(15.f);
        make.size.mas_equalTo(CGSizeMake(100.f, 30.f));
    }];
}

- (void)updateOrderDetailHeaderViewWithModel:(GMOrderDetailInfoModel *)model {
    if ([model.status integerValue] == 0) {
        [self updateOrderDetailHeaderViewWithStatus:@"待付款" content:@"等待用户付款..." btnTitle:@"去付款"];
    } else if ([model.status integerValue] == 1) {
        [self updateOrderDetailHeaderViewWithStatus:@"待发货" content:@"商家正在备货,请稍候..." btnTitle:@"继续购买"];
    } else if ([model.status integerValue] == 2) {
        [self updateOrderDetailHeaderViewWithStatus:@"待送达" content:@"配送中,请耐心等待..." btnTitle:@"确认收货"];
    } else if ([model.status integerValue] == 3) {
        if ([model.commentType integerValue] != 2) {
            [self updateOrderDetailHeaderViewWithStatus:@"已完成" content:@"订单已完成!" btnTitle:@"去评价"];
        } else {
            [self updateOrderDetailHeaderViewWithStatus:@"已完成" content:@"订单已完成!" btnTitle:@"继续购买"];
        }
    } else if ([model.status integerValue] == 4) {
        [self updateOrderDetailHeaderViewWithStatus:@"已关闭" content:@"订单已关闭!" btnTitle:@"继续购买"];
    }
}

- (void)updateOrderDetailHeaderViewWithStatus:(NSString *)status content:(NSString *)content btnTitle:(NSString *)btnTitle {
    self.statusLabel.text = status;
    self.contentLabel.text = content;
    [self.payBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.image = [[UIImage imageNamed:@"info"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_iconImageView setTintColor:[UIColor whiteColor]];
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
        UIImage *image = [[UIImage imageNamed:@"gray_bg_yuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_payBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_payBtn setTintColor:[UIColor whiteColor]];
        _payBtn.titleLabel.font = Font_15;
        [self addSubview:_payBtn];
    }
    return _payBtn;
}

@end
