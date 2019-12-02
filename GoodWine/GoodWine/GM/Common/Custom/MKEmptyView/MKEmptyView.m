//
//  MKEmptyView.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MKEmptyView.h"

@interface MKEmptyView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL needBtn;

@end

@implementation MKEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
//        self.hidden = YES;
    }
    return self;
}

- (void)showEmptyNeedLoadBtn:(BOOL)needBtn {
    self.hidden = NO;
    if (needBtn) {
        self.title = @"加载失败，点击重试~";
        
        [self setupConstraints];
        
        [self.loadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loadBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    } else {
        self.title = @"这里空空如也~";
        [self setupConstraints];
        [self.loadBtn setTitleColor:COLOR_GRAY_150 forState:UIControlStateNormal];
    }
    [self.loadBtn setTitle:self.title forState:UIControlStateNormal];
}

- (void)updateEmptyTitle:(NSString *)title {
    self.title = title;
    [self setupConstraints];
    [self.loadBtn setTitle:self.title forState:UIControlStateNormal];
}

- (void)setupConstraints {
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY).offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(150.f, 150.f));
    }];
    
    CGFloat width = [self.title widthStringWithFont:Font_15 height:40.f] + 40.f;
    [self.loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_centerY).offset(5.f);
        make.size.mas_equalTo(CGSizeMake(width, 40.f));
    }];
}

- (UIImageView *)emptyImageView {
    if (! _emptyImageView) {
        _emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"load_no"]];
        [self addSubview:_emptyImageView];
    }
    return _emptyImageView;
}

- (UIButton *)loadBtn {
    if (! _loadBtn) {
        _loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loadBtn.titleLabel.font = Font_15;
        [self addSubview:_loadBtn];
    }
    return _loadBtn;
}

@end
