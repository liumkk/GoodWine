//
//  GMLoginView.m
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMLoginView.h"

@implementation GMLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30.f);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(140.f, 140.f));
    }];
    
    [self.identifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20.f);
        make.left.right.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.identifyLabel.mas_bottom).offset(40.f);
        make.left.equalTo(self.mas_left).offset(40.f);
        make.width.mas_equalTo(50.f);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.mas_right).offset(-40.f);
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20.f);
        make.left.equalTo(self.nameLabel);
        make.width.mas_equalTo(50.f);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordLabel);
        make.left.equalTo(self.nameTextField);
        make.right.equalTo(self.nameTextField);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(40.f);
        make.left.equalTo(self).offset(20.f);
        make.right.equalTo(self).offset(-20.f);
        make.height.mas_equalTo(45.f);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).offset(20.f);
        make.left.equalTo(self).offset(20.f);
    }];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetButton);
        make.right.equalTo(self).offset(-20.f);
    }];
}

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goodWine"]];
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)identifyLabel {
    if (! _identifyLabel) {
        _identifyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _identifyLabel.textAlignment = NSTextAlignmentCenter;
        _identifyLabel.text = @"美酒快线";
        _identifyLabel.textColor = [UIColor blackColor];
        [self addSubview:_identifyLabel];
    }
    return _identifyLabel;
}

- (UILabel *)nameLabel {
    if (! _nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"账号:";
        _nameLabel.font = Font_18;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UITextField *)nameTextField {
    if (! _nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _nameTextField.placeholder = @"输入用户名";
        _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _nameTextField.font = Font_16;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_nameTextField];
    }
    return _nameTextField;
}

- (UILabel *)passwordLabel {
    if (! _passwordLabel) {
        _passwordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _passwordLabel.text = @"密码:";
        _passwordLabel.font = Font_18;
        [self addSubview:_passwordLabel];
    }
    return _passwordLabel;
}

- (UITextField *)passwordTextField {
    if (! _passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _passwordTextField.placeholder = @"输入密码";
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.font = Font_16;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.secureTextEntry = YES;
        [self addSubview:_passwordTextField];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (! _loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [self addSubview:_loginButton];
    }
    return _loginButton;
}

- (UIButton *)forgetButton {
    if (! _forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = Font_16;
        [self addSubview:_forgetButton];
    }
    return _forgetButton;
}

- (UIButton *)signUpButton {
    if (! _signUpButton) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signUpButton setTitle:@"注册" forState:UIControlStateNormal];
        _signUpButton.titleLabel.font = Font_16;
        [_signUpButton setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
        [self addSubview:_signUpButton];
    }
    return _signUpButton;
}

@end
