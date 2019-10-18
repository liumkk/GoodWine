//
//  GMOrderEvaluateView.m
//  GoodWine
//
//  Created by LMK on 2019/9/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderEvaluateView.h"

@interface GMOrderEvaluateView () <UITextViewDelegate>

@end

@implementation GMOrderEvaluateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self setupConstraints];
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placedLabel.hidden = YES;
    } else {
        self.placedLabel.hidden = NO;
    }
}

- (void)updateEvaluateViewWithModel:(GMOrderItem *)model {
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.productPic]];
    self.titleLabel.text = model.productName;
}

- (void)setupConstraints {
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10.f);
        make.left.equalTo(self).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(80.f, 80.f));
    }];
    
    self.productImageView.bounds = CGRectMake(0, 0, 80.f, 80.f);
    [UIView maskCorner:self.productImageView rectCorner:UIRectCornerAllCorners corner:5.f];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.productImageView.mas_centerY).offset(-5.f);
        make.left.equalTo(self.productImageView.mas_right).offset(10.f);
        make.height.mas_equalTo(20.f);
    }];
    
    for (int i = 0; i < 5; i ++) {
        UIButton *productStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productStarBtn setBackgroundImage:[UIImage imageNamed:@"star_select"] forState:UIControlStateNormal];
        productStarBtn.tag = i;
        [self addSubview:productStarBtn];
        [productStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.productImageView.mas_centerY).offset(5.f);
            make.left.mas_equalTo(106 +23 *i);
            make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
        }];
        [self.productStarArray addObject:productStarBtn];
    }
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productImageView.mas_bottom).offset(20.f);
        make.left.equalTo(self.productImageView);
        make.right.equalTo(self.mas_right).offset(-16.f);
        make.height.mas_equalTo(150.f);
    }];
    
    [self.placedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView).offset(5.f);
        make.right.equalTo(self.textView);
        make.top.equalTo(self.textView).offset(10.f);
        make.height.mas_equalTo(15.f);
    }];
    
    [self.storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(20.f);
        make.left.equalTo(self.productImageView);
        make.size.mas_equalTo(CGSizeMake(90.f, 20.f));
    }];
    
    for (int i = 0; i < 5; i ++) {
        UIButton *storeStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [storeStarBtn setBackgroundImage:[UIImage imageNamed:@"star_select"] forState:UIControlStateNormal];
        storeStarBtn.tag = i;
        [self addSubview:storeStarBtn];
        [storeStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.storeLabel.mas_centerY);
            make.left.mas_equalTo(111 +23 *i);
            make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
        }];
        [self.storeStarArray addObject:storeStarBtn];
    }
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeLabel.mas_bottom).offset(5.f);
        make.left.equalTo(self.productImageView);
        make.size.mas_equalTo(CGSizeMake(90.f, 20.f));
    }];
    
    for (int i = 0; i < 5; i ++) {
        UIButton *serviceStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [serviceStarBtn setBackgroundImage:[UIImage imageNamed:@"star_select"] forState:UIControlStateNormal];
        serviceStarBtn.tag = i;
        [self addSubview:serviceStarBtn];
        [serviceStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.serviceLabel.mas_centerY);
            make.left.mas_equalTo(111 +23 *i);
            make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
        }];
        [self.serviceStarArray addObject:serviceStarBtn];
    }
    
    [self.anonymousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceLabel.mas_bottom).offset(20.f);
        make.left.equalTo(self.serviceLabel);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.anonymousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.anonymousBtn.mas_centerY);
        make.left.equalTo(self.anonymousBtn.mas_right).offset(5.f);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.anonymousLabel.mas_bottom).offset(40.f);
        make.left.equalTo(self).offset(25.f);
        make.right.equalTo(self).offset(-25.f);
        make.height.mas_equalTo(45.f);
    }];
}

- (UIImageView *)productImageView {
    if (! _productImageView) {
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_productImageView];
    }
    return _productImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"茅台";
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        _titleLabel.font = Font(15.f);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextView *)textView {
    if (! _textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.font = Font(15.f);
        _textView.layer.borderColor = COLOR_GRAY_200.CGColor;
        _textView.layer.borderWidth =1.0;
        _textView.layer.cornerRadius =5.0;
        _textView.delegate = self;
        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placedLabel {
    if (! _placedLabel) {
        _placedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placedLabel.text = @"请输入评价内容...";
        _placedLabel.textColor = COLOR_TEXT_FIELD_PLACEHOLDER_COLOR;
        _placedLabel.font = Font(15.f);
        [self addSubview:_placedLabel];
    }
    return _placedLabel;
}

- (UILabel *)storeLabel {
    if (! _storeLabel) {
        _storeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _storeLabel.text = @"商家服务评分";
        _storeLabel.textColor = COLOR_THEME_COLOR;
        _storeLabel.font = Font(15.f);
        [self addSubview:_storeLabel];
    }
    return _storeLabel;
}

- (UILabel *)serviceLabel {
    if (! _serviceLabel) {
        _serviceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _serviceLabel.text = @"配送服务评分";
        _serviceLabel.textColor = COLOR_THEME_COLOR;
        _serviceLabel.font = Font(15.f);
        [self addSubview:_serviceLabel];
    }
    return _serviceLabel;
}

- (UIButton *)anonymousBtn {
    if (! _anonymousBtn) {
        _anonymousBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_anonymousBtn setBackgroundImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_anonymousBtn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [self addSubview:_anonymousBtn];
    }
    return _anonymousBtn;
}

- (UILabel *)anonymousLabel {
    if (! _anonymousLabel) {
        _anonymousLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _anonymousLabel.text = @"匿名评价";
        _anonymousLabel.textColor = [UIColor blackColor];
        _anonymousLabel.font = Font(15.f);
        [self addSubview:_anonymousLabel];
    }
    return _anonymousLabel;
}

- (UIButton *)confirmBtn {
    if (! _confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = Font(17.f);
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

- (NSMutableArray *)productStarArray {
    if (! _productStarArray) {
        _productStarArray = [[NSMutableArray alloc] init];
    }
    return _productStarArray;
}

- (NSMutableArray *)storeStarArray {
    if (! _storeStarArray) {
        _storeStarArray = [[NSMutableArray alloc] init];
    }
    return _storeStarArray;
}

- (NSMutableArray *)serviceStarArray {
    if (! _serviceStarArray) {
        _serviceStarArray = [[NSMutableArray alloc] init];
    }
    return _serviceStarArray;
}

@end
