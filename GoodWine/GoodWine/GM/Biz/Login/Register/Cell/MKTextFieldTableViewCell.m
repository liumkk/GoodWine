//
//  MKTextFeildTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MKTextFieldTableViewCell.h"

@implementation MKTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.right.equalTo(self.contentView).offset(-16.f);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

- (void)updateTextFieldCellType:(MKTextFieldCellType)type placeholder:(nonnull NSString *)placeholder {
    self.textField.placeholder = placeholder;
    
    if (type == MKTextFieldCellTypeVerficationCode) {
        self.textField.rightView = self.verificationView;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else if (type == MKTextFieldCellTypeEye) {
        self.textField.rightView = self.eyeBtn;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.secureTextEntry = YES;
    } else {
        self.textField.rightView = nil;
    }
}

- (void)changeHidden:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.textField.secureTextEntry = !btn.selected;
}

#pragma mark --init subviews

- (UITextField *)textField {
    if (! _textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

- (MKVerificationCodeView *)verificationView {
    if (! _verificationView) {
        _verificationView = [[MKVerificationCodeView alloc] initWithFrame:CGRectZero];
    }
    return _verificationView;
}

- (UIButton *)eyeBtn {
    if (! _eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eyeBtn.bounds = CGRectMake(0, 0, 30.f, 30.f);
        [_eyeBtn setImage:[UIImage imageNamed:@"password_hidden"] forState:UIControlStateNormal];
        [_eyeBtn setImage:[UIImage imageNamed:@"password_show"] forState:UIControlStateSelected];
        [_eyeBtn addTarget:self action:@selector(changeHidden:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeBtn;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [UIView creatDefaultLineView];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
