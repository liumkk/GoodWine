//
//  GMKeyValueInfoCell.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMKeyValueInfoCell.h"

@implementation GMKeyValueInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.width.mas_equalTo(70.f);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).offset(10.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
    }];
    
    [self.textFieldWithBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).offset(10.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

- (void)updateTitleLabelConstraints {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.headerImageView.mas_right).offset(10.f);
    }];
}

- (void)defaultLabelUpdateLabelFrame {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.width.mas_equalTo(160.f);
    }];
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
        }];
    }
}

- (void)updateOnlyTextFieldConstraints {
    self.titleLabel.hidden = YES;
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
    }];
}

- (void)updateCellContentWithCellType:(GMKVInfoCellType)cellType leftText:(NSString *)leftText rightText:(NSString *)rightText needLine:(BOOL)needLine {
    self.topLine.hidden = !needLine;
    self.titleLabel.text = leftText;
    
    if (cellType == GMKVInfoCellTypeDefaultLabel) {
        [self defaultLabelUpdateLabelFrame];
        self.rightLabel.text = rightText;
        [self viewNeedShow:self.rightLabel];
    } else if (cellType == GMKVInfoCellTypeOnlyTextField) {
        [self updateOnlyTextFieldConstraints];
        self.textField.placeholder = rightText;
        [self viewNeedShow:self.textField];
    } else if (cellType == GMKVInfoCellTypeAllTextField) {
        self.textField.placeholder = rightText;
        [self viewNeedShow:self.textField];
    } else if (cellType == GMKVInfoCellTypeNumTextField) {
        self.textField.placeholder = rightText;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self viewNeedShow:self.textField];
    } else if (cellType == GMKVInfoCellTypePasswordTextField) {
        self.textFieldWithBtn.placeholder = rightText;
        [self viewNeedShow:self.textFieldWithBtn];
    } else if (cellType == GMKVInfoCellTypeLeftImageView) {
        self.headerImageView.image = [UIImage imageNamed:rightText];
        [self updateTitleLabelConstraints];
        [self viewNeedShow:self.headerImageView];
    }
}

- (void)viewNeedShow:(UIView *)view {
    self.headerImageView.hidden = YES;
    self.rightLabel.hidden = YES;
    self.textField.hidden = YES;
    self.textFieldWithBtn.hidden = YES;
    view.hidden = NO;
    self.currentControl = view;
}

- (void)passwordShowAction:(UIButton *)btn {
    self.textFieldWithBtn.secureTextEntry = !btn.selected;
}

+ (CGFloat)heightForCell {
    return 50.f;
}

+ (CGFloat)heightForCellWithFloat:(CGFloat)height {
    
    return height;
}

#pragma mark --init subviews

- (UIImageView *)headerImageView {
    if (! _headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = Font_15;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)rightLabel {
    if (! _rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.font = Font_15;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (UITextField *)textField {
    if (! _textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.font = Font(15.f);
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

- (UITextField *)textFieldWithBtn {
    if (! _textFieldWithBtn) {
        _textFieldWithBtn = [[UITextField alloc] initWithFrame:CGRectZero];
        _textFieldWithBtn.secureTextEntry = YES;
        _textFieldWithBtn.rightView = self.passwordShowBtn;
        _textFieldWithBtn.rightViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_textFieldWithBtn];
    }
    return _textFieldWithBtn;
}

- (UIButton *)passwordShowBtn {
    if (! _passwordShowBtn) {
        _passwordShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordShowBtn setImage:[UIImage imageNamed:@"password_hidden"] forState:UIControlStateNormal];
        [_passwordShowBtn setImage:[UIImage imageNamed:@"password_show"] forState:UIControlStateSelected];
        [_passwordShowBtn addTarget:self action:@selector(passwordShowAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordShowBtn;
}

- (UIView *)topLine {
    if (! _topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = COLOR_LINE_COLOR;
        _topLine.hidden = YES;
        [self addSubview:_topLine];
    }
    return _topLine;
}

@end
