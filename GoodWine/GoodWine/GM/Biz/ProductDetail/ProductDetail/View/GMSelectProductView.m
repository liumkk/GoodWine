//
//  GMSelectProductView.m
//  GoodWine
//
//  Created by LMK on 2019/8/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSelectProductView.h"

#define itemBtnHeight           30.f

@interface GMSelectProductView ()

@property (nonatomic, strong) GMProductDetailModel *model;
@property (nonatomic, strong) UIButton *didSelectBtn;

@end

@implementation GMSelectProductView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
//        self.backgroundColor = COLOR_MASK_BG_COLOR;
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.titleImageView.mas_top).offset(-10.f);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10.f - BottomTarBarSpace);
        make.left.equalTo(self).offset(16.f);
        make.right.equalTo(self).offset(-16.f);
        make.height.mas_equalTo(45.f);
    }];
    
    [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.confirmBtn.mas_top).offset(-30.f);
        make.left.equalTo(self.titleImageView);
    }];
    
    [self.jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.buyNumLabel);
        make.right.equalTo(self.mas_right).offset(-16.f);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jiaBtn);
        make.right.equalTo(self.jiaBtn.mas_left).offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jiaBtn);
        make.right.equalTo(self.numLabel.mas_left).offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buyNumLabel.mas_top).offset(-25.f);
        make.left.right.equalTo(self).offset(16.f);
        make.height.mas_equalTo(40.f);
    }];
    
    [self.standardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.selectView.mas_top).offset(-15.f);
        make.left.equalTo(self.titleImageView);
    }];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.standardLabel.mas_top).offset(-10.f);
        make.left.equalTo(self).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(100.f, 100.f));
    }];
    
    self.titleImageView.bounds = CGRectMake(0, 0, 100.f, 100.f);
    [UIView maskCorner:self.titleImageView rectCorner:UIRectCornerAllCorners corner:5.f];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView.mas_top);
        make.left.equalTo(self.titleImageView.mas_right).offset(10.f);
    }];
    
    [self.productNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(15.f);
        make.left.equalTo(self.priceLabel);
    }];
    
}

- (void)updateSelectProductViewWithModel:(GMProductDetailModel *)model {
    self.model = model;
    GMProductSkuItem *defaultItem = model.skuArray[0];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:defaultItem.pic]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[defaultItem.price floatValue]];
    self.productNumLabel.text = [NSString stringWithFormat:@"商品编号:%@",defaultItem.skuCode];
    UIButton *lastBtn;
    
    for (int i = 0; i <model.skuArray.count; i ++) {
        GMProductSkuItem *item = model.skuArray[i];
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.tag = 100 + i;
        itemBtn.titleLabel.font = Font_15;
        [itemBtn setTitle:item.sp1 forState:UIControlStateNormal];
        [itemBtn setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        [itemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [itemBtn setBackgroundImage:[UIImage imageNamed:@"gray_bg_yuan"] forState:UIControlStateNormal];
//        [itemBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_red"] forState:UIControlStateSelected];
        UIImage *image = [[UIImage imageNamed:@"gray_bg_yuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [itemBtn setBackgroundImage:image forState:UIControlStateSelected];
        [itemBtn setTintColor:COLOR_THEME_COLOR];
        [itemBtn addTarget:self action:@selector(itemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectView addSubview:itemBtn];
        
        CGFloat width = [item.sp1 widthStringWithFont:Font_15 height:itemBtnHeight] + 20.f;
        if (width < itemBtnHeight +20.f) {
            width = itemBtnHeight +20.f;
        }
        CGFloat height = CGRectGetMinY(lastBtn.frame);
        if (i >0) {
            if (CGRectGetMaxX(lastBtn.frame) + width + 16.f > Width_Screen) {
                height = CGRectGetMaxY(lastBtn.frame) + 15.f;
                itemBtn.frame = CGRectMake(16.f, height, width, itemBtnHeight);
            } else {
                itemBtn.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame) + 26.f, height, width, itemBtnHeight);
            }
        } else {
            itemBtn.frame = CGRectMake(16, 0, width, itemBtnHeight);
            itemBtn.selected = YES;
            self.didSelectBtn = itemBtn;
        }
        lastBtn = itemBtn;
    }
    
    [self.selectView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buyNumLabel.mas_top).offset(-10.f);
        make.left.equalTo(self).offset(16.f);
        make.right.equalTo(self).offset(-16.f);
        make.height.mas_equalTo(CGRectGetMaxY(lastBtn.frame));
    }];
    
//    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.titleImageView.mas_top).offset(-10.f);
//        make.bottom.equalTo(self);
//    }];
}

