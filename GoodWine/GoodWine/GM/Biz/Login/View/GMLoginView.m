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
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel).offset(60.f);
        make.right.equalTo(self.mas_right).offset(-40.f);
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20.f);
        make.left.equalTo(self.nameLabel);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordLabel);
        make.left.equalTo(self.nameTextField);
        make.right.equalTo(self.nameTextField);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(20.f);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60.f, 30.f));
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).offset(20.f);
        make.left.equalTo(self.loginButton).offset(-20.f);
    }];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetButton);
        make.left.equalTo(self.forgetButton.mas_right).offset(10.f);
    }];
}

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
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
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UITextField *)nameTextField {
    if (! _nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _nameTextField.placeholder = @"输入用户名";
        _nameTextField.borderStyle = UITextBorderStyleLine;
        _nameTextField.font = [UIFont systemFontOfSize:16.f];
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
        [self addSubview:_passwordLabel];
    }
    return _passwordLabel;
}

- (UITextField *)passwordTextField {
    if (! _passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _passwordTextField.placeholder = @"输入密码";
        _passwordTextField.borderStyle = UITextBorderStyleLine;
        _passwordTextField.font = [UIFont systemFontOfSize:16.f];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_passwordTextField];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (! _loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_loginButton];
    }
    return _loginButton;
}

- (UIButton *)forgetButton {
    if (! _forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_forgetButton];
    }
    return _forgetButton;
}

- (UIButton *)signUpButton {
    if (! _signUpButton) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signUpButton setTitle:@"注册" forState:UIControlStateNormal];
        [_signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_signUpButton];
    }
    return _signUpButton;
}

@end
