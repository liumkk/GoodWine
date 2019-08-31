//
//  GMMoreEvaluateFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMoreEvaluateFooterView.h"

@interface GMMoreEvaluateFooterView ()

@property (nonatomic, copy) NSString *title;

@end

@implementation GMMoreEvaluateFooterView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.title = title;
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5.f);
        make.left.equalTo(self).offset(25.f);
        make.right.equalTo(self).offset(-25.f);
        make.height.mas_equalTo(25.f);
    }];
}

- (UIButton *)confirmBtn {
    if (! _confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmBtn setTitle:self.title forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = COLOR_GRAY_244;
        [_confirmBtn setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = Font_15;
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

@end