- (void)itemBtnAction:(UIButton *)btn {
    
    if (self.didSelectBtn != btn) {
        self.didSelectBtn.selected = NO;
        btn.selected = !btn.selected;
        self.didSelectBtn = btn;
        GMProductSkuItem *item = self.model.skuArray[btn.tag - 100];
        [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:item.pic]];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[item.price floatValue]];
        self.productNumLabel.text = [NSString stringWithFormat:@"商品编号:%@",item.skuCode];
    }
}

- (void)confirmBtnAction:(UIButton *)btn {
    if (self.selectProductDelegate && [self.selectProductDelegate respondsToSelector:@selector(selectProductWithItem:buyNum:)]) {
        [self.selectProductDelegate selectProductWithItem:self.model.skuArray[self.didSelectBtn.tag - 100] buyNum:self.numLabel.text];
    }
}

- (UIView *)bgView {
    if (! _bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)titleImageView {
    if (! _titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleImageView];
    }
    return _titleImageView;
}

- (UILabel *)priceLabel {
    if (! _priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.font = Font_24;
        _priceLabel.textColor = COLOR_THEME_COLOR;
        [self addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)productNumLabel {
    if (! _productNumLabel) {
        _productNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _productNumLabel.font = Font_17;
        _productNumLabel.textColor = COLOR_GRAY_150;
        [self addSubview:_productNumLabel];
    }
    return _productNumLabel;
}

- (UILabel *)standardLabel {
    if (! _standardLabel) {
        _standardLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _standardLabel.text = @"选择商品规格";
        _standardLabel.font = Font_17;
        _standardLabel.textColor = COLOR_TEXT_BLACK;
        [self addSubview:_standardLabel];
    }
    return _standardLabel;
}

- (UIView *)selectView {
    if (! _selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectZero];
        _selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_selectView];
    }
    return _selectView;
}

- (UILabel *)buyNumLabel {
    if (! _buyNumLabel) {
        _buyNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _buyNumLabel.text = @"购买数量";
        _buyNumLabel.font = Font_17;
        _buyNumLabel.textColor = COLOR_TEXT_BLACK;
        [self addSubview:_buyNumLabel];
    }
    return _buyNumLabel;
}

- (void)addNumAction:(UIButton *)btn {
    if ([self.numLabel.text integerValue] == 99) {
        [MKToastView showToastToView:self text:@"数量足够多啦~"];
    } else {
        self.numLabel.text = [NSString stringWithFormat:@"%ld",[self.numLabel.text integerValue] + 1];
    }
}

- (void)jianNumAction:(UIButton *)btn {
    if ([self.numLabel.text integerValue] == 1) {
        [MKToastView showToastToView:self text:@"不可以再减少了哦~"];
    } else {
        self.numLabel.text = [NSString stringWithFormat:@"%ld",[self.numLabel.text integerValue] - 1];
    }
}

- (UIButton *)jianBtn {
    if (! _jianBtn) {
        _jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jianBtn setTitle:@"-" forState:UIControlStateNormal];
        [_jianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _jianBtn.titleLabel.font = [UIFont systemFontOfSize:30.f];
        [_jianBtn addTarget:self action:@selector(jianNumAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_jianBtn];
    }
    return _jianBtn;
}

- (UIButton *)jiaBtn {
    if (! _jiaBtn) {
        _jiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jiaBtn setTitle:@"+" forState:UIControlStateNormal];
        [_jiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _jiaBtn.titleLabel.font = [UIFont systemFontOfSize:30.f];
        [_jiaBtn addTarget:self action:@selector(addNumAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_jiaBtn];
    }
    return _jiaBtn;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.text = @"1";
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.layer.borderColor = COLOR_GRAY_200.CGColor;
        _numLabel.layer.borderWidth = 1.f;
        _numLabel.layer.cornerRadius = 5.f;
        _numLabel.layer.masksToBounds = YES;
        [self addSubview:_numLabel];
    }
    return _numLabel;
}

- (UIButton *)confirmBtn {
    if (! _confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _confirmBtn.backgroundColor = COLOR_THEME_COLOR;
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateHighlighted];
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MKNSLog(@"点击了selectproductview");
}

@end
