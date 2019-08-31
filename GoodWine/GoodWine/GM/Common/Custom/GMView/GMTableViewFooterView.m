//
//  GMTableViewFooterView.m
//  GoodWine
//
//  Created by LMK on 2019/8/6.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMTableViewFooterView.h"

@interface GMTableViewFooterView ()

@property (nonatomic, copy) NSString *title;

@end

@implementation GMTableViewFooterView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30.f);
        make.left.equalTo(self).offset(25.f);
        make.right.equalTo(self).offset(-25.f);
        make.height.mas_equalTo(45.f);
    }];
}

- (UIButton *)confirmBtn {
    if (! _confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmBtn setTitle:self.title forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = Font_15;
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

@end
