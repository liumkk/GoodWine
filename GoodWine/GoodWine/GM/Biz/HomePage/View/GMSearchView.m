//
//  GMSearchView.m
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSearchView.h"

@implementation GMSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConstraint];
    }
    return self;
}

- (void)setupConstraint {
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5.f);
        make.left.equalTo(self).offset(10.f);
        make.right.equalTo(self).offset(-10.f);
        make.height.mas_equalTo(self.height);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView).offset(3.f);
        make.left.equalTo(self).offset(20.f);
        make.right.equalTo(self).offset(-20.f);
        make.height.mas_equalTo(self.bgImageView.height);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self.bgImageView);
        make.height.mas_equalTo(57.f);
    }];
}

- (UIImageView *)bgImageView {
    if (! _bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_bg_y"]];
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UITextField *)searchTextField {
    if (! _searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _searchTextField.placeholder = @"搜一搜想要的商品";
        _searchTextField.leftView = self.paddingView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        [_searchTextField setValue:COLOR_GRAY_150 forKeyPath:@"_placeholderLabel.textColor"];
        [_searchTextField setValue:Font(14.f) forKeyPath:@"_placeholderLabel.font"];
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.font =Font(14.f);
        _searchTextField.userInteractionEnabled = NO;
        [self addSubview:_searchTextField];
    }
    return _searchTextField;
}

- (UIView *)paddingView {
    if (! _paddingView) {
        _paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.f, 14.f)];
        [_paddingView addSubview:self.searchImageView];
    }
    return _paddingView;
}
- (UIImageView *)searchImageView {
    if (! _searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14.f, 14.f)];
        _searchImageView.image = [UIImage imageNamed:@"sousuo"];
    }
    return _searchImageView;
}

- (UIButton *)searchButton {
    if (! _searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_searchButton];
    }
    return _searchButton;
}

@end
